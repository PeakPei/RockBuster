//
//  JRWMyScene.m
//  Rock Buster
//
//  Created by Josh Wisenbaker on 12/18/13.
//  Copyright (c) 2013 Me. All rights reserved.
//

#import "JRWTitleScene.h"
#import "JRWGameScene.h"



@interface JRWTitleScene ()

@property SKLabelNode *startTextNode;
@property SKLabelNode *titleText;
@property BOOL contentCreated;

@end

@implementation JRWTitleScene 

#pragma mark - Scene Setup Methods

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        return self;
    }
    return nil;  // COV_NF_LINE
}

- (void)didMoveToView:(SKView *)view
{
    if (!self.contentCreated)
    {
        [self createSceneContents];
        self.contentCreated = YES;
    }
}

- (void)createSceneContents {
    
    /* Setup your scene here */
    self.backgroundColor = [SKColor blackColor];
    
    //  Add the title and start text
    [self addChild:[self addTitle]];
    [self addChild:[self addStartText]];
    
    //  Fade them in
    SKAction *fadeIn = [SKAction fadeInWithDuration:1.0];
    [self.titleText runAction:fadeIn];
    
    //  Make the start text blink
    SKAction *blink = [SKAction sequence:@[[SKAction fadeInWithDuration:0.5],
                                           [SKAction fadeOutWithDuration:0.5]]];
    SKAction *blinkForever = [SKAction repeatActionForever:blink];
    
    [self.startTextNode runAction:blinkForever];
    }

//  Make the title node
- (SKLabelNode *)addTitle {
    self.titleText = [SKLabelNode labelNodeWithFontNamed:@"Futura"];
    self.titleText.name = @"titleText";
    self.titleText.text = @"Rock Buster";
    self.titleText.fontSize = 96;
    self.titleText.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame) + 20);
    self.titleText.alpha = 0;
    
    return self.titleText;
    
}

//  Make the start text node
- (SKLabelNode *)addStartText {
    self.startTextNode = [SKLabelNode labelNodeWithFontNamed:@"Futura"];
    self.startTextNode.name = @"startText";
    self.startTextNode.text = @"Press 1 for One Player";
    self.startTextNode.fontSize = 42;
    self.startTextNode.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMinY(self.frame) +50);
    self.startTextNode.alpha = 0;
    
    return self.startTextNode;
    
}

- (void)presentGameScene {
    JRWGameScene *gameScene = [[JRWGameScene alloc] initWithSize:self.size];
    SKTransition *transition = [SKTransition doorwayWithDuration:1.0];
    [self.view presentScene:gameScene transition:transition];
}




#pragma mark - Key Press Handlers
- (void)keyDown:(NSEvent *)theEvent {
    NSString *characters = [theEvent charactersIgnoringModifiers];
    if ([characters length]) {
        for (int s = 0; s<[characters length]; s++) {
            unichar character = [characters characterAtIndex:s];
            switch (character) {
                case '1':
                    [self presentGameScene];
                    break;
            }
        }
    }
}



@end
