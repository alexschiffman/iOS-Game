//
//  colorScreen.h
//  testEnvironment
//
//  Created by Alex Schiffman on 7/28/16.
//  Copyright © 2016 Alex Schiffman. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface colorScreen : SKScene

@property (nonatomic, strong) SKSpriteNode *right;
@property (nonatomic, strong) SKSpriteNode *center;
@property (nonatomic, strong) SKSpriteNode *top;
@property (nonatomic, strong) SKSpriteNode *left;

@property (nonatomic, strong) SKSpriteNode *cyanButton;
@property (nonatomic, strong) SKSpriteNode *orangeButton;
@property (nonatomic, strong) SKSpriteNode *blueButton;
@property (nonatomic, strong) SKSpriteNode *redButton;
@property (nonatomic, strong) SKSpriteNode *greenButton;
@property (nonatomic, strong) SKSpriteNode *magentaButton;

@property (nonatomic, strong) NSMutableArray *frames;
@property (nonatomic, strong) NSMutableArray *targets;

@property (nonatomic, strong) SKSpriteNode *target1;
@property (nonatomic, strong) SKSpriteNode *target2;
@property (nonatomic, strong) SKSpriteNode *target3;

@property (nonatomic, strong) SKSpriteNode *saveButton;
@property (nonatomic, strong) SKLabelNode *saveText;

@end
