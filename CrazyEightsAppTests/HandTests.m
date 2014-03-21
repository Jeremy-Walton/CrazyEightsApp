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
        [[@([card isEqual:card2]) should] beTrue];
    });
    
    it(@"should have a method toNSDictionary that converts the object to a dictionary.", ^{
        JPWPlayingCard *card = [JPWPlayingCard newWithRank:@"Ace" suit:@"Spades"];
        [hand addCard:card];
        NSDictionary *dictionary = [hand toNSDictionary];
        NSDictionary *expected = @{@"cards": @[[card toNSDictionary]]};
        [[dictionary should] equal: expected];
    });
    
    it(@"should have a method fromNSDictionary that converts to object from a dictionary.", ^{
        JPWHand *newHand = [JPWHand new];
        JPWPlayingCard *card = [JPWPlayingCard newWithRank:@"Ace" suit:@"Spades"];
        JPWPlayingCard *newCard = [JPWPlayingCard newWithRank:@"King" suit:@"Clubs"];
        [hand addCard:card];
        [newHand addCard:newCard];
        [newHand addCard:card];
        NSDictionary *dictionary = [hand toNSDictionary];
        [[[newHand numberOfCards] shouldNot] equal:[hand numberOfCards]];
        [newHand fromNSDictionary:dictionary];
        [[[newHand numberOfCards] should] equal:[hand numberOfCards]];
        
        [[newHand.cards[0] should] equal:card];
        [[@([newHand.cards[0] isEqual:card]) should] beTrue];
    });

});

SPEC_END