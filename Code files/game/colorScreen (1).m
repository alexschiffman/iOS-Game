//
//  colorScreen.m
//  testEnvironment
//
//  Created by Alex Schiffman on 7/28/16.
//  Copyright © 2016 Alex Schiffman. All rights reserved.
//

#import "colorScreen.h"
#import "startScreen.h"
#import <SpriteKit/SpriteKit.h>

@implementation colorScreen
{
    CGFloat xmax;
    CGFloat ymax;
    
    UIColor *color;
    int selection;
}

-(void)didMoveToView:(SKView *)view {
    
    xmax = self.frame.size.width;
    ymax = self.frame.size.height;
    
    [self setBackgroundColor:[UIColor grayColor]];
    
    self.targets = [[NSMutableArray alloc] init];

    self.frames = [[NSMutableArray alloc] init];
    for(int i = 8; i > 2; i--)
    {
        SKSpriteNode *colorFrame = [SKSpriteNode spriteNodeWithColor:[UIColor grayColor] size:CGSizeMake(xmax/14, ymax/16)];
        [colorFrame setPosition:CGPointMake(xmax/2, ymax*i/11)];
        [colorFrame setZPosition:1];
        [self.frames addObject:colorFrame];
        [self addChild:colorFrame];
    }
    
    SKSpriteNode *right = [SKSpriteNode spriteNodeWithColor: [UIColor clearColor] size:CGSizeMake(xmax/8, ymax)];
    [right setPosition:CGPointMake(xmax*7/8+xmax/16, ymax/2)];
    _right = right;
    [self addChild:right];
    
    SKSpriteNode *center = [SKSpriteNode spriteNodeWithColor: [UIColor clearColor] size:CGSizeMake(xmax/8, ymax*9/11)];
    [center setPosition:CGPointMake(xmax/2, ymax/2-ymax*1/11)];
    _center = center;
    [self addChild:center];
    
    SKSpriteNode *top = [SKSpriteNode spriteNodeWithColor: [UIColor clearColor] size:CGSizeMake(xmax, ymax*1/11)];
    [top setPosition:CGPointMake(xmax/2, ymax*37/44)];
    _top = top;
    [self addChild:top];
    
    SKSpriteNode *left = [SKSpriteNode spriteNodeWithColor: [UIColor clearColor] size:CGSizeMake(xmax/8, ymax)];
    [left setPosition:CGPointMake(xmax/16, ymax/2)];
    _left = left;
    [self addChild:left];
    
    SKSpriteNode *target1 = [SKSpriteNode spriteNodeWithColor: [UIColor clearColor] size:CGSizeMake(xmax/50,ymax/10)];
    [target1 setPosition:CGPointMake(xmax/20*12 , ymax/20*13)];
    [self.targets addObject:target1];
    [self addChild:target1];
    
    SKSpriteNode *target2 = [SKSpriteNode spriteNodeWithColor: [UIColor clearColor] size:CGSizeMake(xmax/50,ymax/10)];
    [target2 setPosition:CGPointMake(xmax/20*14 , ymax/20*7)];
    [target2 setZPosition:20];
    [self.targets addObject:target2];
    [self addChild:target2];
    
    SKSpriteNode *target3 = [SKSpriteNode spriteNodeWithColor: [UIColor clearColor] size:CGSizeMake(xmax/50,ymax/10)];
    [target3 setPosition:CGPointMake(xmax/20*16 , ymax/20*11)];
    [self.targets addObject:target3];
    [self addChild:target3];
    
    SKSpriteNode *target4 = [SKSpriteNode spriteNodeWithColor: [UIColor clearColor] size:CGSizeMake(xmax/50,ymax/10)];
    [target4 setPosition:CGPointMake(xmax/20*4 , ymax/20*12)];
    [self.targets addObject:target4];
    [self addChild:target4];
    
    SKSpriteNode *target5 = [SKSpriteNode spriteNodeWithColor: [UIColor clearColor] size:CGSizeMake(xmax/50,ymax/10)];
    [target5 setPosition:CGPointMake(xmax/20*6 , ymax/20*5)];
    [target5 setZPosition:20];
    [self.targets addObject:target5];
    [self addChild:target5];
    
    SKSpriteNode *target6 = [SKSpriteNode spriteNodeWithColor: [UIColor clearColor] size:CGSizeMake(xmax/50,ymax/10)];
    [target6 setPosition:CGPointMake(xmax/20*8 , ymax/20*6)];
    [self.targets addObject:target6];
    [self addChild:target6];
    
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    int colorChoice = [userDefaults integerForKey:@"colorChoice"];
    selection = colorChoice;
    [self chooseColor];
    
    SKLabelNode *colorsLabel = [SKLabelNode labelNodeWithFontNamed:@"Arial"];
    colorsLabel.text = [NSString stringWithFormat:@"Choose a color:"];
    double labelScalingFactor = MIN(xmax/4 / colorsLabel.frame.size.width, ymax/16 / colorsLabel.frame.size.height);
    colorsLabel.fontSize *= labelScalingFactor;
    colorsLabel.position = CGPointMake(xmax/2, ymax*9/11-colorsLabel.frame.size.height/4);
    [colorsLabel setZPosition:2];
    [self addChild:colorsLabel];

    
    SKSpriteNode *cyanButton = [SKSpriteNode spriteNodeWithColor:[UIColor cyanColor] size:CGSizeMake(xmax/16, ymax/20)];
    [cyanButton setPosition:CGPointMake(xmax/2, ymax*8/11)];
    [cyanButton setZPosition:2];
    _cyanButton = cyanButton;
    [self addChild:cyanButton];
    
    SKSpriteNode *orangeButton = [SKSpriteNode spriteNodeWithColor:[UIColor orangeColor] size:CGSizeMake(xmax/16, ymax/20)];
    [orangeButton setPosition:CGPointMake(xmax/2, ymax*7/11)];
    [orangeButton setZPosition:2];
    _orangeButton = orangeButton;
    [self addChild:orangeButton];
    
    SKSpriteNode *blueButton = [SKSpriteNode spriteNodeWithColor:[UIColor blueColor] size:CGSizeMake(xmax/16, ymax/20)];
    [blueButton setPosition:CGPointMake(xmax/2, ymax*6/11)];
    [blueButton setZPosition:2];
    _blueButton = blueButton;
    [self addChild:blueButton];
    
    SKSpriteNode *redButton = [SKSpriteNode spriteNodeWithColor:[UIColor redColor] size:CGSizeMake(xmax/16, ymax/20)];
    [redButton setPosition:CGPointMake(xmax/2, ymax*5/11)];
    [redButton setZPosition:2];
    _redButton = redButton;
    [self addChild:redButton];
    
    SKSpriteNode *greenButton = [SKSpriteNode spriteNodeWithColor:[UIColor greenColor] size:CGSizeMake(xmax/16, ymax/20)];
    [greenButton setPosition:CGPointMake(xmax/2, ymax*4/11)];
    [greenButton setZPosition:2];
    _greenButton = greenButton;
    [self addChild:greenButton];
    
    SKSpriteNode *magentaButton = [SKSpriteNode spriteNodeWithColor:[UIColor magentaColor] size:CGSizeMake(xmax/16, ymax/20)];
    [magentaButton setPosition:CGPointMake(xmax/2, ymax*3/11)];
    [magentaButton setZPosition:2];
    _magentaButton = magentaButton;
    [self addChild:magentaButton];
    
    SKSpriteNode *saveButton = [SKSpriteNode spriteNodeWithColor:[UIColor grayColor] size:CGSizeMake(xmax/10, ymax/16)];
    [saveButton setPosition:CGPointMake(xmax/2, ymax*2/11)];
    [saveButton setZPosition:2];
    _saveButton = saveButton;
    [self addChild:saveButton];
    
    SKLabelNode *saveText = [SKLabelNode labelNodeWithFontNamed:@"Arial"];
    saveText.text = [NSString stringWithFormat:@"Save"];
    double saveScalingFactor = MIN(saveButton.frame.size.width*3/4 / saveText.frame.size.width, saveButton.frame.size.height*3/4 / saveText.frame.size.height);
    saveText.fontSize *= saveScalingFactor;
    saveText.position = CGPointMake(saveButton.position.x, saveButton.position.y-saveButton.frame.size.height/4);
    [saveText setZPosition:3];
    _saveText = saveText;
    [self addChild:saveText];
    
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    for (UITouch *touch in touches)
    {
        CGPoint location = [touch locationInNode:self];
        
        if (CGRectContainsPoint(_cyanButton.frame, location))
        {
            selection = 0;
            for (int i = 0; i < _frames.count; i++)
            {
                SKSpriteNode *frame = _frames[i];
                frame.color = [UIColor grayColor];
            }
            [self chooseColor];
        }
        if (CGRectContainsPoint(_orangeButton.frame, location))
        {
            selection = 1;
            for (int i = 0; i < _frames.count; i++)
            {
                SKSpriteNode *frame = _frames[i];
                frame.color = [UIColor grayColor];
            }
            [self chooseColor];
        }
        if (CGRectContainsPoint(_blueButton.frame, location))
        {
            selection = 2;
            for (int i = 0; i < _frames.count; i++)
            {
                SKSpriteNode *frame = _frames[i];
                frame.color = [UIColor grayColor];
            }
            [self chooseColor];
        }
        if (CGRectContainsPoint(_redButton.frame, location))
        {
            selection = 3;
            for (int i = 0; i < _frames.count; i++)
            {
                SKSpriteNode *frame = _frames[i];
                frame.color = [UIColor grayColor];
            }
            [self chooseColor];
        }
        if (CGRectContainsPoint(_greenButton.frame, location))
        {
            selection = 4;
            for (int i = 0; i < _frames.count; i++)
            {
                SKSpriteNode *frame = _frames[i];
                frame.color = [UIColor grayColor];
            }
            [self chooseColor];
        }
        if (CGRectContainsPoint(_magentaButton.frame, location))
        {
            selection = 5;
            for (int i = 0; i < _frames.count; i++)
            {
                SKSpriteNode *frame = _frames[i];
                frame.color = [UIColor grayColor];
            }
            [self chooseColor];
        }
        
        if (CGRectContainsPoint(_saveButton.frame, location))
        {
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            [userDefaults setInteger:selection forKey:@"colorChoice"];
            
            SKScene * scene = [startScreen sceneWithSize:self.size];
            scene.scaleMode = SKSceneScaleModeAspectFill;
            [self.view presentScene:scene];
        }
    }
}

