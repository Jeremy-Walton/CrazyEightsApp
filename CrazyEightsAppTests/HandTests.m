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

SPEC_BEGIN(HandTests)

describe(@"Hand", ^{
    __block JPWHand *hand;
    
    beforeEach(^{
        hand = [JPWHand new];
    });
    
    it(@"can count how many cards it has.", ^{
        [[[hand numberOfCards] should] equal:@0];
    });
    
    it(@"can have cards added to it.", ^{
        JPWPlayingCard *card = [JPWPlayingCard newWithRank:@"Ace" suit:@"Spades"];
        [[[hand numberOfCards] should] equal:@0];
        [hand addCard:card];
        [[[hand numberOfCards] should] equal:@1];
    });
    
    it(@"can have a card removed from it.", ^{
        JPWPlayingCard *card = [JPWPlayingCard newWithRank:@"Ace" suit:@"Spades"];
        [hand addCard:card];
        [[[hand numberOfCards] should] equal:@1];
        JPWPlayingCard *card2 = [hand removeCard:card];
        [[[hand numberOfCards] should] equal:@0];
        [[card2.rank should] equal:card.rank];
        [[card2.suit should] equal:card.suit];
    });

});

SPEC_END