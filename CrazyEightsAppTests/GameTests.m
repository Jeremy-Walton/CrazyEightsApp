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
#import "JPWRobot.h"
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
    
    it(@"can add a robot.", ^{
        [[[game numberOfPlayers] should] equal:@0];
        JPWRobot *robot = [JPWRobot newWithName:@"Jeremy"];
        [game addRobot:robot];
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
        JPWRobot *player2 = [JPWRobot newWithName:@"Sam"];
        JPWPlayer *player3 = [JPWPlayer newWithName:@"Max"];
        [game addPlayer:player];
        [game addRobot:player2];
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
    
    it(@"Can play a card", ^{
        JPWPlayer *p = [JPWPlayer newWithName:@"Jeremy"];
        JPWPlayer *p2 = [JPWPlayer newWithName:@"Bob"];
        [game addPlayer:p];
        [game addPlayer:p2];
        [game setup];
        //player clicked card.
        JPWPlayingCard *card = [p.hand.cards objectAtIndex:0];
        [game playCard:card from:p];
        [[[game.discardPile size] should] equal:@2];
    });
    
    it(@"Can play a robots card", ^{
        JPWRobot *p = [JPWRobot newWithName:@"Jeremy"];
        JPWPlayer *p2 = [JPWPlayer newWithName:@"Bob"];
        [game addRobot:p];
        [game addPlayer:p2];
        [game setup];
        //player clicked card.
        JPWPlayingCard *card = [p.hand.cards objectAtIndex:0];
        [game playRobotCard:card from:p];
        [[[game.discardPile size] should] equal:@2];
    });
    
    it(@"can play a single round.", ^{
        //pre game setup
        NSLog(@"Jeremy");
        JPWPlayer *p = [JPWPlayer newWithName:@"Jeremy"];
        JPWPlayer *p2 = [JPWPlayer newWithName:@"Bob"];
        [game addPlayer:p];
        [game addPlayer:p2];
        [game setup];
         NSString *result = @"Nothig Yet";
        //player clicked card.
        JPWPlayingCard *card = [p.hand.cards objectAtIndex:0];
        if ([[game whosTurn] isEqual:p.name]) {
            if ([game isCardValid:card]) {
                if ([card.rank isEqual:@"8"]) {
                    //Would display suit change buttons.
                    [game playCard:card from:p];
                    [game changeTurnOrder];
                    [[[p numberOfCards] should] equal:@6];
                    [[[game whosTurn] should] equal:@"Bob"];
                } else {
                    [game playCard:card from:p];
                    [game changeTurnOrder];
                    [[[p numberOfCards] should] equal:@6];
                    [[[game whosTurn] should] equal:@"Bob"];
                }
            } else {
                result = @"Not a valid card.";
                [[[p numberOfCards] should] equal:@7];
            }
        } else {
             result = @"Not your turn.";
            [[[p numberOfCards] should] equal:@7];
        }
        
    });
    
    it(@"should have a method toNSDictionary that converts the object to a dictionary.", ^{
        JPWPlayer *p = [JPWPlayer newWithName:@"Jeremy"];
        JPWPlayer *p2 = [JPWPlayer newWithName:@"Bob"];
        [game addPlayer:p];
        [game addPlayer:p2];
        [game setup];
        NSDictionary *dictionary = [game toNSDictionary];
        NSDictionary *expected = @{@"deck": [game.deck toNSDictionary], @"discardPile": [game.discardPile toNSDictionary], @"players": @[[game.players[0] toNSDictionary], [game.players[1] toNSDictionary]], @"turnOrder": [game turnOrder]};
        [[dictionary should] equal: expected];
    });
    
    it(@"should convert to a JSON string", ^{
        //TODO pull this up to Object
        NSDictionary *dictionary = [game toNSDictionary];
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:0 error:nil];
        NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        [[[game convertToJSON] should] equal: jsonString];
    });
    
    it(@"should have a method fromNSDictionary that converts to object from a dictionary.", ^{
        JPWGame *game2 = [JPWGame new];
        JPWPlayer *p = [JPWPlayer newWithName:@"Jeremy"];
        JPWPlayer *p2 = [JPWPlayer newWithName:@"Bob"];
        JPWPlayer *p3 = [JPWPlayer newWithName:@"Bib"];
        [game addPlayer:p];
        [game addPlayer:p2];
        [game2 addPlayer:p];
        [game2 addPlayer:p2];
        [game2 addPlayer:p3];
        [game setup];
        [game2 setup];
        [[[game2 numberOfPlayers] shouldNot] equal:[game numberOfPlayers]];
        NSDictionary *dictionary = [game toNSDictionary];
        [game2 fromNSDictionary:dictionary];
        [[[game2 numberOfPlayers] should] equal:[game numberOfPlayers]];
        [[[game2.players[0] name] should] equal:[game.players[0] name]];
        [[[game2.players[0] hand].cards should] equal:[game.players[0] hand].cards];
    });
    
});

SPEC_END
