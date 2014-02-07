//
//  RobotTests.m
//  CrazyEightsApp
//
//  Created by Jeremy on 2/7/14.
//  Copyright (c) 2014 Jeremy-Walton. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Kiwi.h"
#import "JPWPlayingCard.h"
#import "JPWRobot.h"
#import "JPWHand.h"
#import "JPWGame.h"

SPEC_BEGIN(RobotTests)

describe(@"Robot", ^{
    __block JPWRobot *robot;
    
    beforeEach(^{
        robot = [JPWRobot newWithName:@"Jeremy"];
    });
    
    it(@"has a name.", ^{
        [[[robot name] should] equal:@"Jeremy"];
    });
    
    it(@"has a hand.", ^{
        [[[[robot hand] class] should] equal:[JPWHand class]];
    });
    
    it(@"have cards added to it.", ^{
        JPWGame *game = [JPWGame new];
        JPWPlayingCard *card = [JPWPlayingCard newWithRank:@"Ace" suit:@"Spades"];
        [game makeDeckForTest];
        [game addRobot:robot];
        [game dealCards];
        [[[robot numberOfCards] should] equal:@5];
        [robot addCardToHand:card];
        [[[[robot hand] numberOfCards] should] equal:@6];
    });
    
});

SPEC_END
