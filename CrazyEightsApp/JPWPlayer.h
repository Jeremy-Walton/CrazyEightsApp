//
//  JPWPlayer.h
//  CrazyEightsModel
//
//  Created by Jeremy on 1/24/14.
//  Copyright (c) 2014 Jeremy-Walton. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JPWPlayingCard.h"
#import "JPWHand.h"

@interface JPWPlayer : NSObject

@property (nonatomic, strong, readonly) NSString *name;
@property (nonatomic, strong) JPWHand *hand;

+ (instancetype)newWithName:(NSString *)name;
- (instancetype)initWithName:(NSString *)name;

- (void)addCardToHand:(JPWPlayingCard *)card;
- (void)discard:(JPWPlayingCard *)card;
- (NSNumber *)numberOfCards;
- (NSString *)playCard:(NSNumber *)index;

@end
