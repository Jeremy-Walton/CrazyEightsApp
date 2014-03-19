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
        NSDictionary *dictionary = [discardPile toNSDictionary];
        [[dictionary[@"cards"][0][@"rank"] should] equal:@"Ace"];
        [[dictionary[@"cards"][0][@"suit"] should] equal:@"Spades"];
        [[dictionary[@"cards"][0][@"value"] should] equal:@12];
    });
    
    it(@"should have a method fromNSDictionary that converts to object from a dictionary.", ^{
        JPWDiscardPile *newDiscardPile = [JPWDiscardPile new];
        JPWPlayingCard *card = [JPWPlayingCard newWithRank:@"Ace" suit:@"Spades"];
        JPWPlayingCard *card2 = [JPWPlayingCard newWithRank:@"King" suit:@"Clubs"];
        [discardPile addCard:card];
        [newDiscardPile addCard:card2];
        NSDictionary *dictionary = [discardPile toNSDictionary];
        [newDiscardPile fromNSDictionary:dictionary];
        JPWPlayingCard *card3 = [discardPile showTopCard];
        JPWPlayingCard *card4 = [newDiscardPile showTopCard];
        [[card3.rank should] equal:card4.rank];
        [[card3.suit should] equal:card4.suit];
    });
    
});

SPEC_END