//
//  ViewController.m
//  CrazyEightsApp
//
//  Created by Jeremy on 1/27/14.
//  Copyright (c) 2014 Jeremy-Walton. All rights reserved.
//

#import "ViewController.h"
#import "TableViewController.h"
#import "JPWGame.h"
#import "CollectionViewController.h"
#import "JPWGame.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)didSelectCard:(JPWPlayingCard *)card {
    self.imageView.image = [UIImage imageNamed:[card description]];
    NSString *lastEventLabel;
    lastEventLabel = [NSString stringWithFormat:@"%@", [card description]];
    self.lastEventLabel.text = lastEventLabel;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue
                 sender:(id)sender {
//    TableViewController *handController = segue.destinationViewController;
//    handController.handDelegate = self;
    
//    CollectionViewController *handController = segue.destinationViewController;
//    handController.handDelegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
