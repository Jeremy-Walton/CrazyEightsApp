//
//  JPWHand.m
//  CrazyEightsApp
//
//  Created by Jeremy on 1/28/14.
//  Copyright (c) 2014 Jeremy-Walton. All rights reserved.
//

#import "JPWHand.h"

@implementation JPWHand

- (instancetype)init {
    self = [super init];
    if (self) {
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

- (JPWPlayingCard *)cardAt:(NSNumber *)index {
    return [self.cards objectAtIndex:[index integerValue]];
}

@end
