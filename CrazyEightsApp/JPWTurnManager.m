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
//TODO Don't need wildSuit
+ (instancetype)newWithGame:(JPWGame *)game player:(JPWPlayer *)user wildSuit:(NSString *)wildSuit
{
    return [[self alloc] initWithGame:game player:user wildSuit:wildSuit];
}

- (instancetype)initWithGame:(JPWGame *)game player:(JPWPlayer *)user wildSuit:(NSString *)wildSuit
{
    self = [super init];
    if (self) {
        _game = game;
//        _robot = robot;
        _user = user;
        _wildSuit = wildSuit;
    }
    return self;
}

-(BOOL)playRound:(JPWPlayingCard *)card player:(JPWPlayer *)user {
    if ([[self.game whosTurn] isEqual:user.name]) {
        if ([self.game isCardValid:card]) {
            if ([card.rank isEqual:@"8"]) {
                [user takeCardFromPlayer:card];
            } else {
                [self.game playCard:card from:user];
                [self endOfTurnCheck];
                [self.game changeTurnOrder];
            }
        } else {
            [self showAlert:@"Please choose a valid card."];
            return NO;
        }
        return YES;
    } else {
        [self showAlert:@"It isn't your turn."];
        return NO;
    }
}

//-(void)robotTurn:(JPWRobot *)robot {
//    JPWPlayingCard *robotCard = [robot chooseCard];
//    
//    if ([self playRobotRound:robotCard player:robot]) {
//        [self showAlert:@"Robot played"];
//    } else {
//        if ([[self.game whosTurn] isEqual:robot.name]) {
//            if ([[self.game.deck size] integerValue] > 0) {
//                [robot addCardToHand:[self.game draw]];
//                [self.game changeTurnOrder];
//                [self showAlert:@"Robot drew from deck" ];
//            } else {
//                [self showAlert:@"Robot tried to draw from the deck but there are no cards in it." ];
//                [self.game changeTurnOrder];
//            }
//        }
//    }
//}

//-(BOOL)playRobotRound:(JPWPlayingCard *)card player:(JPWRobot *)player {
//    if ([[self.game whosTurn] isEqual:player.name]) {
//        if ([self.game isCardValid:card]) {
//            if ([card.rank isEqual:@"8"]) {
//                self.wildSuit = @"Spades";
//                JPWPlayingCard *newCard = [JPWPlayingCard newWithRank:@"8" suit:self.wildSuit];
//                [self.game discard:newCard];
//                [player takeCardFromPlayer:card];
//                [self endOfTurnCheck];
//                
//                return YES;
//            } else {
//                [self.game playRobotCard:card from:player];
//                [self endOfTurnCheck];
//                
//                return YES;
//            }
//        } else {
//            return NO;
//        }
//    } else {
//        return NO;
//    }
//}

-(void)endOfTurnCheck {
    for (JPWPlayer *player in self.game.players) {
        if ([player.hand.cards count] == 0) {
            [self showAlert:[NSString stringWithFormat:@"Game over, %@ won!", player.name]];
        }
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
