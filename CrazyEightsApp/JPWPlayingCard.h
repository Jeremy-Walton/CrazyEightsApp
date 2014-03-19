//
//  JPWPlayingCard.h
//  CrazyEightsModel
//
//  Created by Jeremy on 1/23/14.
//  Copyright (c) 2014 Jeremy-Walton. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JPWPlayingCard : NSObject

@property NSString *rank;
@property NSString *suit;
@property NSNumber *value;

+ (instancetype)newWithRank:(NSString *)rank suit:(NSString *)suit;
- (instancetype)initWithRank:(NSString *)rank suit:(NSString *)suit;

- (NSDictionary *)toNSDictionary;
- (void)fromNSDictionary:(NSDictionary *)dictionary;

@end
