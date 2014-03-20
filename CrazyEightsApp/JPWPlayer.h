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
#import "JPWJsonConversionProtocol.h"

@interface JPWPlayer : NSObject <JPWJsonConversionProtocol>

@property (nonatomic, strong, readonly) NSString *name;
@property (nonatomic, strong) JPWHand *hand;

+ (instancetype)newWithName:(NSString *)name;
- (instancetype)initWithName:(NSString *)name;

- (void)addCardToHand:(JPWPlayingCard *)card;
- (NSNumber *)numberOfCards;
- (JPWPlayingCard *)chooseCard;
- (JPWPlayingCard *)takeCardFromPlayer:(JPWPlayingCard *)card;

@end
