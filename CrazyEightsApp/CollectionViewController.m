//
//  CollectionViewController.m
//  CrazyEightsApp
//
//  Created by Jeremy on 1/28/14.
//  Copyright (c) 2014 Jeremy-Walton. All rights reserved.
//

#import "CollectionViewController.h"
#import "JPWPlayer.h"
#import "JPWGame.h"
#import "CardCell.h"

@interface CollectionViewController ()

@end

@implementation CollectionViewController {
@private NSMutableArray *labelList;
@private JPWPlayer *player1;
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
    
    // Specify that the gesture must be a single tap
//    pinchRecognizer.numberOfTouches = 2;
    
    // Add the tap gesture recognizer to the view
    [self.collectionView addGestureRecognizer:pinchRecognizer];
    
    labelList = [NSMutableArray new];
    JPWGame *game = [JPWGame new];
    player1 = [JPWPlayer newWithName:@"Jeremy"];
    [game addPlayer:player1];
    [game makeDeckForTest];
    [game makeDiscardPileForTest];
    [game shuffleDeck];
    [game dealCards];
    
    NSArray *playerCards = player1.hand.cards;
    for (JPWPlayingCard *card in playerCards) {
        [labelList addObject:[card description]];
    }
    
    // Configure layout
//    self.collectionViewLayout = [[CollectionViewLayout alloc] init];
    self.collectionView.backgroundColor = [UIColor greenColor];
//    self.flowLayout = [[UICollectionViewFlowLayout alloc] init];
//    [self.flowLayout setItemSize:CGSizeMake(191, 160)];
//    [self.flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
//    self.flowLayout.minimumInteritemSpacing = 0.0f;
//      [self.collectionView setCollectionViewLayout:self.flowLayout];
//    self.collectionView.bounces = YES;
//    [self.collectionView setShowsHorizontalScrollIndicator:NO];
//    [self.collectionView setShowsVerticalScrollIndicator:NO];
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

//    self.flowLayout.minimumInteritemSpacing = distance;
    if (distance > 200) {
//        [self.collectionViewLayout setStackFactor:100];
        [self.collectionView setCollectionViewLayout:[UICollectionViewFlowLayout new]];
//        [self.collectionView setCollectionViewLayout:self.flowLayout];
    } else {
//        [self.collectionViewLayout setStackFactor:0];
        [self.collectionView setCollectionViewLayout:[CollectionViewLayout new]];
//        [self.collectionView setCollectionViewLayout:self.collectionViewLayout];
    }
    
//    [self.flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
//    [self.flowLayout invalidateLayout];
}

//- (UIEdgeInsets)collectionView:
//(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
//    return UIEdgeInsetsMake(0, 0, 0, 0);
//}

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
//    cardCell *newCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    CardCell *newCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    newCell.imageView.image = [UIImage imageNamed:[labelList objectAtIndex:indexPath.row]];
    newCell.label.text = [NSString stringWithFormat:@"%@", [labelList objectAtIndex:indexPath.row]];
    return newCell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(142, 192);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
//    CardCell *cell = (CardCell *)[collectionView cellForItemAtIndexPath:indexPath];
    [self.handDelegate didSelectCard:[labelList objectAtIndex:indexPath.row]];
    
    UICollectionViewCell  *cell = [collectionView cellForItemAtIndexPath:indexPath];
    
    [UIView animateWithDuration:1.0
delay:0
options:(UIViewAnimationOptionAllowUserInteraction)
animations:^
    {
        NSLog(@"starting animation");
        CGRect frame = cell.frame;
        frame.origin.y += 100;
        cell.frame = frame;
//        [UIView transitionFromView:cell.contentView
//                            toView:cell.contentView
//                          duration:.5
//                           options:UIViewAnimationOptionTransitionFlipFromRight
//                        completion:nil];
    }
completion:^(BOOL finished)
    {
        NSLog(@"animation end");
//        NSArray *indexPaths = @[indexPath];
//        [labelList removeObjectAtIndex:indexPath.row];
//        [collectionView deleteItemsAtIndexPaths:indexPaths];
    }
    ];
//    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
