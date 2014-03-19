//
//  JPWRobot.m
//  CrazyEightsApp
//
//  Created by Jeremy on 2/5/14.
//  Copyright (c) 2014 Jeremy-Walton. All rights reserved.
//

#import "JPWRobot.h"
#import "JPWPlayingCard.h"
#import "JPWHand.h"

@interface JPWRobot()
@property (nonatomic, strong) NSString *name;
@end

@implementation JPWRobot

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
    return [self.hand.cards lastObject];
}
- (NSDictionary *)toNSDictionary
{
    return @{@"name": self.name, @"hand": [self.hand toNSDictionary]};
}

@end
