//
//  Barrel.m
//  barrel
//
//  Created by Jason Rikard on 8/23/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "Barrel.h"

@implementation Barrel


- (void)didLoadFromCCB {
    self.physicsBody.collisionType = @"Barrel";
    CCLOG(@"barrel loaded!");

}

@end
