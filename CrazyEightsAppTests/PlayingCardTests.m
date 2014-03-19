//
//  CrazyEightsModelTests.m
//  CrazyEightsModelTests
//
//  Created by Jeremy on 1/23/14.
//  Copyright (c) 2014 Jeremy-Walton. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "JPWPlayingCard.h"
#import "Kiwi.h"

SPEC_BEGIN(PlayingCardTests)

describe(@"Playing Card", ^{
    __block JPWPlayingCard *ace;
    
    beforeEach(^{
        ace = [JPWPlayingCard newWithRank:@"Ace" suit:@"Spades"];
    });
    
    it(@"should have a rank and suit and value", ^{
        [[ace.rank should] equal:@"Ace"];
        [[ace.suit should] equal:@"Spades"];
        [[ace.value should] equal:@(12)];
    });
    
    it(@"should have a method toNSDictionary that converts the object to a dictionary.", ^{
        NSMutableDictionary *dictionary = [ace toNSDictionary];
        [[[dictionary objectForKey:@"rank"] should] equal:@"Ace"];
        [[[dictionary objectForKey:@"suit"] should] equal:@"Spades"];
        [[[dictionary objectForKey:@"value"] should] equal:@(12)];
    });
    
});

SPEC_END
