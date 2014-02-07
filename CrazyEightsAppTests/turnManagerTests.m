//
//  turnManagerTests.m
//  CrazyEightsApp
//
//  Created by Jeremy on 2/7/14.
//  Copyright (c) 2014 Jeremy-Walton. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Kiwi.h"
#import "JPWPlayer.h"
#import "JPWRobot.h"
#import "JPWGame.h"
#import "JPWDeck.h"
#import "JPWTurnManager.h"


SPEC_BEGIN(turnManagerTests)

describe(@"TurnManager", ^{
    __block JPWGame *game;
    __block JPWTurnManager *manager;
    
    beforeEach(^{
        game = [JPWGame new];
    });
    
    it(@"can play a single round.", ^{
        //pre game setup
        NSLog(@"Jeremy");
        JPWPlayer *p = [JPWPlayer newWithName:@"Jeremy"];
        JPWRobot *p2 = [JPWRobot newWithName:@"Bob"];
        [game addPlayer:p];
        [game addRobot:p2];
        [game setup];
        [game.discardPile addCard:[JPWPlayingCard newWithRank:@"Ace" suit:@"Clubs"]];
        manager = [JPWTurnManager newWithGame:game player:p robot:p2 wildSuit:@"Spades"];
        NSString *result = @"Nothig Yet";
        //player clicked card.
        JPWPlayingCard *card = [JPWPlayingCard newWithRank:@"Ace" suit:@"Spades"];
                                [p addCardToHand:card];
        [[[p numberOfCards] should] equal:@8];
        [manager playRound:card player:p];
        [[[p numberOfCards] should] equal:@7];
        
    });
    
    it(@"can play a single robot round.", ^{
        //pre game setup
        NSLog(@"Jeremy");
        JPWRobot *p = [JPWRobot newWithName:@"Bob"];
        JPWPlayer *p2 = [JPWPlayer newWithName:@"Jeremy"];
        [game addRobot:p];
        [game addPlayer:p2];
        [game setup];
        [game.discardPile addCard:[JPWPlayingCard newWithRank:@"Ace" suit:@"Clubs"]];
        manager = [JPWTurnManager newWithGame:game player:p2 robot:p wildSuit:@"Spades"];
        //player clicked card.
        JPWPlayingCard *card = [JPWPlayingCard newWithRank:@"Ace" suit:@"Spades"];
        [p addCardToHand:card];
        [[[p numberOfCards] should] equal:@8];
        [manager robotTurn:p];
        [[[p numberOfCards] should] equal:@7];
        
    });
    
});

SPEC_END