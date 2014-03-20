//
//  JPWDiscardPile.h
//  CrazyEightsModel
//
//  Created by Jeremy on 1/24/14.
//  Copyright (c) 2014 Jeremy-Walton. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JPWPlayingCard.h"
#import "JPWJsonConversionProtocol.h"

@interface JPWDiscardPile : NSObject <JPWJsonConversionProtocol>

- (void)addCard:(JPWPlayingCard *)card;
- (NSNumber *)size;
- (JPWPlayingCard *)showTopCard;

@end
