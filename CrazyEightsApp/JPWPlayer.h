//
//  JPWPlayer.h
//  CrazyEightsModel
//
//  Created by Jeremy on 1/24/14.
//  Copyright (c) 2014 Jeremy-Walton. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JPWPlayingCard.h"

@interface JPWPlayer : NSObject

@property (nonatomic, strong, readonly) NSString *name;
@property (nonatomic, strong) NSMutableArray *cards;

+ (instancetype)newWithName:(NSString *)name;
- (instancetype)initWithName:(NSString *)name;

- (void)addCard:(JPWPlayingCard *)card;
- (JPWPlayingCard *)removeCard:(JPWPlayingCard *)card;
- (NSNumber *)numberOfCards;
- (NSString *)playCard:(NSNumber *)index;

@end
