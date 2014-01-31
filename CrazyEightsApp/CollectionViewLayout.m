//
//  CollectionViewLayout.m
//  CrazyEightsApp
//
//  Created by Jeremy on 1/30/14.
//  Copyright (c) 2014 Jeremy-Walton. All rights reserved.
//

#import "CollectionViewLayout.h"

@interface CollectionViewLayout ()


@end

@implementation CollectionViewLayout

-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *layout = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    NSInteger middle = [self.collectionView numberOfItemsInSection:0]/2;
    layout.size = CGSizeMake(71, 96);
    if (indexPath.item < middle) {
        layout.center = CGPointMake((indexPath.item * 20.0) + 100, (0.01 * pow(indexPath.item - middle, 2) * 20.0) + 100);
        layout.transform = CGAffineTransformMakeRotation(atan(0.02 * (indexPath.item - middle)));
    } else if (indexPath.item == middle) {
        layout.center = CGPointMake((indexPath.item * 20.0) + 100, (0.01 * pow(indexPath.item - middle, 2) * 20.0) + 100);
    } else {
        
        layout.center = CGPointMake((indexPath.item * 20.0) + 100, (0.01 * pow(indexPath.item - middle, 2) * 20.0) + 100);
        layout.transform = CGAffineTransformMakeRotation(atan(0.02 * (indexPath.item - middle)));
    }
    return layout;
}

-(CGSize)collectionViewContentSize {
    return self.collectionView.frame.size;
}

-(NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSInteger numberOfItems = [self.collectionView numberOfItemsInSection:0];
    NSMutableArray *attributes = [[NSMutableArray alloc] initWithCapacity:numberOfItems];
    for (int i = 0; i < numberOfItems; i++) {
        attributes[i] = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]];
    }
    return attributes;
}


@end
