//
//  JPWDeck.h
//  CrazyEightsModel
//
//  Created by Jeremy on 1/23/14.
//  Copyright (c) 2014 Jeremy-Walton. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JPWPlayingCard.h"

@interface JPWDeck : NSObject

- (NSNumber *)size;
- (NSDictionary *)toNSDictionary;
- (JPWPlayingCard *)takeTopCard;
- (void)shuffle;

@end
