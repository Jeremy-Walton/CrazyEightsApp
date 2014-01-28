//
//  GameTests.m
//  CrazyEightsModel
//
//  Created by Jeremy on 1/24/14.
//  Copyright (c) 2014 Jeremy-Walton. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Kiwi.h"
#import "JPWPlayer.h"
#import "JPWGame.h"
#import "JPWDeck.h"

SPEC_BEGIN(GameTests)

describe(@"Game", ^{
    __block JPWGame *game;
    
    beforeEach(^{
        game = [JPWGame new];
    });
    
    it(@"can add a player.", ^{
        [[[game numberOfPlayers] should] equal:@0];
        JPWPlayer *player = [JPWPlayer newWithName:@"Jeremy"];
        [game addPlayer:player];
        [[[game numberOfPlayers] should] equal:@1];
    });
    
    it(@"can draw a card.", ^{
        JPWPlayer *player = [JPWPlayer newWithName:@"Jeremy"];
        [game makeDeckForTest];
        [[[player numberOfCards] should] equal:@0];
        [[[game testDeckSize] should] equal:@52];
        [game addPlayer:player];
        
        [player addCardToHand:[game draw]];
        
        [[[player numberOfCards] should] equal:@1];
        [[[game testDeckSize] should] equal:@51];
    });
    
    it(@"can deal 7 cards to 2 players.", ^{
        JPWPlayer *player = [JPWPlayer newWithName:@"Jeremy"];
        JPWPlayer *player2 = [JPWPlayer newWithName:@"Sam"];
        [game makeDeckForTest];
        
        [game addPlayer:player];
        [game addPlayer:player2];
        
        [game dealCards];
        
        [[[player numberOfCards] should] equal:@7];
        [[[player2 numberOfCards] should] equal:@7];
    });
    
    it(@"can deal 5 cards to more than 2 players.", ^{
        JPWPlayer *player = [JPWPlayer newWithName:@"Jeremy"];
        JPWPlayer *player2 = [JPWPlayer newWithName:@"Sam"];
        JPWPlayer *player3 = [JPWPlayer newWithName:@"Max"];
        [game makeDeckForTest];
        
        [game addPlayer:player];
        [game addPlayer:player2];
        [game addPlayer:player3];
        
        [game dealCards];
        
        [[[player numberOfCards] should] equal:@5];
        [[[player2 numberOfCards] should] equal:@5];
        [[[player3 numberOfCards] should] equal:@5];
    });
    
    it(@"can setup a game.", ^{
        JPWPlayer *player = [JPWPlayer newWithName:@"Jeremy"];
        JPWPlayer *player2 = [JPWPlayer newWithName:@"Sam"];
        JPWPlayer *player3 = [JPWPlayer newWithName:@"Max"];
        [game addPlayer:player];
        [game addPlayer:player2];
        [game addPlayer:player3];
        
        [game setup];
        
        [[[player numberOfCards] should] equal:@5];
        [[[player2 numberOfCards] should] equal:@5];
        [[[player3 numberOfCards] should] equal:@5];
    });
    
    it(@"can discard a card for a player.", ^{
        JPWPlayer *player = [JPWPlayer newWithName:@"Jeremy"];
        [game makeDeckForTest];
        [game makeDiscardPileForTest];
        
        [game addPlayer:player];
        
        JPWPlayingCard *card = [game draw];
        [player.hand addCard:card];
        
        [[[player numberOfCards] should] equal:@1];
        [[[game testDeckSize] should] equal:@51];
        
        [game discard:[player.hand removeCard:card]];
        [[[player numberOfCards] should] equal:@0];
        [[[game testDiscardPileSize] should] equal:@1];

    });
    
    it(@"can determine whos turn it is.", ^{
        JPWPlayer *player = [JPWPlayer newWithName:@"Jeremy"];
        JPWPlayer *player2 = [JPWPlayer newWithName:@"Sam"];
        JPWPlayer *player3 = [JPWPlayer newWithName:@"Max"];
        [game addPlayer:player];
        [game addPlayer:player2];
        [game addPlayer:player3];
        
        [game setup];
        
        NSString *turn = [game whosTurn];
        [[turn should] equal:@"Jeremy"];

    });
    
    it(@"can change the turn order.", ^{
        JPWPlayer *player = [JPWPlayer newWithName:@"Jeremy"];
        JPWPlayer *player2 = [JPWPlayer newWithName:@"Sam"];
        JPWPlayer *player3 = [JPWPlayer newWithName:@"Max"];
        [game addPlayer:player];
        [game addPlayer:player2];
        [game addPlayer:player3];
        
        [game setup];
        [game changeTurnOrder];
        
        NSString *turn = [game whosTurn];
        [[turn should] equal:@"Sam"];
    });
    
    it(@"discard the top card.", ^{
        [game makeDeckForTest];
        [game makeDiscardPileForTest];
        [[[game testDeckSize] should] equal:@52];
        [[[game testDiscardPileSize] should] equal:@0];
        [game discardTopCard];
        [[[game testDeckSize] should] equal:@51];
        [[[game testDiscardPileSize] should] equal:@1];
        
        
    });
    
});

SPEC_END
