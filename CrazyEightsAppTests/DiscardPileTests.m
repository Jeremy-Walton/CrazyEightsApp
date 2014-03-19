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
    
    it(@"should have a method toNSDictionary that converts the object to a dictionary.", ^{
        JPWPlayingCard *card = [JPWPlayingCard newWithRank:@"Ace" suit:@"Spades"];
        [discardPile addCard:card];
        NSMutableDictionary *dictionary = [discardPile toNSDictionary];
        [[[[[dictionary objectForKey:@"cards"] objectAtIndex:0] objectForKey:@"rank"] should] equal:@"Ace"];
        [[[[[dictionary objectForKey:@"cards"] objectAtIndex:0] objectForKey:@"suit"] should] equal:@"Spades"];
        [[[[[dictionary objectForKey:@"cards"] objectAtIndex:0] objectForKey:@"value"] should] equal:@12];
    });
    
});

SPEC_END