//
//  JPWTurnManager.m
//  CrazyEightsApp
//
//  Created by Jeremy on 2/6/14.
//  Copyright (c) 2014 Jeremy-Walton. All rights reserved.
//

#import "JPWTurnManager.h"
#import "JPWPlayingCard.h"
#import "JPWRobot.h"
#import "JPWPlayer.h"
#import "MultiViewController.h"

@implementation JPWTurnManager

+ (instancetype)newWithGame:(JPWGame *)game player:(JPWPlayer *)player1 robot:(JPWRobot *)robot wildSuit:(NSString *)wildSuit
{
    return [[self alloc] initWithGame:game player:player1 robot:robot wildSuit:wildSuit];
}

- (instancetype)initWithGame:(JPWGame *)game player:(JPWPlayer *)player1 robot:(JPWRobot *)robot wildSuit:(NSString *)wildSuit
{
    self = [super init];
    if (self) {
        _game = game;
        _robot = robot;
        _player1 = player1;
        _wildSuit = wildSuit;
    }
    return self;
}

-(BOOL)playRound:(JPWPlayingCard *)card player:(JPWPlayer *)player {
    if ([[self.game whosTurn] isEqual:player.name]) {
        if ([self.game isCardValid:card]) {
            if ([card.rank isEqual:@"8"]) {
                [player takeCardFromPlayer:card];
                return YES;
            } else {
                [self.game playCard:card from:player];
                [self endOfTurnCheck];
                return YES;
            }
        } else {
            [self showAlert:@"Please choose a valid card."];
            return NO;
        }
    } else {
        [self showAlert:@"It isn't your turn."];
        return NO;
    }
}

-(void)robotTurn:(JPWRobot *)robot {
    JPWPlayingCard *robotCard = [robot chooseCard];
    
    if ([self playRobotRound:robotCard player:robot]) {
        [self showAlert:@"Robot played"];
    } else {
        if ([[self.game whosTurn] isEqual:robot.name]) {
            if ([[self.game.deck size] integerValue] > 0) {
                [robot addCardToHand:[self.game draw]];
                [self.game changeTurnOrder];
                [self showAlert:@"Robot drew from deck" ];
            } else {
                [self showAlert:@"Robot tried to draw from the deck but there are no cards in it." ];
                [self.game changeTurnOrder];
            }
        }
    }
}

-(BOOL)playRobotRound:(JPWPlayingCard *)card player:(JPWRobot *)player {
    if ([[self.game whosTurn] isEqual:player.name]) {
        if ([self.game isCardValid:card]) {
            if ([card.rank isEqual:@"8"]) {
                self.wildSuit = @"Spades";
                JPWPlayingCard *newCard = [JPWPlayingCard newWithRank:@"8" suit:self.wildSuit];
                [self.game discard:newCard];
                [player takeCardFromPlayer:card];
                [self endOfTurnCheck];
                
                return YES;
            } else {
                [self.game playRobotCard:card from:player];
                [self endOfTurnCheck];
                
                return YES;
            }
        } else {
            return NO;
        }
    } else {
        return NO;
    }
}

-(void)endOfTurnCheck {
    if ([self.player1.hand.cards count] == 0 || [self.robot.hand.cards count] == 0) {
        if ([self.player1.hand.cards count] == 0) {
            [self showAlert:@"Game over, You won!"];
        } else {
            [self showAlert:@"Game over, The Computer Won."];
        }
    } else {
        [self.game changeTurnOrder];
    }
}

- (void) showAlert:(NSString *)message {
    
    UIAlertView *alert = [[UIAlertView alloc]
                          
                          initWithTitle:@""
                          message:message
                          delegate:nil
                          cancelButtonTitle:@"Ok"
                          otherButtonTitles:nil];
    
    [alert show];
}

@end
