//
//  JPWGame.h
//  CrazyEightsModel
//
//  Created by Jeremy on 1/24/14.
//  Copyright (c) 2014 Jeremy-Walton. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JPWPlayer.h"
#import "JPWDeck.h"
#import "JPWDiscardPile.h"

@interface JPWGame : NSObject

@property (nonatomic, strong, readonly) NSMutableArray *turnOrder;
@property (nonatomic, strong, readonly) NSMutableArray *players;
@property (nonatomic, strong, readonly) JPWDiscardPile *discardPile;

- (NSNumber *)numberOfPlayers;
- (void)addPlayer:(JPWPlayer *)player;
- (JPWPlayingCard *)draw;
- (void)dealCards;
- (void)setup;
- (void)setTurnOrder;
- (NSString *)whosTurn;
- (void)changeTurnOrder;
- (void)discard:(JPWPlayingCard *)card;
- (void)discardTopCard;

//logic methods
-(void)playCard:(JPWPlayingCard *)card from:(JPWPlayer *)player;
-(BOOL)isCardValid:(JPWPlayingCard *)card;

//testing methods
- (void)makeDeckForTest;
- (void)makeDiscardPileForTest;
- (NSNumber *)testDeckSize;
- (NSNumber *)testDiscardPileSize;
- (void)shuffleDeck;

@end
