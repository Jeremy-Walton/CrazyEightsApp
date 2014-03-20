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
    
    it(@"should have a method toNSDictionary that converts the object to a dictionary.", ^{
        JPWHand *hand = robot.hand;
        JPWPlayingCard *card = [JPWPlayingCard newWithRank:@"Ace" suit:@"Spades"];
        [hand addCard:card];
        NSDictionary *dictionary = [robot toNSDictionary];
        JPWPlayingCard *firstCard = hand.cards[0];
        NSDictionary *expected = @{@"name": @"Jeremy",@"hand": @{@"cards": @[@{@"rank": firstCard.rank, @"suit": firstCard.suit}]}};
       [[dictionary should] equal: expected];
    });
    
    it(@"should have a method fromNSDictionary that converts to object from a dictionary.", ^{
        JPWRobot *player2 = [JPWRobot newWithName:@"Bob"];
        JPWPlayingCard *card = [JPWPlayingCard newWithRank:@"Ace" suit:@"Spades"];
        JPWPlayingCard *card2 = [JPWPlayingCard newWithRank:@"King" suit:@"Clubs"];
        [robot addCardToHand:card];
        [player2 addCardToHand:card2];
        NSDictionary *dictionary = [robot toNSDictionary];
        [player2 fromNSDictionary:dictionary];
        [[[player2 name] should] equal:[robot name]];
        [[[[player2 hand].cards[0] rank] should] equal:[[robot hand].cards[0] rank]];
        [[[[player2 hand].cards[0] suit] should] equal:[[robot hand].cards[0] suit]];
        
    });
    
});

SPEC_END
