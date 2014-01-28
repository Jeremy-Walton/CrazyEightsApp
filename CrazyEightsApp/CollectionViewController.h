//
//  CollectionViewController.h
//  CrazyEightsApp
//
//  Created by Jeremy on 1/28/14.
//  Copyright (c) 2014 Jeremy-Walton. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HandDelegate.h"

@interface CollectionViewController : UICollectionViewController

@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) id <HandDelegate> handDelegate;
@end
