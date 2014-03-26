//
//  JPWWebClient.h
//  CrazyEightsApp
//
//  Created by Jeremy on 3/24/14.
//  Copyright (c) 2014 Jeremy-Walton. All rights reserved.
//

#import <Foundation/Foundation.h>

@class JPWGame;

@interface JPWWebClient : NSObject

@property (nonatomic, strong) NSString *token;
@property (nonatomic, strong) NSNumber *userID;

+ (instancetype)sharedClient;

-(NSNumber *)loginWithEmail:(NSString *)email andPassword:(NSString *)password;
-(JPWGame *)initializeServerWithNumberOfPlayers:(NSNumber *)numberOfPlayers andNumberOfRobots:(NSNumber *)numberOfRobots;
-(JPWGame *)joinGame:(NSNumber *)gameID;

@end
