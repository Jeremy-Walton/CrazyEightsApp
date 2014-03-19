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
#import "JPWHand.h"

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
        self.hand = [JPWHand new];
    }
    return self;
}

-(JPWPlayingCard *)takeCardFromPlayer:(JPWPlayingCard *)card {
    return [self.hand removeCard:card];
}


- (void)addCardToHand:(JPWPlayingCard *)card {
    [self.hand addCard:card];
}

- (NSNumber *)numberOfCards {
    return [self.hand numberOfCards];
}

- (JPWPlayingCard *)chooseCard {
    //need to get user input, not first card.
    return [self.hand.cards objectAtIndex:0];
}

- (NSDictionary *)toNSDictionary
{
    return @{@"name": self.name, @"hand": [self.hand toNSDictionary]};
}

@end
