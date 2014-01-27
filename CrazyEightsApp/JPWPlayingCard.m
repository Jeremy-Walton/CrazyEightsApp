//
//  JPWPlayingCard.m
//  CrazyEightsModel
//
//  Created by Jeremy on 1/23/14.
//  Copyright (c) 2014 Jeremy-Walton. All rights reserved.
//

#import "JPWPlayingCard.h"

@implementation JPWPlayingCard

+ (instancetype)newWithRank:(NSString *)rank suit:(NSString *)suit
{
    return [[self alloc] initWithRank:rank suit:suit];
}

- (instancetype)initWithRank:(NSString *)rank suit:(NSString *)suit
{
    self = [super init];
    if (self) {
        _rank = rank;
        _suit = suit;
    }
    return self;
}

- (NSString *)description {

    return [NSString stringWithFormat:@"%@ of %@", self.rank, self.suit];
}

@end
