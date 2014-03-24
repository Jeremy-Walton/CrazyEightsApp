//
//  JPWWebClient.h
//  CrazyEightsApp
//
//  Created by Jeremy on 3/24/14.
//  Copyright (c) 2014 Jeremy-Walton. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JPWWebClient : NSObject

@property (nonatomic, strong) NSString *token;

+ (instancetype)sharedClient;

-(NSNumber *)loginWithEmail:(NSString *)email andPassword:(NSString *)password;

@end
