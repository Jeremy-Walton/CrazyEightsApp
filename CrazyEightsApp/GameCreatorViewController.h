//
//  GameCreatorViewController.h
//  CrazyEightsApp
//
//  Created by Jeremy on 3/21/14.
//  Copyright (c) 2014 Jeremy-Walton. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GameCreatorViewController : UIViewController

@property(nonatomic) BOOL create;
@property(nonatomic) NSString* name;
@property (weak, nonatomic) IBOutlet UITextField *numberOfPlayers;
@property (weak, nonatomic) IBOutlet UITextField *numberOfRobots;
- (IBAction)CreateGame:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *gameID;
- (IBAction)JoinGame:(id)sender;
@end
