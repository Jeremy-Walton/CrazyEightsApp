//
//  MultiViewController.h
//  CrazyEightsApp
//
//  Created by Jeremy on 2/4/14.
//  Copyright (c) 2014 Jeremy-Walton. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HandDelegate.h"
#import "CollectionViewLayout.h"

@interface MultiViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate, UIActionSheetDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *OpponentView;

@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) IBOutlet UICollectionViewFlowLayout *flowLayout;
@property (nonatomic, strong) IBOutlet CollectionViewLayout *collectionViewLayout;

@property (weak, nonatomic) id <HandDelegate> handDelegate;
@property (weak, nonatomic) IBOutlet UIImageView *DiscardImage;
@property (weak, nonatomic) IBOutlet UIImageView *deckImage;
@property (weak, nonatomic) IBOutlet UILabel *GameInfoLabel;


@end
