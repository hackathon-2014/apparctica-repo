//
//  Level.m
//  barrel
//
//  Created by Jason Rikard on 8/23/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "Level.h"
#import "Barrel.h"
static const CGFloat scrollSpeed = 80.f;

@implementation Level
{
    CCPhysicsNode *_physicsNode;

    CCNode *_sceneTracker;
    CCNode *pirate;
    Barrel *_barrel1;
    Barrel *_barrel2;
    Barrel *_currentBarrel;
    
    bool *_isOffScreen;
}

@synthesize _isOver = _isOver;

- (void)didLoadFromCCB {
    _currentBarrel = _barrel1;
    _physicsNode.collisionDelegate = self;
    _isOffScreen = false;
    
    CCActionFollow *follow = [CCActionFollow actionWithTarget:_sceneTracker worldBoundary:self.boundingBox];
    [self runAction:follow];

}

-(void)update:(CCTime)dt
{

    if (pirate.position.x < 0 || pirate.position.x > [[CCDirector sharedDirector] viewSize].width) {
        _isOffScreen = true;
        self._isOver = true;
        [pirate removeFromParent];
        
    }
    
    if (pirate.position.y < 0 || pirate.position.y > _currentBarrel.position.y + 0650) {
        _isOffScreen = true;
        self._isOver = true;
        [pirate removeFromParent];
    }
    if(_currentBarrel.position.y > _sceneTracker.position.y){
        _sceneTracker.position = ccp(_sceneTracker.position.x, _currentBarrel.position.y);
    }
    _sceneTracker.position = ccp(_sceneTracker.position.x, _sceneTracker.position.y + dt * scrollSpeed);

}

- (void)launchPirate {
//    CCLOG(@"%f", _barrel1.rotation);

    //one at a time
    if (1) {
        // loads the pirate.ccb we have set up in Spritebuilder
        pirate = [CCBReader load:@"pirate"];
        
        // position the pirate at the bowl of the catapult
        pirate.position = ccpAdd(_currentBarrel.position, ccp(0, 0));
        
        // add the pirate to the physicsNode of this scene (because it has physics enabled)
        [_physicsNode addChild:pirate];
        
        // manually create & apply a force to launch the pirate
        //CGPoint launchDirection = ccp(60, 50);
        
        float rotationRadians = CC_DEGREES_TO_RADIANS( _currentBarrel.rotation);
        CGPoint directionVector = ccp(sinf(rotationRadians), cosf(rotationRadians));
        CGPoint force = ccpMult(directionVector, 35000);
        [pirate.physicsBody applyForce:force];
    }

    
}


-(void)ccPhysicsCollisionPostSolve:(CCPhysicsCollisionPair *)pair pirate:(CCNode *)nodeA Barrel:(Barrel *)nodeB
{
//    CCLOG(@"Barrel collided with a pirate!");
    
    if(![nodeB isEqual:_currentBarrel]){
        [nodeA removeFromParent];
        _currentBarrel = nodeB;
    }

    CCActionFollow *follow = [CCActionFollow actionWithTarget:_currentBarrel worldBoundary:self.boundingBox];
    [self runAction:follow];
}
@end
