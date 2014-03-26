//
//  OpponentView.h
//  CrazyEightsApp
//
//  Created by Jeremy on 2/7/14.
//  Copyright (c) 2014 Jeremy-Walton. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OpponentViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate>

-(void)setCardAmount:(NSInteger)amount;

@end
