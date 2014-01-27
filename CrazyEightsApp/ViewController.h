//
//  ViewController.h
//  CrazyEightsApp
//
//  Created by Jeremy on 1/27/14.
//  Copyright (c) 2014 Jeremy-Walton. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HandDelegate.h"

@interface ViewController : UIViewController <HandDelegate>

@property (weak, nonatomic) IBOutlet UILabel *lastEventLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@end
