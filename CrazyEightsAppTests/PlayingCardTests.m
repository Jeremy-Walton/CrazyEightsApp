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
        ace = [JPWPlayingCard newWithRank:@"A" suit:@"S"];
    });
    
    it(@"should have a rank and suit", ^{
        [[ace.rank should] equal:@"A"];
        [[ace.suit should] equal:@"S"];
    });
});

SPEC_END
