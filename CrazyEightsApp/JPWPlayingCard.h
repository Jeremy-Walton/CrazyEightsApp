//
//  JPWPlayingCard.h
//  CrazyEightsModel
//
//  Created by Jeremy on 1/23/14.
//  Copyright (c) 2014 Jeremy-Walton. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JPWJsonConversionProtocol.h"

@interface JPWPlayingCard : NSObject <JPWJsonConversionProtocol>

@property NSString *rank;
@property NSString *suit;
@property (nonatomic, strong, readonly) NSNumber *value;

+ (instancetype)newWithRank:(NSString *)rank suit:(NSString *)suit;
- (instancetype)initWithRank:(NSString *)rank suit:(NSString *)suit;

+ (instancetype)newWithDictionary:(NSMutableDictionary *)dictionary;
- (instancetype)initWithDictionary:(NSMutableDictionary *)dictionary;

- (BOOL)isEqual:(JPWPlayingCard *)card;

+ (NSMutableArray *)arrayFromJSONDictionaries:(NSMutableArray *)dictionaries;

@end
