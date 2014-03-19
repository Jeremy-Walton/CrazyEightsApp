//
//  JPWDiscardPile.h
//  CrazyEightsModel
//
//  Created by Jeremy on 1/24/14.
//  Copyright (c) 2014 Jeremy-Walton. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JPWPlayingCard.h"

@interface JPWDiscardPile : NSObject

- (void)addCard:(JPWPlayingCard *)card;
- (NSMutableDictionary *)toNSDictionary;
- (NSNumber *)size;
- (JPWPlayingCard *)showTopCard;

@end
