//
//  JPWDiscardPile.h
//  CrazyEightsModel
//
//  Created by Jeremy on 1/24/14.
//  Copyright (c) 2014 Jeremy-Walton. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JPWPlayingCard.h"
#import "JPWJsonConversionProtocall.h"

@interface JPWDiscardPile : NSObject <JPWJsonConversionProtocall>

- (void)addCard:(JPWPlayingCard *)card;
- (NSNumber *)size;
- (JPWPlayingCard *)showTopCard;

@end
