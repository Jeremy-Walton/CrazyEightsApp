//
//  CollectionViewLayout.h
//  CrazyEightsApp
//
//  Created by Jeremy on 1/30/14.
//  Copyright (c) 2014 Jeremy-Walton. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectionViewLayout : UICollectionViewLayout

@property (nonatomic) UIEdgeInsets itemInsets;
@property (nonatomic) CGSize itemSize;
@property (nonatomic) CGFloat interItemSpacingY;
@property (nonatomic) NSInteger numberOfColumns;
@property (nonatomic) CGPoint stackCenter;
@property (nonatomic) CGFloat stackFactor;

@end
