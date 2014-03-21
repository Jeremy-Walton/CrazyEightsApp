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
        [[@([showedCard isEqual:card]) should] beTrue];
    });
    
    it(@"should have a method toNSDictionary that converts the object to a dictionary.", ^{
        JPWPlayingCard *card = [JPWPlayingCard newWithRank:@"Ace" suit:@"Spades"];
        [discardPile addCard:card];
        NSDictionary *dictionary = [discardPile toNSDictionary];
        NSDictionary *expected = @{@"cards": @[[card toNSDictionary]]};;
        [[dictionary should] equal: expected];
    });
    
    it(@"should have a method fromNSDictionary that converts to object from a dictionary.", ^{
        JPWDiscardPile *newDiscardPile = [JPWDiscardPile new];
        JPWPlayingCard *card = [JPWPlayingCard newWithRank:@"Ace" suit:@"Spades"];
        JPWPlayingCard *card2 = [JPWPlayingCard newWithRank:@"King" suit:@"Clubs"];
        [discardPile addCard:card];
        [newDiscardPile addCard:card2];
        [newDiscardPile addCard:card];
        [[[newDiscardPile size] shouldNot] equal:[discardPile size]];
        NSDictionary *dictionary = [discardPile toNSDictionary];
        [newDiscardPile fromNSDictionary:dictionary];
        [[[newDiscardPile size] should] equal:[discardPile size]];
        JPWPlayingCard *topCardOfDiscardPile = [discardPile showTopCard];
        JPWPlayingCard *topCardOfNewDiscardPile = [newDiscardPile showTopCard];
        [[topCardOfDiscardPile  should] equal:topCardOfNewDiscardPile];
    });
    
});

SPEC_END