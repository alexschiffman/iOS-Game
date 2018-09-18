//
//  GameScene.m
//  testEnvironment
//
//  Created by Alex Schiffman on 6/12/16.
//  Copyright (c) 2016 Alex Schiffman. All rights reserved.
//

#import "GameScene.h"
#import "startScreen.h"
#import "lossScreen.h"
#import "pausedScreen.h"

#import <math.h>

@implementation GameScene
{
    int lives;
    double time;
    BOOL firstRun;
    BOOL isPaused;
    double lastSpawnTime;
    double _lastTime;
    SKLabelNode *livesLabel;
    SKLabelNode *timeLabel;
    double speed;
    float interval;
    CGFloat xmax;
    CGFloat ymax;
    int spawnedTargets;
    int targetSpeed;
    BOOL restartHasBeenPressed;
    BOOL exitHasBeenPressed;
    UIColor *color;
}

-(void)didMoveToView:(SKView *)view {

    firstRun = YES;
    isPaused = NO;
    
    xmax = self.frame.size.width;
    ymax = self.frame.size.height;
    
    self.targetsright = [[NSMutableArray alloc] init];
    self.targetsleft = [[NSMutableArray alloc] init];
    
    self.targetStatesRight = [[NSMutableArray alloc] init]; //// used to record the velocities of targets when the game is paused
    self.targetStatesLeft = [[NSMutableArray alloc] init];  //
    
    [self setBackgroundColor:[UIColor grayColor]];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    int colorChoice = [userDefaults integerForKey:@"colorChoice"];
    switch (colorChoice) {
        case 0:
            color = [UIColor cyanColor];
            break;
        case 1:
            color = [UIColor orangeColor];
            break;
        case 2:
            color = [UIColor blueColor];
            break;
        case 3:
            color = [UIColor redColor];
            break;
        case 4:
            color = [UIColor greenColor];
            break;
        case 5:
            color = [UIColor magentaColor];
            break;
        default:
            color = [UIColor cyanColor];
            break;
    }

    SKSpriteNode *beamright = [SKSpriteNode spriteNodeWithColor:[UIColor whiteColor] size:CGSizeMake(xmax/50, ymax/100)];
    [beamright setPosition:CGPointMake(xmax*2,ymax*2)];
    [beamright setZPosition:3];
    beamright.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:beamright.frame];
    beamright.physicsBody.velocity = CGVectorMake(-2000, 0);
    _beamright = beamright;
    [self addChild:_beamright];
    
    SKSpriteNode *beamleft = [SKSpriteNode spriteNodeWithColor:[UIColor whiteColor] size:CGSizeMake(xmax/50, ymax/100)];
    [beamleft setPosition:CGPointMake(xmax*2,ymax*2)];
    [beamleft setZPosition:3];
    beamleft.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:beamleft.frame];
    beamleft.physicsBody.velocity = CGVectorMake(2000, 0);
    _beamleft = beamleft;
    [self addChild:_beamleft];
    
    SKSpriteNode *right = [SKSpriteNode spriteNodeWithColor:color size:CGSizeMake(xmax/8, ymax)];
    [right setPosition:CGPointMake(xmax*7/8+xmax/16, ymax/2)];
    _right = right;
    [self addChild:right];
    
    SKSpriteNode *center = [SKSpriteNode spriteNodeWithColor:color size:CGSizeMake(xmax/8, ymax)];
    [center setPosition:CGPointMake(xmax/2, ymax/2)];
    _center = center;
    [self addChild:center];
    
    SKSpriteNode *left = [SKSpriteNode spriteNodeWithColor:color size:CGSizeMake(xmax/8, ymax)];
    [left setPosition:CGPointMake(xmax/16, ymax/2)];
    _left = left;
    [self addChild:left];
    
    lives = 5;///////////////////////////////////////////////////////////////// lives #
    SKLabelNode *livesDisplay = [SKLabelNode labelNodeWithFontNamed:@"Arial"];
    livesDisplay.text = [NSString stringWithFormat:@"%d", lives];
    double livesScalingFactor = MIN(xmax/16 / livesDisplay.frame.size.width, ymax/16 / livesDisplay.frame.size.height);
    livesDisplay.fontSize *= livesScalingFactor;
    livesDisplay.position = CGPointMake(xmax/2, ymax*3/5-livesDisplay.frame.size.height/2);
    [livesDisplay setZPosition:2];
    _livesDisplay = livesDisplay;
    [self addChild:livesDisplay];
    
    time = 0;

    SKLabelNode *timeDisplay = [SKLabelNode labelNodeWithFontNamed:@"Arial"];
    timeDisplay.text = [NSString stringWithFormat:@"%0.2f", time];
    double timeScalingFactor = MIN(xmax/16 / timeDisplay.frame.size.width, ymax/16 / timeDisplay.frame.size.height);
    timeDisplay.fontSize *= timeScalingFactor;
    timeDisplay.position = CGPointMake(xmax/2, ymax*2/5-timeDisplay.frame.size.height/2);
    [timeDisplay setZPosition:2];
    _timeDisplay = timeDisplay;
    [self addChild:timeDisplay];
    
    SKSpriteNode *pauseButton = [SKSpriteNode spriteNodeWithColor:[UIColor grayColor] size:CGSizeMake(xmax/12, ymax/20)];
    [pauseButton setPosition:CGPointMake(xmax/2, ymax*3/4)];
    [pauseButton setZPosition:2];
    _pauseButton = pauseButton;
    [self addChild:pauseButton];
    
    SKLabelNode *pauseText = [SKLabelNode labelNodeWithFontNamed:@"Arial"];
    pauseText.text = [NSString stringWithFormat:@"Pause"];
    double pauseScalingFactor = MIN(pauseButton.frame.size.width*3/4 / pauseText.frame.size.width, pauseButton.frame.size.height*3/4 / pauseText.frame.size.height);
    pauseText.fontSize *= pauseScalingFactor;
    pauseText.position = CGPointMake(pauseButton.position.x, pauseButton.position.y-pauseButton.frame.size.height/4);
    [pauseText setZPosition:3];
    _pauseText = pauseText;
    [self addChild:pauseText];
    
    spawnedTargets = (arc4random_uniform(2)) + 1; //right or left?
    lastSpawnTime = 0;
    [self setInterval];
    
}

