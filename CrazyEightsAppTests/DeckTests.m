//
//  DeckTests.m
//  CrazyEightsModel
//
//  Created by Jeremy on 1/23/14.
//  Copyright (c) 2014 Jeremy-Walton. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "JPWDeck.h"
#import "Kiwi.h"
#import "JPWPlayingCard.h"

SPEC_BEGIN(DeckTests)

describe(@"Deck", ^{
    __block JPWDeck *deck;
    
    beforeEach(^{
        deck = [JPWDeck new];
    });
    
    it(@"gets initialized with 52 cards.", ^{
        [[[deck size] should] equal:@52];
    });
    
    it(@"can return a card when asked.", ^{
        [[[deck size] should] equal:@52];
        JPWPlayingCard *card1 = [deck takeTopCard];
        JPWPlayingCard *card2 = [deck takeTopCard];
        [[[deck size] should] equal:@50];
    });
    
    it(@"gets initialized the same way each time.", ^{
        JPWDeck *deck2 = [JPWDeck new];
        for (int i = 0; i < [[deck size] integerValue]; i++) {
            JPWPlayingCard *card1 = [deck takeTopCard];
            JPWPlayingCard *card2 = [deck2 takeTopCard];
            NSMutableArray *rankSuit1 = [NSMutableArray new];
            [rankSuit1 addObject:card1.rank];
            [rankSuit1 addObject:card1.suit];
            NSMutableArray *rankSuit2 = [NSMutableArray new];
            [rankSuit2 addObject:card2.rank];
            [rankSuit2 addObject:card2.suit];
            [[rankSuit1 should] equal:rankSuit2];
        }
    });
    
    it(@"can be shuffled.", ^{
        JPWDeck *deck2 = [JPWDeck new];
        
        [deck2 shuffle];
        NSMutableArray *cards = [NSMutableArray new];
        for (int i = 0; i < [[deck size] integerValue]; i++) {
            JPWPlayingCard *card1 = [deck takeTopCard];
            JPWPlayingCard *card2 = [deck2 takeTopCard];
            if ([card1 isEqual:card2]) {
                [cards addObject:card1];
            } else {
            }
            
        }
        
        [[@([cards count]) shouldNot] equal:@52];
    });
    
    it(@"should have a method toNSDictionary that converts the object to a dictionary.", ^{
        NSDictionary *dictionary = [deck toNSDictionary];
        [[dictionary[@"cards"][0][@"rank"] should] equal:@"2"];
        [[dictionary[@"cards"][0][@"suit"] should] equal:@"Hearts"];
    });
    
    it(@"should have a method fromNSDictionary that converts to object from a dictionary.", ^{
        [deck shuffle];
        JPWDeck *newDeck = [JPWDeck new];
        NSDictionary *dictionary = [deck toNSDictionary];
        [newDeck fromNSDictionary:dictionary];
        [[[deck cards] should] equal:[newDeck cards]];
    });
    
});

SPEC_END