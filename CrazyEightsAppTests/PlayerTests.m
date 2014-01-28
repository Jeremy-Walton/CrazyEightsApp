//
//  PlayerTests.m
//  CrazyEightsModel
//
//  Created by Jeremy on 1/24/14.
//  Copyright (c) 2014 Jeremy-Walton. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Kiwi.h"
#import "JPWPlayingCard.h"
#import "JPWPlayer.h"
#import "JPWHand.h"
#import "JPWGame.h"

SPEC_BEGIN(PlayerTests)

describe(@"Player", ^{
    __block JPWPlayer *player;
    
    beforeEach(^{
        player = [JPWPlayer newWithName:@"Jeremy"];
    });
    
    it(@"has a name.", ^{
        [[[player name] should] equal:@"Jeremy"];
    });
    
    it(@"has a hand.", ^{
        [[[[player hand] class] should] equal:[JPWHand class]];
    });
    
    it(@"can check how many cards its hand has and add cards to its hand.", ^{
        [[[player numberOfCards] should] equal:@0];
        JPWPlayingCard *card = [JPWPlayingCard newWithRank:@"Ace" suit:@"Spades"];
        [player addCardToHand:card];
        [[[player numberOfCards] should] equal:@1];
    });
    
    it(@"can discard to the discard pile.", ^{
        JPWPlayingCard *card = [JPWPlayingCard newWithRank:@"Ace" suit:@"Spades"];
        [player addCardToHand:card];
    });
    
});

SPEC_END