-(void)setInterval {
    if(time < 100)
    {
        interval = -0.001*time+0.45;
    }
    else
    {
        interval = 0.35;
    }
}

-(void)spawnTarget {
    if(time < 100)
    {
        targetSpeed = -0.5*time+110;
    }
    else
    {
        targetSpeed = 60;
    }
    
    if((spawnedTargets%2)==0)
    {
        SKSpriteNode *targetRight = [SKSpriteNode spriteNodeWithColor:color size:CGSizeMake(xmax/50,ymax/10)];
        targetRight.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:targetRight.frame];
        targetRight.physicsBody.velocity = CGVectorMake(targetSpeed, 0);
        float randomYStartingPosition = (arc4random() % 60) + 20;
        [targetRight setPosition:CGPointMake(xmax/2 , randomYStartingPosition*ymax/100)];
        [targetRight setZPosition:1];
        [self.targetsright addObject:targetRight];
        [self addChild:targetRight];
    }
    else
    {
        SKSpriteNode *targetLeft = [SKSpriteNode spriteNodeWithColor:color size:CGSizeMake(xmax/50,ymax/10)];
        targetLeft.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:targetLeft.frame];
        targetLeft.physicsBody.velocity = CGVectorMake(-targetSpeed, 0);
        float randomYStartingPosition1 = (arc4random() % 60) + 20;
        [targetLeft setPosition:CGPointMake(xmax/2 , randomYStartingPosition1*ymax/100)];
        [targetLeft setZPosition:1];
        [self.targetsleft addObject:targetLeft];
        [self addChild:targetLeft];
    }
    spawnedTargets++;
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    for (UITouch *touch in touches)
    {
        CGPoint location = [touch locationInNode:self];
        if(!isPaused)
        {
            if (CGRectContainsPoint(_right.frame, location))
            {
                [_beamright setPosition: location];
            }
            if (CGRectContainsPoint(_left.frame, location))
            {
                [_beamleft setPosition: location];
            }
        }
        
        if (CGRectContainsPoint(_pauseButton.frame, location))
        {
            [self pauseGame];
        }
        if (CGRectContainsPoint(_restartButton.frame, location))
        {
            if(!restartHasBeenPressed)
            {
                if(exitHasBeenPressed)
                {
                    _exitButtonText.text = [NSString stringWithFormat:@"Exit"];
                    exitHasBeenPressed = NO;
                }
                _restartButtonText.text = [NSString stringWithFormat:@"Restart?"];
                restartHasBeenPressed = YES;
            }
            else
            {
                SKScene * scene = [GameScene sceneWithSize:self.size];
                scene.scaleMode = SKSceneScaleModeAspectFill;
                [self.view presentScene:scene]; //restart the game
            }
        }
        if (CGRectContainsPoint(_exitButton.frame, location))
        {
            if(!exitHasBeenPressed)
            {
                if(restartHasBeenPressed)
                {
                    _restartButtonText.text = [NSString stringWithFormat:@"Restart"];
                    restartHasBeenPressed = NO;
                }
                _exitButtonText.text = [NSString stringWithFormat:@"Exit?"];
                exitHasBeenPressed = YES;
            }
            else
            {
                SKScene * scene = [startScreen sceneWithSize:self.size];
                scene.scaleMode = SKSceneScaleModeAspectFill;
                [self.view presentScene:scene]; //go to start screen
            }
        }
    }
}

