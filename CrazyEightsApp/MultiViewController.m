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
#import "CardCell.h"
#import "CoverFlowLayout.h"


@interface MultiViewController ()

@end

@implementation MultiViewController {
@private NSMutableArray *labelList;
@private JPWPlayer *player1;
@private JPWGame *game;
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
//    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:[CoverFlowLayout new]];
//    collectionView.dataSource = self;
//    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
//    
//    [self.view addSubview:collectionView];
    
    UIPinchGestureRecognizer *pinchRecognizer = [[UIPinchGestureRecognizer alloc]
                                                 initWithTarget:self action:@selector(handlePinchGesture:)];
    
    // Specify that the gesture must be a single tap
    //    pinchRecognizer.numberOfTouches = 2;
    
    // Add the tap gesture recognizer to the view
    [self.collectionView addGestureRecognizer:pinchRecognizer];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.layer.needsDisplayOnBoundsChange = YES; 
//    [self.collectionView registerClass:[CardCell class] forCellWithReuseIdentifier:@"cell"];
    
    labelList = [NSMutableArray new];
    game = [JPWGame new];
    player1 = [JPWPlayer newWithName:@"Jeremy"];
    [game addPlayer:player1];
    [game setup];
    self.DiscardImage.image = [UIImage imageNamed:[[game.discardPile showTopCard] description]];
    NSArray *playerCards = player1.hand.cards;
    for (JPWPlayingCard *card in playerCards) {
        [labelList addObject:[card description]];
    }
//    self.view.backgroundColor = [UIColor blackColor];
//    self.collectionView.backgroundColor = [UIColor colorWithRed:0.1 green:1 blue:0 alpha:0.5];
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
        
        CoverFlowLayout *flowLayout = [CoverFlowLayout new];
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
    
    return [labelList count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CardCell *newCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    newCell.imageView.image = [UIImage imageNamed:[labelList objectAtIndex:indexPath.row]];
    return newCell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(71, 96);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    CardCell *cell = (CardCell *)[collectionView cellForItemAtIndexPath:indexPath];
    [self.handDelegate didSelectCard:[labelList objectAtIndex:indexPath.row]];
    
//    UICollectionViewCell  *cell = [collectionView cellForItemAtIndexPath:indexPath];
    
    [UIView animateWithDuration:1.0
                          delay:0
                        options:(UIViewAnimationOptionAllowUserInteraction)
                     animations:^
     {
         NSLog(@"starting animation");
//                 CGRect frame = cell.frame;
//                 frame.origin.y -= 100;
//                 cell.frame = frame;
         //        cell.transform = CGAffineTransformMakeRotation(180 * 3.14/180);
//                 [cell.superview bringSubviewToFront:cell];
//                 cell.transform = CGAffineTransformMakeRotation(180 * M_PI/180);
//                 cell.transform = CGAffineTransformMakeScale(2, 2);
//                 [UIView transitionFromView:cell.contentView
//                                     toView:cell.contentView
//                                   duration:.5
//                                    options:UIViewAnimationOptionTransitionFlipFromRight
//                                 completion:nil];
     }
                     completion:^(BOOL finished)
     {
//                 [UIView animateWithDuration:1.0 animations:^{
//                     cell.transform = CGAffineTransformMakeScale(1, 1);
//                     cell.transform = CGAffineTransformMakeRotation(0);
//                 }];
         NSLog(@"animation end");
         
         //player clicked card.
         NSString *name = [labelList objectAtIndex:indexPath.row];
         NSLog(name);
         // need card not description
         JPWPlayingCard *card = [labelList objectAtIndex:indexPath.row];
         if ([[game whosTurn] isEqual:player1.name]) {
             if ([game isCardValid:card]) {
                 if ([card.rank isEqual:@"8"]) {
                     //Would display suit change buttons.
                     NSLog(@"Display some new buttons here!");
                     [game playCard:card from:player1];
                     [game changeTurnOrder];
                 } else {
                     [game playCard:card from:player1];
                     [game changeTurnOrder];
                     NSLog(@"Played a card!");
                 }
             } else {
                 NSLog(@"Not a valid card.");
             }
         } else {
             NSLog(@"Not your turn.");
         }

         
//         NSArray *indexPaths = @[indexPath];
//         [labelList removeObjectAtIndex:indexPath.row];
//         [collectionView deleteItemsAtIndexPaths:indexPaths];
     }
     ];
}

@end
