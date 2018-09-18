//
//  startScreen.m
//  testEnvironment
//
//  Created by Alex Schiffman on 6/18/16.
//  Copyright © 2016 Alex Schiffman. All rights reserved.
//

#import "startScreen.h"
#import "GameScene.h"
#import "colorScreen.h"
#import <math.h>

@implementation startScreen {
    CGFloat xmax;
    CGFloat ymax;
    
    SKSpriteNode *start;
    SKSpriteNode *settings;
    
    UIColor *color;
}

-(void) didMoveToView:(SKView *)view    {
    
    xmax = self.frame.size.width;
    ymax = self.frame.size.height;
    
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
    
    SKLabelNode *title = [SKLabelNode labelNodeWithFontNamed:@"Arial"];
    title.text = [NSString stringWithFormat:@"BLOCK5"];
    double titleScalingFactor = xmax/3 / title.frame.size.width;
    title.fontSize *= titleScalingFactor;
    title.position = CGPointMake(xmax/2, ymax*9/16);
    [self addChild:title];

    
    start = [SKSpriteNode spriteNodeWithColor:color size:CGSizeMake(xmax/4, ymax/8)];
    CGPoint startPosition = CGPointMake(xmax*2/3, ymax*1/3);
    [start setPosition:startPosition];
    [start setZPosition:1];
    [self addChild:start];
    
    settings = [SKSpriteNode spriteNodeWithColor:color size:CGSizeMake(xmax/4, ymax/8)];
    CGPoint settingsPosition = CGPointMake(xmax*1/3, ymax*1/3);
    [settings setPosition:settingsPosition];
    [settings setZPosition:1];
    [self addChild:settings];
    
    SKLabelNode *startLabel = [SKLabelNode labelNodeWithFontNamed:@"Arial"];
    startLabel.text = [NSString stringWithFormat:@"Start"];
    double startScalingFactor = MIN(start.frame.size.width*3/4 / startLabel.frame.size.width, start.frame.size.height*3/4 / startLabel.frame.size.height);
    startLabel.fontSize *= startScalingFactor;
    startLabel.position = CGPointMake(startPosition.x, startPosition.y-startLabel.frame.size.height*7/16);
    [startLabel setZPosition:2];
    [self addChild:startLabel];

    SKLabelNode *settingsLabel = [SKLabelNode labelNodeWithFontNamed:@"Arial"];
    settingsLabel.text = [NSString stringWithFormat:@"Colors"];
    double settingsScalingFactor = MIN(settings.frame.size.width*3/4 / settingsLabel.frame.size.width, settings.frame.size.height*3/4 / settingsLabel.frame.size.height);
    settingsLabel.fontSize *= settingsScalingFactor;
    settingsLabel.position = CGPointMake(settingsPosition.x, settingsPosition.y-settingsLabel.frame.size.height*7/16);
    [settingsLabel setZPosition:2];
    [self addChild:settingsLabel];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        if (CGRectContainsPoint(start.frame, location)) {
            SKScene * scene = [GameScene sceneWithSize:self.size];
            scene.scaleMode = SKSceneScaleModeAspectFill;
            [self.view presentScene:scene];
            
        }
        if (CGRectContainsPoint(settings.frame, location)) {
            SKScene * scene = [colorScreen sceneWithSize:self.size];
            scene.scaleMode = SKSceneScaleModeAspectFill;
            [self.view presentScene:scene];
            
        }
    }
}



@end
