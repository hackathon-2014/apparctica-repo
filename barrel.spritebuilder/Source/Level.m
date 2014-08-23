//
//  Level.m
//  barrel
//
//  Created by Jason Rikard on 8/23/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "Level.h"

@implementation Level
{
    CCPhysicsNode *_physicsNode;

    CCNode *_currentpirate;
    CCNode *_barrel2;
}
- (void)launchPirate {
    CCLOG(@"%f", _barrel2.position.x);

    // loads the pirate.ccb we have set up in Spritebuilder
    CCNode* pirate = [CCBReader load:@"pirate"];
    // position the pirate at the bowl of the catapult
    pirate.position = ccpAdd(_barrel2.position, ccp(16, 50));
    
    // add the pirate to the physicsNode of this scene (because it has physics enabled)
    [_physicsNode addChild:pirate];
    
    // manually create & apply a force to launch the pirate
    CGPoint launchDirection = ccp(0, 1);
    CGPoint force = ccpMult(launchDirection, 8000);
    [pirate.physicsBody applyForce:force];
    
    // ensure followed object is in visible are when starting
//    self.position = ccp(_barrel2.position.x, _barrel2.position.y);
//    CCActionFollow *follow = [CCActionFollow actionWithTarget:pirate worldBoundary:self.boundingBox];
//    [self runAction:follow];
    
}

@end
