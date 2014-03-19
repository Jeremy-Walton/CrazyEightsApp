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
//    [self sortCards];
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
//    [self sortCards];
    return correctCard;
}

-(void)sortCards {
    for (int j = 0; j < [self.cards count]; j++) {
        for (int i = 0; i < [self.cards count] - 1; i++) {
            JPWPlayingCard *card1 = self.cards[i];
            JPWPlayingCard *card2 = self.cards[i+1];
            if (card1.value > card2.value) {
                [self.cards exchangeObjectAtIndex:i withObjectAtIndex:i+1];
            }
        }
    }
}

- (JPWPlayingCard *)cardAt:(NSNumber *)index {
    return [self.cards objectAtIndex:[index integerValue]];
}

- (NSMutableDictionary *)toNSDictionary
{
    
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
    NSMutableArray *array =  [NSMutableArray arrayWithCapacity: [self.cards count]];
    for (int i = 0; i < [self.cards count]; i++) {
        [array addObject:[[self.cards objectAtIndex:i] toNSDictionary]];
    }
    [dictionary setValue:array forKey:@"cards"];
    return dictionary;
}

@end