-(void)checkCollisions  {
    // RIGHT:
    for (int i = 0; i < _targetsright.count; i++)
    {
        SKSpriteNode *targetRight = _targetsright[i];
        if (CGRectIntersectsRect(targetRight.frame, _beamright.frame))
        {
            //NSLog(@"Hit!");
            [targetRight setPosition:CGPointMake(xmax*2,ymax*2)];
            [targetRight removeFromParent];
            [_beamright setPosition:CGPointMake(xmax*2,ymax*2)];
            //NSLog(@"Moved!");
        }
    }
    if (CGRectIntersectsRect(_beamright.frame, _center.frame))
    {
        //NSLog(@"%d", lives);
        //NSLog(@"Miss!");
        lives--;
        [_beamright setPosition:CGPointMake(xmax*2,ymax*2)];
        //NSLog(@"%d", lives);
    }
    for (SKSpriteNode *targetRight in self.targetsright)
    {
        if (CGRectIntersectsRect(targetRight.frame, _right.frame))
        {
            //NSLog(@"side collision");
            lives--;
            [targetRight setPosition:CGPointMake(xmax*2,ymax*2)];
            [targetRight removeFromParent];
        }
    }
    // LEFT:
    for (int i = 0; i < _targetsleft.count; i++)
    {
        SKSpriteNode *targetLeft = _targetsleft[i];
        if (CGRectIntersectsRect(targetLeft.frame, _beamleft.frame))
        {
            //NSLog(@"Hit!");
            [targetLeft setPosition:CGPointMake(xmax*2,ymax*2)];
            [targetLeft removeFromParent];
            [_beamleft setPosition:CGPointMake(xmax*2,ymax*2)];
            //NSLog(@"Moved!");
        }
    }
    if (CGRectIntersectsRect(_beamleft.frame, _center.frame))
    {
        //NSLog(@"%d", lives);
        //NSLog(@"Miss!");
        lives--;
        [_beamleft setPosition:CGPointMake(xmax*2,ymax*2)];
        //NSLog(@"%d", lives);
    }
    for (SKSpriteNode *targetLeft in self.targetsleft)
    {
        if (CGRectIntersectsRect(targetLeft.frame, _left.frame))
        {
            //NSLog(@"side collision");
            lives--;
            [targetLeft setPosition:CGPointMake(xmax*2,ymax*2)];
            [targetLeft removeFromParent];
        }
    }
}

