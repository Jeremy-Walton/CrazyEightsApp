//
//  OpponentView.m
//  CrazyEightsApp
//
//  Created by Jeremy on 2/7/14.
//  Copyright (c) 2014 Jeremy-Walton. All rights reserved.
//

#import "OpponentView.h"
#import "CardCell.h"

@implementation OpponentView {
@private NSMutableArray *cardList;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        cardList = [NSMutableArray new];
//        cardList = robot.hand.cards;
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

//-(void)updatePlayerInfo {
//    cardList = robot.hand.cards;
//    self.reloadData;
//}

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
//    newCell.imageView.image = [UIImage imageNamed:[cardList[indexPath.row] description]];
    newCell.imageView.image = [UIImage imageNamed:@"jb"];
    return newCell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(71, 96);
}

@end
