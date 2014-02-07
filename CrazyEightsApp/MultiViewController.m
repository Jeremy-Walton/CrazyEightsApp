//
//  MultiViewController.m
//  CrazyEightsApp
//
//  Created by Jeremy on 2/4/14.
//  Copyright (c) 2014 Jeremy-Walton. All rights reserved.
//

#import "MultiViewController.h"
#import "JPWGame.h"
#import "JPWPlayer.h"
#import "JPWRobot.h"
#import "CardCell.h"
#import "CoverFlowLayout.h"
#import "JPWTurnManager.h"
#import "OpponentView.h"


@interface MultiViewController ()

@end

@implementation MultiViewController {
@private NSMutableArray *cardList;
@private JPWPlayer *player1;
@private JPWRobot *robot;
@private JPWGame *game;
@private JPWTurnManager *turnManager;
@private NSString *wildSuit;
@private OpponentView *opponentViewController;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    UIPinchGestureRecognizer *pinchRecognizer = [[UIPinchGestureRecognizer alloc]
                                                 initWithTarget:self action:@selector(handlePinchGesture:)];
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDetected)];
    singleTap.numberOfTapsRequired = 1;
    self.deckImage.userInteractionEnabled = YES;
    [self.deckImage addGestureRecognizer:singleTap];
    
    [self.collectionView addGestureRecognizer:pinchRecognizer];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.layer.needsDisplayOnBoundsChange = YES;
    
    opponentViewController = [OpponentView new];
    [self addChildViewController:opponentViewController];

    [self.OpponentView setTransform:CGAffineTransformMakeRotation(M_PI)];
    self.OpponentView.dataSource = opponentViewController;
    self.OpponentView.delegate = self;
    
    [self loadNewGame];
}

-(void)loadNewGame {
    cardList = [NSMutableArray new];
    game = [JPWGame new];
    player1 = [JPWPlayer newWithName:@"Jeremy"];
    robot = [JPWRobot newWithName:@"Sam"];
    [game addPlayer:player1];
    [game addRobot:robot];
    [game setup];
    [self updatePlayerInfo];
    turnManager = [JPWTurnManager newWithGame:game player:player1 robot:robot wildSuit:wildSuit];
}

-(void)tapDetected{
    if ([[game.deck size] integerValue] > 0) {
        if ([[game whosTurn] isEqual:player1.name]) {
            [player1 addCardToHand:[game draw]];
            [game changeTurnOrder];
            [self updatePlayerInfo];
            
            [turnManager robotTurn:robot];
            [self updatePlayerInfo];
        } else {
            [self showAlert:@"It isn't your turn."];
        }
    } else {
        [self showAlert:@"No more cards, sorry."];
    }
    [self endOfGameCheck];
}

