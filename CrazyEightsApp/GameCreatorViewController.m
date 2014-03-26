//
//  GameCreatorViewController.m
//  CrazyEightsApp
//
//  Created by Jeremy on 3/21/14.
//  Copyright (c) 2014 Jeremy-Walton. All rights reserved.
//

#import "GameCreatorViewController.h"
#import "MultiViewController.h"

@interface GameCreatorViewController ()
@end

@implementation GameCreatorViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"createGameSegue"]){
        MultiViewController *controller = (MultiViewController *)segue.destinationViewController;
        NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
        [f setNumberStyle:NSNumberFormatterDecimalStyle];
        if (self.create == YES) {
            controller.create = YES;
            controller.number_of_players = [f numberFromString:self.numberOfPlayers.text];
            controller.number_of_robots = [f numberFromString:self.numberOfRobots.text];
        }
        if (self.create == NO) {
            controller.create = NO;
            controller.game_id = [f numberFromString:self.gameID.text];
        }
        controller.name = self.name;
    }
//    create game in here instead of multiviewcontroller. simplifies code.
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)CreateGame:(id)sender {
    self.create = YES;
    
}
- (IBAction)JoinGame:(id)sender {
    self.create = NO;
}
@end
