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
#import "OpponentViewController.h"
#import "JPWWebClient.h"
#import <QuartzCore/QuartzCore.h>


@interface MultiViewController ()
@property JPWGame *game;

@end

@implementation MultiViewController {
@private NSMutableArray *cardList;
@private JPWPlayer *user;
@private JPWPlayer *opponent;
@private JPWTurnManager *turnManager;
@private NSString *wildSuit;
@private OpponentViewController *opponentViewController;
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
    
    opponentViewController = [OpponentViewController new];

    [self.OpponentView setTransform:CGAffineTransformMakeRotation(M_PI)];
    self.OpponentView.dataSource = opponentViewController;
    self.OpponentView.delegate = self;
    [self addChildViewController:opponentViewController];
    [self loadNewGame]; // this gets replaced by observer
}

-(void)loadNewGame {
//    move to game creator controller.
    if (self.create == YES) {
        //create
        self.game = [[JPWWebClient sharedClient] initializeServerWithNumberOfPlayers:self.number_of_players andNumberOfRobots:self.number_of_robots];
        self.game_id = self.game.gameID;
    }else {
        //join
        self.game = [[JPWWebClient sharedClient] joinGame:self.game_id];
    }
}

-(void)setGame:(JPWGame *)game {
    _game = game;
    if ([_game isReady]) {
        //    need to get correct user.
        user = _game.players[0];
        opponent = _game.players[1];
        turnManager = [JPWTurnManager newWithGame:_game player:user wildSuit:wildSuit];
        //    make observer on game in viewDidLoad that calls this.
        [self updatePlayerInfo];
    }

}

-(void)tapDetected{
//    move to turn manager ui shows alert based on true/false
    if ([[self.game.deck size] integerValue] > 0) {
        if ([[self.game whosTurn] isEqual:user.name]) {
            [user addCardToHand:[self.game draw]];
            [self.game changeTurnOrder];
            [self updatePlayerInfo];
        } else {
            [self showAlert:@"It isn't your turn."];
        }
    } else {
        [self showAlert:@"No more cards, sorry."];
    }
    [self endOfGameCheck];
//    send to server.
    [[JPWWebClient sharedClient] sendGameToServer:[self.game convertToJSON] withID:self.game_id];
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
        flowLayout.sectionInset = UIEdgeInsetsMake(20.0, 20.0, 20.0, 20.0);
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
    if (![self.game isCardValid:cardList[indexPath.row]]) {
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
                 [cell.superview bringSubviewToFront:cell];
                 cell.transform = CGAffineTransformMakeScale(1.3, 1.3);
     }
                     completion:^(BOOL finished)
     {
         NSLog(@"end");
         
         //player clicked card.
         JPWPlayingCard *card = cardList[indexPath.row];
         if ([turnManager playRound:card player:user]) {
             if ([card.rank isEqual:@"8"]) {
                 [self suitChange:@"Please choose a suit to use."];
             } else {
                 [self endOfGameCheck];
             }
             [self updatePlayerInfo];
//             send to server.
             [[JPWWebClient sharedClient] sendGameToServer:[self.game convertToJSON] withID:self.game_id];
         }
     }
     ];
}

-(void)endOfGameCheck {
    for (JPWPlayer *player in self.game.players) {
        if ([player.hand.cards count] == 0) {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
    if ([[self.game.deck size] integerValue] <= 0) {
        [self showAlert:@"The deck ran out of cards, so you tied."];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

-(void)updatePlayerInfo {
    [user.hand sortCards];
    cardList = user.hand.cards;
    [opponentViewController setCardAmount:[opponent.hand.cards count]];
    NSString *info = [NSString stringWithFormat:@"Cards left in deck: %@. Opponent cards: %lu. Your cards: %lu.", [self.game.deck size], (unsigned long)[opponent.hand.cards count], (unsigned long)[user.hand.cards count]];
    self.GameInfoLabel.text = info;
    self.DiscardImage.image = [UIImage imageNamed:[[self.game.discardPile showTopCard] description]];
    if ([[self.game.deck size] integerValue] == 0) {
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
            wildSuit = @[@"Hearts", @"Spades", @"Diamonds", @"Clubs"][buttonIndex];
            break;
        }
        default:
            break;
    }
    
    JPWPlayingCard *newCard = [JPWPlayingCard newWithRank:@"8" suit:wildSuit];
    [self.game discard:newCard];
    [turnManager endOfTurnCheck];
    [self endOfGameCheck];
    [self updatePlayerInfo];
}

- (IBAction)updateClient:(id)sender {
//    retrieve from server.
    JPWGame *newGame = [[JPWWebClient sharedClient] retrieveGameFromServer:self.game_id];
    if ([newGame isReady]) {
        self.game = newGame;
    }
    [self updatePlayerInfo];
}
@end
