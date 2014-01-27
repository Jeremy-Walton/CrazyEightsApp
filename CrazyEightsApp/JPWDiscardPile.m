//
//  JPWDiscardPile.m
//  CrazyEightsModel
//
//  Created by Jeremy on 1/24/14.
//  Copyright (c) 2014 Jeremy-Walton. All rights reserved.
//

#import "JPWDiscardPile.h"
#import "JPWPlayingCard.h"

@interface JPWDiscardPile()
@property (nonatomic, strong) NSMutableArray *cards;
@end

@implementation JPWDiscardPile

- (id)init {
    
    self = [super init];
    if(self) {
        _cards = [NSMutableArray new];
    }
    return self;
}

- (void)addCard:(JPWPlayingCard *)card {
    [self.cards addObject:card];
}

- (NSNumber *)size {
    return @([self.cards count]);
}

- (JPWPlayingCard *)showTopCard {
    return [self.cards lastObject];
}

@end
