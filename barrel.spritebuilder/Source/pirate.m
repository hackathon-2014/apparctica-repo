//
//  pirate.m
//  barrel
//
//  Created by Jason Rikard on 8/23/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "pirate.h"

@implementation pirate


- (id)init {
    self = [super init];

    if (self) {
        // initialize instance variables here
    }
    
    return self;
}

- (void)didLoadFromCCB {
    self.physicsBody.collisionType = @"pirate";
}

@end
