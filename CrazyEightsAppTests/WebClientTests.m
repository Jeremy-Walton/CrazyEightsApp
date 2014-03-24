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

SPEC_BEGIN(JPWWebClientTests)

describe(@"Web Client", ^{
    it(@"should login successfully", ^{
        JPWWebClient *webClient = [JPWWebClient sharedClient];

        [[webClient.token should] beNil];
        [[[webClient loginWithEmail:@"jthelegoman@gmail.com" andPassword:@"password"] should] beYes];
        [[webClient.token shouldNot] beNil];
    });
    
    it(@"should fail logging in with invalid credentials", ^{
        JPWWebClient *webClient = [JPWWebClient sharedClient];
        
        [[[webClient loginWithEmail:@"my-happy-account@me.com" andPassword:@"not-a-password"] should] beNo];
        [[webClient.token should] beNil];
    });
    
});

SPEC_END