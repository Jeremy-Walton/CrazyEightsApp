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


- (void)addCardToHand:(JPWPlayingCard *)card {
    [self.hand addCard:card];
}

- (NSNumber *)numberOfCards {
    return [self.hand numberOfCards];
}

- (void)discard:(JPWPlayingCard *)card {
    
}

- (NSString *)playCard:(NSNumber *)index {
    return @"Able to play.";
}

@end
