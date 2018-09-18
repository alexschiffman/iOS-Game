//
//  lossScreen.m
//  testEnvironment
//
//  Created by Alex Schiffman on 6/18/16.
//  Copyright © 2016 Alex Schiffman. All rights reserved.
//

#import "lossScreen.h"
#import "GameScene.h"
#import "startScreen.h"
#import <SpriteKit/SpriteKit.h>

//@interface lossScreen ()
//@end

@implementation lossScreen  {
    SKSpriteNode *restart;
    SKSpriteNode *home;
    
    CGFloat xmax;
    CGFloat ymax;
    
    UIColor *color;
}

-(void)didMoveToView:(SKView *)view {
    xmax = self.frame.size.width;
    ymax = self.frame.size.height;
    
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
        
    //NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    double highscore = [userDefaults doubleForKey:@"highscore"];
    double time = [userDefaults doubleForKey:@"time"];
    
    SKLabelNode *label = [SKLabelNode labelNodeWithFontNamed:@"Arial"];
    label.text = [NSString stringWithFormat:@"Time: %0.2f, Best: %0.2f", time, highscore];
    double labelScalingFactor = MIN(xmax/2 / label.frame.size.width, ymax/2 / label.frame.size.height);
    label.fontSize *= labelScalingFactor;
    label.position = CGPointMake(xmax/2, ymax*5/8-label.frame.size.height/2);
    [self addChild:label];
    
    restart = [SKSpriteNode spriteNodeWithColor:color size:CGSizeMake(xmax/4, ymax/8)];
    CGPoint restartPosition = CGPointMake(xmax*2/3, ymax*7/16);
    [restart setPosition:restartPosition];
    [restart setZPosition:1];
    [self addChild:restart];
    
    SKLabelNode *restartLabel = [SKLabelNode labelNodeWithFontNamed:@"Arial"];
    restartLabel.text = [NSString stringWithFormat:@"Restart"];
    double restartScalingFactor = MIN(restart.frame.size.width*3/4 / restartLabel.frame.size.width, restart.frame.size.height*3/4 / restartLabel.frame.size.height);
    restartLabel.fontSize *= restartScalingFactor;
    restartLabel.position = CGPointMake(restartPosition.x, restartPosition.y-restartLabel.frame.size.height*7/16);
    [restartLabel setZPosition:2];
    [self addChild:restartLabel];
    
    home = [SKSpriteNode spriteNodeWithColor:color size:CGSizeMake(xmax/4, ymax/8)];
    CGPoint homePosition = CGPointMake(xmax/3, ymax*7/16);
    [home setPosition:homePosition];
    [home setZPosition:1];
    [self addChild:home];
    
    SKLabelNode *homeLabel = [SKLabelNode labelNodeWithFontNamed:@"Arial"];
    homeLabel.text = [NSString stringWithFormat:@"Home"];
    double homeScalingFactor = MIN(home.frame.size.width*5/8 / homeLabel.frame.size.width, home.frame.size.height*5/8 / homeLabel.frame.size.height);
    homeLabel.fontSize *= homeScalingFactor;
    homeLabel.position = CGPointMake(homePosition.x, homePosition.y-homeLabel.frame.size.height*7/16);
    [homeLabel setZPosition:2];
    [self addChild:homeLabel];
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        if (CGRectContainsPoint(restart.frame, location)) {
            SKScene * scene = [GameScene sceneWithSize:self.size];
            scene.scaleMode = SKSceneScaleModeAspectFill;
            [self.view presentScene:scene];

        }
        
        if (CGRectContainsPoint(home.frame, location)) {
            SKScene * scene = [startScreen sceneWithSize:self.size];
            scene.scaleMode = SKSceneScaleModeAspectFill;
            [self.view presentScene:scene];
        }
    }
}



@end
