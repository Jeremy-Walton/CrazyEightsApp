//
//  JPWPlayingCard.m
//  CrazyEightsModel
//
//  Created by Jeremy on 1/23/14.
//  Copyright (c) 2014 Jeremy-Walton. All rights reserved.
//

#import "JPWPlayingCard.h"

@implementation JPWPlayingCard {
@private NSArray *rankOrder;
}

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
        rankOrder = [NSArray arrayWithObjects:@"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"Jack", @"Queen", @"King", @"Ace", nil];
        _value = @([rankOrder indexOfObject:self.rank]);
    }
    return self;
}

- (NSString *)description {

    return [NSString stringWithFormat:@"%@ of %@", self.rank, self.suit];
}

- (NSMutableDictionary *)toNSDictionary
{
    
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
    [dictionary setValue:self.rank forKey:@"rank"];
    [dictionary setValue:self.suit forKey:@"suit"];
    [dictionary setValue:self.value forKey:@"value"];
    
    return dictionary;
}

@end
