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
#import <QuartzCore/QuartzCore.h>


@interface MultiViewController ()

@end

@implementation MultiViewController {
@private NSMutableArray *cardList;
@private JPWPlayer *user;
@private JPWRobot *robot;
@private JPWGame *game;
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
    [self loadNewGame];
}

-(void)initializeServer {
    NSNumber *number_of_players = self.number_of_players;
    NSNumber *number_of_robots = self.number_of_robots;
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setHTTPMethod:@"POST"];
    [request setURL:[NSURL URLWithString:@"http://localhost:3000/crazy_eights"]];
    [request setHTTPBody:[[NSString stringWithFormat:@"number_of_players=%@&number_of_robots=%@&game=%@", number_of_players, number_of_robots, @""] dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSError *error = [[NSError alloc] init];
    NSHTTPURLResponse *responseCode = nil;
    
    NSData *oResponseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&responseCode error:&error];
    
    if([responseCode statusCode] != 200){
        NSLog(@"Error getting %@, HTTP status code %li", @"localhost:3000/crazy_eights", (long)[responseCode statusCode]);
    } else {
        NSLog(@"%@", oResponseData);
    }
}

-(void)joinServer {
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setHTTPMethod:@"GET"];
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://localhost:3000/crazy_eights/%@", self.game_id]]];
//    [request setHTTPBody:[[NSString stringWithFormat:@"number_of_players=%@ number_of_robots=%@", number_of_players, number_of_robots] dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSError *error = [[NSError alloc] init];
    NSHTTPURLResponse *responseCode = nil;
    
    NSData *oResponseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&responseCode error:&error];
    
    if([responseCode statusCode] != 200){
        NSLog(@"Error getting %@, HTTP status code %li", @"localhost:3000/crazy_eights", (long)[responseCode statusCode]);
    } else {
        NSError *error = nil;
//        NSData *jsonData = [oResponseData dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary* json = [NSJSONSerialization JSONObjectWithData:oResponseData options:kNilOptions error:&error];;
        if ([json[@"game"][@"data"]  isEqual: @""]) {
//            if([json[@"users"] length] + 1 == (int)json[@"game"][@"number_of_players"]) {
                cardList = [NSMutableArray new];
                game = [JPWGame new];
                user = [JPWPlayer newWithName:self.name];
                [game addPlayer:user];
//                for (int i = 0; i < [json[@"users"] length]; i++) {
//                    JPWPlayer *player = [JPWPlayer newWithName:json[@"users"][i]];
//                    [game addPlayer:player];
//                }
//            for (int i = 0; i < (int)json[@"game"][@"number_of_players"]; i++) {
                JPWPlayer *player = [JPWPlayer newWithName:@"Jeremy"];
                [game addPlayer:player];
//            }
                [game setup];
                [self updatePlayerInfo];
//                need to upload to server
//            } else {
////                need to make call to update and provide name
//            }
        } else {
//            [self convertFromJson:json[@"game"][@"data"]];
        }
//        NSLog(@"data: %@", json[@"game"][@"data"]);
    }
}

-(void)loadNewGame {
    [self updatePlayerInfo];
    if (self.create == YES) {
        //create
        [self initializeServer];
    }else {
        //join
        [self joinServer];
    }
    user = game.players[0];
    robot = game.players[1];
    turnManager = [JPWTurnManager newWithGame:game player:user robot:robot wildSuit:wildSuit];
    [self updatePlayerInfo];
}

-(void)tapDetected{
    if ([[game.deck size] integerValue] > 0) {
        if ([[game whosTurn] isEqual:user.name]) {
            [user addCardToHand:[game draw]];
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
//    [self convertFromJson:[self convertToJson]];
//    [self sendToServer];
}

-(NSString *)convertToJson {
    NSDictionary *dictionary = [game toNSDictionary];
    NSError *writeError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:0 error:&writeError];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return jsonString;
}

-(void)convertFromJson:(NSString *)jsonGame {
    NSError *error = nil;
    NSData *jsonData = [jsonGame dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary* json = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&error];
    [game fromNSDictionary:json];
}

-(void)sendToServer {
    NSString *jsonGame = [self convertToJson];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setHTTPMethod:@"POST"];
    [request setURL:[NSURL URLWithString:@"http://localhost:3000/crazy_eights"]];
    [request setHTTPBody:[[NSString stringWithFormat:@"game=%@", jsonGame] dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSError *error = [[NSError alloc] init];
    NSHTTPURLResponse *responseCode = nil;
    
    NSData *oResponseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&responseCode error:&error];
    
    if([responseCode statusCode] != 200){
        NSLog(@"Error getting %@, HTTP status code %li", @"localhost:3000/crazy_eights", (long)[responseCode statusCode]);
    } else {
        NSLog(@"%@", oResponseData);
    }
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
    if ([user.hand.cards count] == 0 || [robot.hand.cards count] == 0 || [[game.deck size] integerValue] <= 0) {
        if ([[game.deck size] integerValue] <= 0) {
            [self showAlert:@"The deck ran out of cards, so you tied."];
        }
        [self.navigationController popViewControllerAnimated:YES];
    }
}

-(void)updatePlayerInfo {
    [user.hand sortCards];
    cardList = user.hand.cards;
    [opponentViewController setCardAmount:[robot.hand.cards count]];
    NSString *info = [NSString stringWithFormat:@"Cards left in deck: %@. Opponent cards: %lu. Your cards: %lu.", [game.deck size], (unsigned long)[robot.hand.cards count], (unsigned long)[user.hand.cards count]];
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
