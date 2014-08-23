//
//  Level.h
//  barrel
//
//  Created by Jason Rikard on 8/23/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "CCNode.h"
#import "CCPhysics+ObjectiveChipmunk.h"

@interface Level : CCNode <CCPhysicsCollisionDelegate>


- (void)launchPirate;
@end
