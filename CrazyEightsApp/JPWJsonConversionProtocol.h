//
//  JPWJsonConversionProtocall.h
//  CrazyEightsApp
//
//  Created by Jeremy on 3/20/14.
//  Copyright (c) 2014 Jeremy-Walton. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol JPWJsonConversionProtocol <NSObject>

- (NSDictionary *)toNSDictionary;
- (void)fromNSDictionary:(NSDictionary *)dictionary;

@end
