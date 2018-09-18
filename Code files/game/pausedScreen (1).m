//
//  pausedScreen.m
//  testEnvironment
//
//  Created by Alex Schiffman on 9/2/16.
//  Copyright © 2016 Alex Schiffman. All rights reserved.
//

#import "pausedScreen.h"
#import "GameScene.h"

@implementation pausedScreen

-(void)setReturnScene:(SKScene *)otherScene
{
    _returnScene = otherScene;
}

-(void)didMoveToView:(SKView *)view {
    
    CGFloat xmax = self.frame.size.width;
    CGFloat ymax = self.frame.size.height;
    
    [self setBackgroundColor:[UIColor grayColor]];
    
    SKLabelNode *unpauseButton = [SKLabelNode labelNodeWithFontNamed:@"Arial"];
    unpauseButton.text = [NSString stringWithFormat:@"Unpause"];
    double unpauseScalingFactor = MIN(xmax/8 / unpauseButton.frame.size.width, ymax/8 / unpauseButton.frame.size.height);
    unpauseButton.fontSize *= unpauseScalingFactor;
    unpauseButton.position = CGPointMake(xmax/2, ymax/2-unpauseButton.frame.size.height/2);
    [unpauseButton setZPosition:2];
    _unpauseButton = unpauseButton;
    [self addChild:unpauseButton];
    
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
   
        if (CGRectContainsPoint(_unpauseButton.frame, location)) {
            
            __weak typeof(self) weakMe = self;
            [weakMe.view presentScene:self.returnScene];
        }
        
    }
}

@end
