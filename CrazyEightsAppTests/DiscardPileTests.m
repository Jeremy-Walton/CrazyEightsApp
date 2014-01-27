//
//  DiscardPileTests.m
//  CrazyEightsModel
//
//  Created by Jeremy on 1/24/14.
//  Copyright (c) 2014 Jeremy-Walton. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "JPWDeck.h"
#import "Kiwi.h"
#import "JPWPlayingCard.h"
#import "JPWDiscardPile.h"

SPEC_BEGIN(DiscardPileTests)

describe(@"Discard Pile", ^{
    __block JPWDiscardPile *discardPile;
    
    beforeEach(^{
        discardPile = [JPWDiscardPile new];
    });
    
    it(@"can have cards added to it.", ^{
        JPWPlayingCard *card = [JPWPlayingCard newWithRank:@"A" suit:@"S"];
        [[[discardPile size] should] equal:@0];
        [discardPile addCard:card];
        [[[discardPile size] should] equal:@1];
    });
    
    it(@"can show the top card.", ^{
        JPWPlayingCard *card = [JPWPlayingCard newWithRank:@"A" suit:@"S"];
        [discardPile addCard:card];
        JPWPlayingCard *showedCard = [discardPile showTopCard];
        [[showedCard.rank should] equal:card.rank];
        [[showedCard.suit should] equal:card.suit];
    });
    
});

SPEC_END