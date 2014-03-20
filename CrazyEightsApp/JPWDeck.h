//
//  JPWDeck.h
//  CrazyEightsModel
//
//  Created by Jeremy on 1/23/14.
//  Copyright (c) 2014 Jeremy-Walton. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JPWPlayingCard.h"
#import "JPWJsonConversionProtocall.h"

@interface JPWDeck : NSObject <JPWJsonConversionProtocall>

- (NSNumber *)size;
- (JPWPlayingCard *)takeTopCard;
- (void)shuffle;

@end
