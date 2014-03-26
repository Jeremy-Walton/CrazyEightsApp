//
//  DeckTests.m
//  CrazyEightsModel
//
//  Created by Jeremy on 1/23/14.
//  Copyright (c) 2014 Jeremy-Walton. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Kiwi.h"
#import "JPWWebClient.h"
#import "JPWGame.h"

SPEC_BEGIN(JPWWebClientTests)

describe(@"Web Client", ^{
    __block JPWWebClient *webClient;
    beforeEach(^{
        // change from singleton. take out of test.
        webClient = [JPWWebClient sharedClient];
        [webClient loginWithEmail:@"jthelegoman@gmail.com" andPassword:@"password"];
    });
    
    it(@"should login successfully", ^{
        [[[webClient loginWithEmail:@"jthelegoman@gmail.com" andPassword:@"password"] should] beYes];
        [[webClient.token shouldNot] beNil];
        [[webClient.userID shouldNot] beNil];
    });
    
    it(@"should fail logging in with invalid credentials", ^{
        [[[webClient loginWithEmail:@"my-happy-account@me.com" andPassword:@"not-a-password"] should] beNo];
        [[webClient.token should] beNil];
        [[webClient.userID should] beNil];
    });
    
    it(@"should create a database entry.", ^{
        JPWGame *game = [webClient initializeServerWithNumberOfPlayers:@2 andNumberOfRobots:@0];
        [[game.gameID should] beGreaterThan:@0];
    });
    
    it(@"should join a game", ^{
        NSNumber *gameID = [webClient initializeServerWithNumberOfPlayers:@2 andNumberOfRobots:@0].gameID;
        JPWGame *game = [webClient joinGame:gameID];
        [[game shouldNot] beNil];
        [[game.players shouldNot] beEmpty];
        [[@([game isReady]) should] beNo];
    });
    
    it(@"should send the json to the server", ^{
        JPWGame *game = [webClient initializeServerWithNumberOfPlayers:@2 andNumberOfRobots:@0];
        NSDictionary *dictionary = [game toNSDictionary];
        NSError *writeError = nil;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:0 error:&writeError];
        NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        [[[webClient sendGameToServer:jsonString withID:game.gameID] should] equal:game.gameID];
    });
    
    it(@"should retrieve the json from the server", ^{
        JPWGame *game = [webClient initializeServerWithNumberOfPlayers:@2 andNumberOfRobots:@0];
        NSDictionary *dictionary = [game toNSDictionary];
        NSError *writeError = nil;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:0 error:&writeError];
        NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        [[[webClient sendGameToServer:jsonString withID:game.gameID] should] equal:game.gameID];
        JPWGame *gameFromJSON = [webClient retrieveGameFromServer:game.gameID];
        [[game.gameID should] equal:gameFromJSON.gameID];
    });

});

SPEC_END