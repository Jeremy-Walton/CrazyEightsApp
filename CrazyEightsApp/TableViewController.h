//
//  Table.h
//  CrazyEightsApp
//
//  Created by Jeremy on 1/27/14.
//  Copyright (c) 2014 Jeremy-Walton. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HandDelegate.h"

@interface TableViewController : UITableViewController


@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) id <HandDelegate> handDelegate;

@end