-(void)chooseColor {
    if(selection == 0)
    {
        color = [UIColor cyanColor];
        _right.color = color;
        _center.color = color;
        _top.color = color;
        _left.color = color;
        SKSpriteNode *frame0 = _frames[0];
        frame0.color = [UIColor whiteColor];
        for (int i = 0; i < _targets.count; i++)
        {
            SKSpriteNode *target = _targets[i];
            target.color = color;
        }

    }
    else if(selection == 1)
    {
        color = [UIColor orangeColor];
        _right.color = color;
        _center.color = color;
        _top.color = color;
        _left.color = color;
        SKSpriteNode *frame1 = _frames[1];
        frame1.color = [UIColor whiteColor];
        for (int i = 0; i < _targets.count; i++)
        {
            SKSpriteNode *target = _targets[i];
            target.color = color;
        }

    }
    else if(selection == 2)
    {
        color = [UIColor blueColor];
        _right.color = color;
        _center.color = color;
        _top.color = color;
        _left.color = color;
        SKSpriteNode *frame2 = _frames[2];
        frame2.color = [UIColor whiteColor];
        for (int i = 0; i < _targets.count; i++)
        {
            SKSpriteNode *target = _targets[i];
            target.color = color;
        }

    }
    else if(selection == 3)
    {
        color = [UIColor redColor];
        _right.color = color;
        _center.color = color;
        _top.color = color;
        _left.color = color;
        SKSpriteNode *frame3 = _frames[3];
        frame3.color = [UIColor whiteColor];
        for (int i = 0; i < _targets.count; i++)
        {
            SKSpriteNode *target = _targets[i];
            target.color = color;
        }

    }
    else if(selection == 4)
    {
        color = [UIColor greenColor];
        _right.color = color;
        _center.color = color;
        _top.color = color;
        _left.color = color;
        SKSpriteNode *frame4 = _frames[4];
        frame4.color = [UIColor whiteColor];
        for (int i = 0; i < _targets.count; i++)
        {
            SKSpriteNode *target = _targets[i];
            target.color = color;
        }

    }
    else if(selection == 5)
    {
        color = [UIColor magentaColor];
        _right.color = color;
        _center.color = color;
        _top.color = color;
        _left.color = color;
        SKSpriteNode *frame5 = _frames[5];
        frame5.color = [UIColor whiteColor];
        for (int i = 0; i < _targets.count; i++)
        {
            SKSpriteNode *target = _targets[i];
            target.color = color;
        }

    }
    else
    {
        color = [UIColor cyanColor];
        _right.color = color;
        _center.color = color;
        _top.color = color;
        _left.color = color;
        SKSpriteNode *frameDefault = _frames[0];
        frameDefault.color = [UIColor whiteColor];
        for (int i = 0; i < _targets.count; i++)
        {
            SKSpriteNode *target = _targets[i];
            target.color = color;
        }

    }
}

@end
