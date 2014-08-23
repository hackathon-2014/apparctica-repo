//
//  PauseScene.m
//  barrel
//
//  Created by Jason Rikard on 8/23/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "PauseScene.h"

@implementation PauseScene


-(void)resume {
    // reload this level
    [[CCDirector sharedDirector] popScene];
}

-(void)quit {
    // quit to menu
    CCScene *gameplayScene = [CCBReader loadAsScene:@"MainScene"];
    [[CCDirector sharedDirector] replaceScene:gameplayScene];
    CCLOG(@"quit");

}

-(void)restart {
    //TODO this isn't correct.  It adds a scene on top of the old one :(
    CCScene *gameplayScene = [CCBReader loadAsScene:@"GamePlay"];
    [[CCDirector sharedDirector] replaceScene:gameplayScene];
}


@end
