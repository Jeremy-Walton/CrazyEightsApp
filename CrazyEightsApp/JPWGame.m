//
//  JPWGame.m
//  CrazyEightsModel
//
//  Created by Jeremy on 1/24/14.
//  Copyright (c) 2014 Jeremy-Walton. All rights reserved.
//

#import "JPWGame.h"
#import "JPWPlayer.h"
#import "JPWRobot.h"
#import "JPWDeck.h"
#import "JPWDiscardPile.h"

@interface JPWGame()
@property (nonatomic, strong) NSMutableArray *players;
@property (nonatomic, strong) JPWDeck *deck;
@property (nonatomic, strong) JPWDiscardPile *discardPile;
@property (nonatomic, strong) NSMutableArray *turnOrder;
@property (nonatomic, strong) NSNumber *gameID;
@property (nonatomic, getter=isReady) BOOL ready;
@end

@implementation JPWGame

+(instancetype)newWithID:(NSNumber *)gameID {
    JPWGame *game = [self new];
    game.gameID = gameID;
    return game;
}

-(void)setPlayersWithNames:(NSMutableArray *)names {
    for (NSString *name in names) {
        JPWPlayer *player = [JPWPlayer newWithName:name];
        [self addPlayer:player];
    }
}

- (void)startupGame {
    self.ready = YES;
    [self setup];
}

- (id)init {
    
    self = [super init];
    if(self) {
        _turnOrder = [NSMutableArray new];
        _players = [NSMutableArray new];
        _deck = [JPWDeck new];
        _discardPile = [JPWDiscardPile new];
    }
    return self;
}

- (NSNumber *)numberOfPlayers {
    return @([self.players count]);
}

- (void)addPlayer:(JPWPlayer *)player {
    [self.players addObject:player];
}

- (void)addRobot:(JPWRobot *)player {
    [self.players addObject:player];
}

- (JPWPlayingCard *)draw {
    return [self.deck takeTopCard];
}

- (void)dealCards {
    if ([self.numberOfPlayers  isEqual: @2]) {
        // deal 7
        for (int i = 0; i < [self.numberOfPlayers integerValue]; i++) {
            for (int j = 0; j < 7; j++) {
                [[self.players objectAtIndex:i] addCardToHand:[self draw]];
            }
        }
    } else {
        for (int i = 0; i < [self.numberOfPlayers integerValue]; i++) {
            for (int j = 0; j < 5; j++) {
                [[self.players objectAtIndex:i] addCardToHand:[self draw]];
            }
        }

    }
}

- (void)setup {
    [self.deck shuffle];
    [self dealCards];
    [self setTurnOrder];
    [self discardTopCard];
}

- (void)setTurnOrder {
    for (int i = 0; i < [self.numberOfPlayers integerValue]; i++) {
        [self.turnOrder addObject:[[self.players objectAtIndex:i] name]];
    }
}

- (void)changeTurnOrder {
    for (NSUInteger i = [self.turnOrder count] - 1; i > 0; i--) {
    	NSObject *obj = [self.turnOrder lastObject];
    	[self.turnOrder insertObject:obj atIndex:0];
    	[self.turnOrder removeLastObject];
    }
}

- (NSString *)whosTurn {
    return [self.turnOrder objectAtIndex:0];
}

- (void)discard:(JPWPlayingCard *)card {
    [self.discardPile addCard:card];
}

- (void)discardTopCard {
    [self.discardPile addCard:[self.deck takeTopCard]];
}

//logic methods

-(BOOL)isCardValid:(JPWPlayingCard *)card {
    JPWPlayingCard *discard = [self.discardPile showTopCard];
        return ([card.rank isEqual:discard.rank]  || [card.suit isEqual:discard.suit] || [card.rank isEqual:@"8"]);
}

-(void)playCard:(JPWPlayingCard *)card from:(JPWPlayer *)player {
    [self.discardPile addCard:[player takeCardFromPlayer:card]];
}

-(void)playRobotCard:(JPWPlayingCard *)card from:(JPWRobot *)player {
    [self.discardPile addCard:[player takeCardFromPlayer:card]];
}

//These four methods are for testing purposes only.

- (void)makeDeckForTest {
    _deck = [JPWDeck new];
}

- (void)makeDiscardPileForTest {
    _discardPile = [JPWDiscardPile new];
}

- (NSNumber *)testDeckSize {
    return [self.deck size];
}

- (NSNumber *)testDiscardPileSize {
    return [self.discardPile size];
}

- (void)shuffleDeck {
    [self.deck shuffle];
}

- (NSDictionary *)toNSDictionary
{
    NSMutableArray *array =  [NSMutableArray arrayWithCapacity: [self.players count]];
    for (int i = 0; i < [self.players count]; i++) {
        [array addObject:[[self.players objectAtIndex:i] toNSDictionary]];
    }
    return @{@"players": array, @"deck": [self.deck toNSDictionary], @"discardPile": [self.discardPile toNSDictionary], @"turnOrder": self.turnOrder};
}

- (void)fromNSDictionary:(NSDictionary *)dictionary {
    NSArray *playersDictionary = dictionary[@"players"];
    NSMutableArray *newPlayers = [[NSMutableArray alloc] init];
    for (int i = 0; i < [playersDictionary count]; i++) {
        JPWPlayer *player = [JPWPlayer newWithName:playersDictionary[i][@"name"]];
        [player fromNSDictionary:playersDictionary[i]];
        [newPlayers addObject:player];
    }
    self.players = newPlayers;
    [self.deck fromNSDictionary:dictionary[@"deck"]];
    [self.discardPile fromNSDictionary:dictionary[@"discardPile"]];
    NSMutableArray *playerNames =  [NSMutableArray arrayWithCapacity: [self.players count]];
    for (int i = 0; i < [self.players count]; i++) {
        [playerNames addObject:[self.players[i] name]];
    }
    self.turnOrder = playerNames;
}

@end
