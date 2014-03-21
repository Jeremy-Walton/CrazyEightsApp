//
//  JPWDeck.h
//  CrazyEightsModel
//
//  Created by Jeremy on 1/23/14.
//  Copyright (c) 2014 Jeremy-Walton. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JPWPlayingCard.h"
#import "JPWJsonConversionProtocol.h"

@interface JPWDeck : NSObject <JPWJsonConversionProtocol>

@property (nonatomic, strong) NSMutableArray *cards;

- (NSNumber *)size;
- (JPWPlayingCard *)takeTopCard;
- (void)shuffle;

@end