-(void)pauseGame {
    if (isPaused == NO)
    {
        isPaused = YES;
        
        // record target velocities:
        for (int i = 0; i < _targetsright.count; i++)
        {
            SKSpriteNode *targetRight = _targetsright[i];
            SKSpriteNode *velocityRight = [SKSpriteNode spriteNodeWithColor:[UIColor clearColor] size:CGSizeMake(xmax/50,ymax/10)];
            velocityRight.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:velocityRight.frame];
            velocityRight.physicsBody.velocity = targetRight.physicsBody.velocity;
            [self.targetStatesRight addObject:velocityRight];
        }
        for (int i = 0; i < _targetsleft.count; i++)
        {
            SKSpriteNode *targetLeft = _targetsleft[i];
            SKSpriteNode *velocityLeft = [SKSpriteNode spriteNodeWithColor:[UIColor clearColor] size:CGSizeMake(xmax/50,ymax/10)];
            velocityLeft.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:velocityLeft.frame];
            velocityLeft.physicsBody.velocity = targetLeft.physicsBody.velocity;
            [self.targetStatesLeft addObject:velocityLeft];
        }
        // set target velocities to 0:
        for (int i = 0; i < _targetsright.count; i++)
        {
            SKSpriteNode *targetRight = _targetsright[i];
            targetRight.physicsBody.velocity = CGVectorMake(0, 0);
        }
        for (int i = 0; i < _targetsleft.count; i++)
        {
            SKSpriteNode *targetLeft = _targetsleft[i];
            targetLeft.physicsBody.velocity = CGVectorMake(0, 0);
        }
        
        SKSpriteNode *pauseScreen = [SKSpriteNode spriteNodeWithColor:[UIColor grayColor] size:CGSizeMake(xmax,ymax)];
        pauseScreen.position = CGPointMake(xmax/2, ymax/2);
        [pauseScreen setZPosition:20];
        [pauseScreen setAlpha:0.5];
        _pauseScreen = pauseScreen;
        [self addChild:pauseScreen];
        
        _pauseButton.size = CGSizeMake(xmax/10, ymax/12);
        _pauseText.text = [NSString stringWithFormat:@"Resume"];
        _pauseText.fontName = [NSString stringWithFormat:@"Arial Bold"];
        [_pauseButton setZPosition:21];
        [_pauseText setZPosition:22];
        
        SKSpriteNode *restartButton = [SKSpriteNode spriteNodeWithColor:[UIColor grayColor] size:CGSizeMake(xmax/10, ymax/12)];
        restartButton.position = CGPointMake(xmax/2, ymax/2);
        [restartButton setZPosition:21];
        _restartButton = restartButton;
        [self addChild:restartButton];
        
        SKLabelNode *restartButtonText = [SKLabelNode labelNodeWithFontNamed:@"Arial"];
        restartButtonText.text = [NSString stringWithFormat:@"Restart"];
        double restartScalingFactor = MIN(restartButton.frame.size.width*3/4 / restartButtonText.frame.size.width, restartButton.frame.size.height*3/4 / restartButtonText.frame.size.height);
        restartButtonText.fontSize *= restartScalingFactor;
        restartButtonText.position = CGPointMake(restartButton.position.x, restartButton.position.y-restartButtonText.frame.size.height/2);
        [restartButtonText setZPosition:22];
        _restartButtonText = restartButtonText;
        [self addChild:restartButtonText];
        
        restartHasBeenPressed = NO;
        
        SKSpriteNode *exitButton = [SKSpriteNode spriteNodeWithColor:[UIColor grayColor] size:CGSizeMake(xmax/10, ymax/12)];
        exitButton.position = CGPointMake(xmax/2, ymax/4);
        [exitButton setZPosition:21];
        _exitButton = exitButton;
        [self addChild:exitButton];
        
        SKLabelNode *exitButtonText = [SKLabelNode labelNodeWithFontNamed:@"Arial"];
        exitButtonText.text = [NSString stringWithFormat:@"Exit"];
        double exitScalingFactor = MIN(exitButton.frame.size.width*3/4 / exitButtonText.frame.size.width, exitButton.frame.size.height/2 / exitButtonText.frame.size.height);
        exitButtonText.fontSize *= exitScalingFactor;
        exitButtonText.position = CGPointMake(exitButton.position.x, exitButton.position.y-exitButton.frame.size.height/4);
        [exitButtonText setZPosition:22];
        _exitButtonText = exitButtonText;
        [self addChild:exitButtonText];
        
        exitHasBeenPressed = NO;
        
    }
    else
    {
        [_pauseScreen removeFromParent];
        [_restartButton removeFromParent];
        [_exitButton removeFromParent];
        [_restartButtonText removeFromParent];
        [_exitButtonText removeFromParent];
        
        _pauseButton.size = CGSizeMake(xmax/12, ymax/20);
        _pauseText.text = [NSString stringWithFormat:@"Pause"];
        _pauseText.fontName = [NSString stringWithFormat:@"Arial"];
        [_pauseButton setZPosition:2];
        [_pauseText setZPosition:3];
        
        // return the targets to their original velocities:
        for (int i = 0; i < _targetsright.count; i++)
        {
            SKSpriteNode *targetRight = _targetsright[i];
            for (int j = 0; j < _targetStatesRight.count; j++)
            {
                SKSpriteNode *velocityRight = _targetStatesRight[i];
                targetRight.physicsBody.velocity = velocityRight.physicsBody.velocity;
            }
        }
        for (int i = 0; i < _targetsleft.count; i++)
        {
            SKSpriteNode *targetLeft = _targetsleft[i];
            for (int j = 0; j < _targetStatesLeft.count; j++)
            {
                SKSpriteNode *velocityLeft = _targetStatesLeft[i];
                targetLeft.physicsBody.velocity = velocityLeft.physicsBody.velocity;
            }
        }
        isPaused = NO;
        _lastTime = (double)CFAbsoluteTimeGetCurrent();
    }
}

-(void)update:(CFTimeInterval)currentTime {
    
    if(!isPaused)
    {
        double newTime = (double)CFAbsoluteTimeGetCurrent();
        if(firstRun)
        {
            _lastTime = newTime;
            firstRun = NO;
        }
        CGFloat dt = newTime-_lastTime;
        _lastTime=newTime;
        time+=dt;

        _timeDisplay.text = [NSString stringWithFormat:@"%0.2f", time];

        if(time > lastSpawnTime + interval)
        {
            [self setInterval];
            lastSpawnTime = time;
            [self spawnTarget];
        }
    }
    
    [self checkCollisions];
    if (lives < 1)
    {
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setDouble:time forKey:@"time"];
        double highscore = [userDefaults doubleForKey:@"highscore"];
        if (time > highscore)
        {
            highscore = time;
        }
        [userDefaults setDouble:highscore forKey:@"highscore"];
        
        SKTransition *reveal = [SKTransition crossFadeWithDuration:1];
        SKScene *newScene = [[lossScreen alloc] initWithSize: CGSizeMake(xmax, ymax)];
        [self.scene.view presentScene: newScene transition: reveal];
    }
    _livesDisplay.text = [NSString stringWithFormat:@"%d", lives];
}



@end
