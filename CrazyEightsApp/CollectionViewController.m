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
#import "CoverFlowLayout.h"

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
    self.view.backgroundColor = [UIColor blackColor];
    self.collectionView.backgroundColor = [UIColor colorWithRed:0.1 green:1 blue:0 alpha:0.5];

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
//        UICollectionViewFlowLayout *flowLayout = [UICollectionViewFlowLayout new];
//        [self.collectionView setCollectionViewLayout:flowLayout];
//        flowLayout.minimumInteritemSpacing = 0.0;
//        flowLayout.sectionInset = UIEdgeInsetsMake(52.0, 100.0, 0.0, 0.0);
        CoverFlowLayout *flowLayout = [CoverFlowLayout new];
//         flowLayout.sectionInset = UIEdgeInsetsMake(0.0, 0.0, 0.0, 0.0);
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
//    cardCell *newCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    CardCell *newCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    newCell.imageView.image = [UIImage imageNamed:[labelList objectAtIndex:indexPath.row]];
//    newCell.label.text = [NSString stringWithFormat:@"%@", [labelList objectAtIndex:indexPath.row]];
    newCell.imageView.layer.shadowColor = (__bridge CGColorRef)([UIColor blackColor]);
    newCell.imageView.layer.shadowRadius = 10;
    return newCell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(71, 96);
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
//        CGRect frame = cell.frame;
//        frame.origin.y += 100;
//        cell.frame = frame;
//        cell.transform = CGAffineTransformMakeRotation(180 * 3.14/180);
//        [cell.superview bringSubviewToFront:cell];
//        cell.transform = CGAffineTransformMakeRotation(180 * 3.14/180);
//        cell.transform = CGAffineTransformMakeScale(2, 2);
//        [UIView transitionFromView:cell.contentView
//                            toView:cell.contentView
//                          duration:.5
//                           options:UIViewAnimationOptionTransitionFlipFromRight
//                        completion:nil];
    }
completion:^(BOOL finished)
    {
//        [UIView animateWithDuration:1.0 animations:^{
//            cell.transform = CGAffineTransformMakeScale(1, 1);
//            cell.transform = CGAffineTransformMakeRotation(0);
//        }];
        NSLog(@"animation end");
        NSArray *indexPaths = @[indexPath];
        [labelList removeObjectAtIndex:indexPath.row];
        [collectionView deleteItemsAtIndexPaths:indexPaths];
    }
    ];
//    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
