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
        JPWHand *hand = player.hand;
        JPWPlayingCard *card = [JPWPlayingCard newWithRank:@"Ace" suit:@"Spades"];
        [hand addCard:card];
        NSDictionary *dictionary = [player toNSDictionary];
        JPWPlayingCard *firstCard = hand.cards[0];
        NSDictionary *expected = @{@"name": @"Jeremy",@"hand": @{@"cards": @[@{@"rank": firstCard.rank, @"suit": firstCard.suit}]}};
        [[dictionary should] equal: expected];
    });
    
    it(@"should have a method fromNSDictionary that converts to object from a dictionary.", ^{
        JPWPlayer *player2 = [JPWPlayer newWithName:@"Bob"];
        JPWPlayingCard *card = [JPWPlayingCard newWithRank:@"Ace" suit:@"Spades"];
        JPWPlayingCard *card2 = [JPWPlayingCard newWithRank:@"King" suit:@"Clubs"];
        [player addCardToHand:card];
        [player2 addCardToHand:card2];
        NSDictionary *dictionary = [player toNSDictionary];
        [player2 fromNSDictionary:dictionary];
        [[[player2 name] should] equal:[player name]];
        [[[[player2 hand].cards[0] rank] should] equal:[[player hand].cards[0] rank]];
        [[[[player2 hand].cards[0] suit] should] equal:[[player hand].cards[0] suit]];
    });
    
});

SPEC_END
