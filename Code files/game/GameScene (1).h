//
//  GameScene.h
//  testEnvironment
//

//  Copyright (c) 2016 Alex Schiffman. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface GameScene : SKScene
{
    NSTimer *timer;
}
@property (nonatomic, strong) SKLabelNode *timeDisplay;
@property (nonatomic, strong) SKLabelNode *livesDisplay;

@property (nonatomic, strong) NSMutableArray *targetsright;
@property (nonatomic, strong) NSMutableArray *targetsleft;

@property (nonatomic, strong) NSMutableArray *targetStatesRight;
@property (nonatomic, strong) NSMutableArray *targetStatesLeft;

@property (nonatomic, strong) SKSpriteNode *right;
@property (nonatomic, strong) SKSpriteNode *center;
@property (nonatomic, strong) SKSpriteNode *left;

@property (nonatomic, strong) SKSpriteNode *rightTouch;
@property (nonatomic, strong) SKSpriteNode *leftTouch;

@property (nonatomic, strong) SKSpriteNode *targetRight;
@property (nonatomic, strong) SKSpriteNode *targetLeft;

@property (nonatomic, strong) SKSpriteNode *beamright;
@property (nonatomic, strong) SKSpriteNode *beamleft;

@property (nonatomic, strong) SKSpriteNode *pauseScreen;

@property (nonatomic, strong) SKSpriteNode *pauseButton;
@property (nonatomic, strong) SKLabelNode *pauseText;
@property (nonatomic, strong) SKSpriteNode *restartButton;
@property (nonatomic, strong) SKLabelNode *restartButtonText;
@property (nonatomic, strong) SKSpriteNode *exitButton;
@property (nonatomic, strong) SKLabelNode *exitButtonText;


@property (nonatomic, strong) SKSpriteNode *fadeOut;

@end
