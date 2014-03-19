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
    
    it(@"should have a method toNSDictionary that converts the object to a dictionary.", ^{
        JPWPlayingCard *card = [JPWPlayingCard newWithRank:@"Ace" suit:@"Spades"];
        [hand addCard:card];
        NSMutableDictionary *dictionary = [hand toNSDictionary];
        [[dictionary[@"cards"][0][@"rank"] should] equal:@"Ace"];
        [[dictionary[@"cards"][0][@"suit"] should] equal:@"Spades"];
        [[dictionary[@"cards"][0][@"value"] should] equal:@12];
    });
    
    it(@"should have a method fromNSDictionary that converts to object from a dictionary.", ^{
        JPWHand *newHand = [JPWHand new];
        JPWPlayingCard *card = [JPWPlayingCard newWithRank:@"Ace" suit:@"Spades"];
        JPWPlayingCard *newCard = [JPWPlayingCard newWithRank:@"King" suit:@"Clubs"];
        [hand addCard:card];
        [newHand addCard:newCard];
        NSDictionary *dictionary = [hand toNSDictionary];
        [newHand fromNSDictionary:dictionary];
        [[[newHand.cards[0] rank] should] equal:card.rank];
        [[[newHand.cards[0] suit] should] equal:card.suit];
    });

});

SPEC_END