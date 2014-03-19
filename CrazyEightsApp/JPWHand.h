//
//  JPWHand.h
//  CrazyEightsApp
//
//  Created by Jeremy on 1/28/14.
//  Copyright (c) 2014 Jeremy-Walton. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JPWPlayingCard.h"

@interface JPWHand : NSObject

@property (nonatomic, strong) NSMutableArray *cards;

- (void)addCard:(JPWPlayingCard *)card;
- (JPWPlayingCard *)removeCard:(JPWPlayingCard *)card;
- (NSNumber *)numberOfCards;
- (JPWPlayingCard *)cardAt:(NSNumber *)index;
-(void)sortCards;

- (NSMutableDictionary *)toNSDictionary;

@end
