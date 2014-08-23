//
//  GamePlay.m
//  angry
//
//  Created by Jason Rikard on 8/22/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "GamePlay.h"

@implementation GamePlay{
    CCPhysicsNode *_physicsNode;
    CCNode *_catapultArm;
    CCNode *_contentNode;
    CCNode *_pullbackNode;
    CCNode *_mouseJointNode;
    CCPhysicsJoint *_mouseJoint;
    CCPhysicsJoint *_pirateCatapultJoint;
    
    CCNode *_levelNode;
    CCNode *_currentpirate;
    CCNode *_barrel;
    Level *_currentLevel;
    CCLabelTTF *_gameClock;
    
    int *_time;
}

- (void)didLoadFromCCB {
    // tell this scene to accept touches
    self.userInteractionEnabled = TRUE;
    _physicsNode.debugDraw = TRUE;
//    _physicsNode.collisionDelegate = self;
    
    // nothing shall collide with our invisible nodes
    _pullbackNode.physicsBody.collisionMask = @[];
    _mouseJointNode.physicsBody.collisionMask = @[];
    
    //type cast to Level
    _currentLevel = (Level *)[CCBReader load:@"levels/Level"];
    [_levelNode addChild:_currentLevel];
    
    [self schedule:@selector(updateClock) interval:10];
    _time = 0;
}

-(void)updateClock
{
    _time++;
    _gameClock.string = [NSString stringWithFormat:@"%d", _time];
}


// called on every touch in this scene
-(void) touchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    CCLOG(@"touch began!");
    //TODO shoot pirate if inside barrel
    [_currentLevel launchPirate];
//    CCLOG(@"%f", _currentLevel._barrel2.position.x);

   
    
//    CGPoint touchLocation = [touch locationInNode:_contentNode];
//    _currentpirate = [CCBReader load:@"pirate"];
//    //CGPoint piratePosition = [_catapultArm convertToWorldSpace:ccp(34, 138)];
//    _currentpirate.position = [_physicsNode convertToNodeSpace:touchLocation];
//[_physicsNode addChild:_currentpirate];
//    // follow the flying pirate
//    CCActionFollow *follow = [CCActionFollow actionWithTarget:_currentpirate worldBoundary:self.boundingBox];
//    [_contentNode runAction:follow];
//    
    

    
    // start catapult dragging when a touch inside of the catapult arm occurs
//    if (CGRectContainsPoint([_catapultArm boundingBox], touchLocation))
//    {
        // move the mouseJointNode to the touch position
//        _mouseJointNode.position = touchLocation;
//        
//        // setup a spring joint between the mouseJointNode and the catapultArm
//        _mouseJoint = [CCPhysicsJoint connectedSpringJointWithBodyA:_mouseJointNode.physicsBody bodyB:_catapultArm.physicsBody anchorA:ccp(0, 0) anchorB:ccp(34, 138) restLength:0.f stiffness:3000.f damping:150.f];
//    
//        // create a pirate from the ccb-file
//        _currentpirate = [CCBReader load:@"pirate"];
        // initially position it on the scoop. 34,138 is the position in the node space of the _catapultArm
//        CGPoint piratePosition = [_catapultArm convertToWorldSpace:ccp(34, 138)];
//        // transform the world position to the node space to which the pirate will be added (_physicsNode)
//        _currentpirate.position = [_physicsNode convertToNodeSpace:piratePosition];
//        // add it to the physics world
//        [_physicsNode addChild:_currentpirate];
//        // we don't want the pirate to rotate in the scoop
//        _currentpirate.physicsBody.allowsRotation = FALSE;
//        
//        // create a joint to keep the pirate fixed to the scoop until the catapult is released
//        _pirateCatapultJoint = [CCPhysicsJoint connectedPivotJointWithBodyA:_currentpirate.physicsBody bodyB:_catapultArm.physicsBody anchorA:_currentpirate.anchorPointInPoints];
//    }
}

- (void)touchMoved:(UITouch *)touch withEvent:(UIEvent *)event
{
    // whenever touches move, update the position of the mouseJointNode to the touch position
    CGPoint touchLocation = [touch locationInNode:_contentNode];
    _mouseJointNode.position = touchLocation;
}

-(void) touchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
    // when touches end, meaning the user releases their finger, release the catapult
    [self releaseCatapult];
}

-(void) touchCancelled:(UITouch *)touch withEvent:(UIEvent *)event
{
    // when touches are cancelled, meaning the user drags their finger off the screen or onto something else, release the catapult
    [self releaseCatapult];
}

- (void)releaseCatapult {
    if (_mouseJoint != nil)
    {
        // releases the joint and lets the catapult snap back
        [_mouseJoint invalidate];
        _mouseJoint = nil;
        
        // releases the joint and lets the pirate fly
        [_pirateCatapultJoint invalidate];
        _pirateCatapultJoint = nil;
        
        // after snapping rotation is fine
        _currentpirate.physicsBody.allowsRotation = TRUE;
        
        // follow the flying pirate
        CCActionFollow *follow = [CCActionFollow actionWithTarget:_currentpirate worldBoundary:self.boundingBox];
        [_contentNode runAction:follow];
    }
}



-(void)retry {
    // reload this level
    [[CCDirector sharedDirector] replaceScene: [CCBReader loadAsScene:@"GamePlay"]];
}


-(void)pause {
    // reload this level
    [[CCDirector sharedDirector] pushScene:[CCBReader loadAsScene:@"PauseScene"]];
}

@end
