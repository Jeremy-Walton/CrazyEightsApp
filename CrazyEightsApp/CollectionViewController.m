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
        [UIView transitionFromView:cell.contentView
                            toView:cell.contentView
                          duration:.5
                           options:UIViewAnimationOptionTransitionFlipFromRight
                        completion:nil];
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
