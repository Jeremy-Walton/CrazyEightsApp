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

SPEC_BEGIN(PlayerTests)

describe(@"Player", ^{
    __block JPWPlayer *player;
    
    beforeEach(^{
        player = [JPWPlayer newWithName:@"Jeremy"];
    });
    
    it(@"has a name.", ^{
        [[[player name] should] equal:@"Jeremy"];
    });
    
    it(@"has a hand.", ^{
        [[[[player hand] class] should] equal:[JPWHand class]];
    });
    
    it(@"have cards added to it.", ^{
        JPWGame *game = [JPWGame new];
        JPWPlayingCard *card = [JPWPlayingCard newWithRank:@"Ace" suit:@"Spades"];
        [game makeDeckForTest];
        [game addPlayer:player];
        [game dealCards];
        [[[player numberOfCards] should] equal:@5];
        [player addCardToHand:card];
        [[[[player hand] numberOfCards] should] equal:@6];
    });
    
    it(@"should have a method toNSDictionary that converts the object to a dictionary.", ^{
        JPWGame *game = [JPWGame new];
        [game makeDeckForTest];
        [game addPlayer:player];
        [game dealCards];
        JPWHand *hand = player.hand;
        NSDictionary *dictionary = [player toNSDictionary];
        [[[dictionary objectForKey:@"name"] should] equal:@"Jeremy"];
        [[dictionary[@"hand"][@"cards"][0][@"rank"] should] equal:[hand.cards[0] rank]];
        [[dictionary[@"hand"][@"cards"][0][@"suit"] should] equal:[hand.cards[0] suit]];
    });
    
    it(@"should have a method fromNSDictionary that converts to object from a dictionary.", ^{
        JPWPlayer *player2 = [JPWPlayer newWithName:@"Bob"];
        JPWGame *game = [JPWGame new];
        [game makeDeckForTest];
        [game addPlayer:player];
        [game addPlayer:player2];
        [game dealCards];
        NSDictionary *dictionary = [game.players[0] toNSDictionary];
        [game.players[1] fromNSDictionary:dictionary];
        [[[game.players[1] name] should] equal:[game.players[0] name]];
        [[[[game.players[1] hand].cards[0] rank] should] equal:[[game.players[0] hand].cards[0] rank]];
        [[[[game.players[1] hand].cards[0] suit] should] equal:[[game.players[0] hand].cards[0] suit]];
    });
    
});

SPEC_END
