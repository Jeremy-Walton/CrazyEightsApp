//
//  JPWPlayer.m
//  CrazyEightsModel
//
//  Created by Jeremy on 1/24/14.
//  Copyright (c) 2014 Jeremy-Walton. All rights reserved.
//

//Need to split into player and hand.

#import "JPWPlayer.h"
#import "JPWPlayingCard.h"

@interface JPWPlayer()
@property (nonatomic, strong) NSString *name;
@end

@implementation JPWPlayer

+ (instancetype)newWithName:(NSString *)name
{
    return [[self alloc] initWithName:name];
}

- (instancetype)initWithName:(NSString *)name
{
    self = [super init];
    if (self) {
        self.name = name;
        self.cards = [NSMutableArray new];
    }
    return self;
}


- (void)addCard:(JPWPlayingCard *)card {
    [self.cards addObject:card];
}

- (NSNumber *)numberOfCards {
    return @([self.cards count]);
}

- (JPWPlayingCard *)removeCard:(JPWPlayingCard *)card {
    JPWPlayingCard *correctCard;
    for (int i = 0; i < [[self numberOfCards] integerValue]; i++) {
        if ([[self.cards objectAtIndex:i] rank] == card.rank && [[self.cards objectAtIndex:i] suit] == card.suit) {
            correctCard = [self.cards objectAtIndex:i];
            [self.cards removeObjectAtIndex:i];
        }
    }
    return correctCard;
}

- (NSString *)playCard:(NSNumber *)index {
    return @"Able to play.";
}

@end
