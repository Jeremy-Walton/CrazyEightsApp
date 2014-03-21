//
//  JPWPlayingCard.m
//  CrazyEightsModel
//
//  Created by Jeremy on 1/23/14.
//  Copyright (c) 2014 Jeremy-Walton. All rights reserved.
//

#import "JPWPlayingCard.h"

@interface JPWPlayingCard (private)
    @property (nonatomic, strong, readwrite) NSNumber *value;
@end

@implementation JPWPlayingCard {
@private NSArray *rankOrder;
}

+ (instancetype)newWithRank:(NSString *)rank suit:(NSString *)suit
{
    return [[self alloc] initWithRank:rank suit:suit];
}

+ (instancetype)newWithDictionary:(NSMutableDictionary *)dictionary
{
    return [[self alloc] initWithDictionary:dictionary];
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

- (instancetype)initWithDictionary:(NSMutableDictionary *)dictionary
{
    return [self initWithRank:dictionary[@"rank"] suit:dictionary[@"suit"]];
}

- (NSString *)description {

    return [NSString stringWithFormat:@"%@ of %@", self.rank, self.suit];
}

- (BOOL)isEqual:(JPWPlayingCard *)card
{
    if ((self.rank == card.rank) && (self.suit == card.suit)) {
        return YES;
    } else {
        return NO;
    }
}

- (NSDictionary *)toNSDictionary
{
    return @{@"rank": self.rank, @"suit": self.suit};
}

+ (NSMutableArray *)arrayFromJSONDictionaries:(NSMutableArray *)dictionaries
{
    NSMutableArray *newCards =  [[NSMutableArray alloc] init];
    for (int i = 0; i < [dictionaries count]; i++) {
        [newCards addObject: [JPWPlayingCard newWithDictionary: dictionaries[i]]];
    }
    return newCards;
}

@end
