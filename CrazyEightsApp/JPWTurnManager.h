//
//  JPWTurnManager.h
//  CrazyEightsApp
//
//  Created by Jeremy on 2/6/14.
//  Copyright (c) 2014 Jeremy-Walton. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JPWGame.h"
#import "JPWRobot.h"
#import "JPWPlayer.h"

@interface JPWTurnManager : NSObject

@property JPWGame *game;
@property JPWRobot *robot;
@property JPWPlayer *player1;
@property NSString *wildSuit;

+ (instancetype)newWithGame:(JPWGame *)game player:(JPWPlayer *)player1 robot:(JPWRobot *)robot wildSuit:(NSString *)wildSuit;
- (instancetype)initWithGame:(JPWGame *)game player:(JPWPlayer *)player1 robot:(JPWRobot *)robot wildSuit:(NSString *)wildSuit;

- (void)robotTurn:(JPWRobot *)robot;
-(BOOL)playRound:(JPWPlayingCard *)card player:(JPWPlayer *)player;
-(void)endOfTurnCheck;

@end
