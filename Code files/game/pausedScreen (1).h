//
//  pausedScreen.h
//  testEnvironment
//
//  Created by Alex Schiffman on 9/2/16.
//  Copyright © 2016 Alex Schiffman. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "GameScene.h"

@interface pausedScreen : SKScene

@property (nonatomic, strong) SKLabelNode *unpauseButton;

@property (weak, nonatomic, readonly) SKScene * returnScene;

-(void)setReturnScene:(SKScene *)otherScene;


@end