- (void)handlePinchGesture:(UIPinchGestureRecognizer *)sender {
    if ([sender numberOfTouches] != 2)
        return;
    
    // Get the pinch points.
    CGPoint p1 = [sender locationOfTouch:0 inView:[self collectionView]];
    CGPoint p2 = [sender locationOfTouch:1 inView:[self collectionView]];
    
    // Compute the new spread distance.
    CGFloat xd = p1.x - p2.x;
    CGFloat yd = p1.y - p2.y;
    CGFloat distance = sqrt(xd*xd + yd*yd);
    
    // Update the custom layout parameter and invalidate.
    
    if (distance > 200) {
        UICollectionViewFlowLayout *flowLayout = [UICollectionViewFlowLayout new];
        [self.collectionView setCollectionViewLayout:flowLayout];
    } else {
        CollectionViewLayout *fanLayout = [CollectionViewLayout new];
        [self.collectionView setCollectionViewLayout:fanLayout];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView*)collectionView {
    // _data is a class member variable that contains one array per section.
    return 1;
}

- (NSInteger)collectionView:(UICollectionView*)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return [cardList count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CardCell *newCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    newCell.imageView.image = [UIImage imageNamed:[cardList[indexPath.row] description]];
    if (![game isCardValid:cardList[indexPath.row]]) {
        newCell.alpha = 0.3;
    }
    return newCell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(71, 96);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [self.handDelegate didSelectCard:cardList[indexPath.row]];
    
    UICollectionViewCell  *cell = [collectionView cellForItemAtIndexPath:indexPath];
    
    [UIView animateWithDuration:1.0
                          delay:0
                        options:(UIViewAnimationOptionAllowUserInteraction)
                     animations:^
     {
         NSLog(@"start");
//                 CGRect frame = cell.frame;
//                 frame.origin.y -= 100;
//                 cell.frame = frame;
         //        cell.transform = CGAffineTransformMakeRotation(180 * 3.14/180);
                 [cell.superview bringSubviewToFront:cell];
                 cell.transform = CGAffineTransformMakeScale(1.3, 1.3);
     }
                     completion:^(BOOL finished)
     {
//                 [UIView animateWithDuration:1.0 animations:^{
//                     cell.transform = CGAffineTransformMakeScale(1, 1);
//                     cell.transform = CGAffineTransformMakeRotation(0);
//                 }];
         NSLog(@"end");
         
         //player clicked card.
         JPWPlayingCard *card = cardList[indexPath.row];
         if ([turnManager playRound:card player:player1]) {
             if ([card.rank isEqual:@"8"]) {
                 [self suitChange:@"Please choose a suit to use."];
             } else {
                 [self endOfGameCheck];
             }
             [self updatePlayerInfo];
         }
         
         [turnManager robotTurn:robot];
         if (![card.rank isEqual:@"8"]) {
             [self endOfGameCheck];
         }
         [self updatePlayerInfo];
     }
     ];
}

-(void)endOfGameCheck {
    if ([player1.hand.cards count] == 0 || [robot.hand.cards count] == 0 || [[game.deck size] integerValue] <= 0) {
        if ([[game.deck size] integerValue] <= 0) {
            [self showAlert:@"The deck ran out of cards, so you tied."];
        }
        [self.navigationController popViewControllerAnimated:YES];
    }
}

-(void)updatePlayerInfo {
    [player1.hand sortCards];
    cardList = player1.hand.cards;
    [opponentViewController setCardAmount:[robot.hand.cards count]];
    NSString *info = [NSString stringWithFormat:@"Cards left in deck: %@. Opponent cards: %lu. Your cards: %lu.", [game.deck size], (unsigned long)[robot.hand.cards count], (unsigned long)[player1.hand.cards count]];
    self.GameInfoLabel.text = info;
    self.DiscardImage.image = [UIImage imageNamed:[[game.discardPile showTopCard] description]];
    if ([[game.deck size] integerValue] == 0) {
        self.deckImage.image = [UIImage imageNamed:@"jb"];
    }
    self.collectionView.reloadData;
    self.OpponentView.reloadData;
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

- (void) suitChange:(NSString *)message {
    
    UIActionSheet *popup = [[UIActionSheet alloc] init];
                            [popup setTitle:message];
                            [popup setDelegate:self];
                            [popup addButtonWithTitle:@"Hearts"];
                            [popup addButtonWithTitle:@"Spades"];
                            [popup addButtonWithTitle:@"Diamonds"];
                            [popup addButtonWithTitle:@"Clubs"];
    popup.tag = 1;
    [popup showInView:[UIApplication sharedApplication].keyWindow];
}

- (void)actionSheet:(UIActionSheet *)popup clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    switch (popup.tag) {
        case 1: {
            switch (buttonIndex) {
                case 0:
                     wildSuit = @"Hearts";
                    break;
                case 1:
                    wildSuit = @"Spades";
                    break;
                case 2:
                    wildSuit = @"Diamonds";
                    break;
                case 3:
                    wildSuit = @"Clubs";
                    break;
                default:
                    break;
            }
            break;
        }
        default:
            break;
    }
    
    JPWPlayingCard *newCard = [JPWPlayingCard newWithRank:@"8" suit:wildSuit];
    [game discard:newCard];
    [turnManager endOfTurnCheck];

    [turnManager robotTurn:robot];
    [self endOfGameCheck];
    [self updatePlayerInfo];
}

@end
