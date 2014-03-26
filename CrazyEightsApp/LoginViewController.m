//
//  LoginViewController.m
//  CrazyEightsApp
//
//  Created by Jeremy on 3/21/14.
//  Copyright (c) 2014 Jeremy-Walton. All rights reserved.
//

#import "LoginViewController.h"
#import "GameCreatorViewController.h"
#import "JPWWebClient.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
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

- (IBAction)loginButton:(id)sender {
    NSNumber *success = [[JPWWebClient sharedClient] loginWithEmail:self.usernameField.text andPassword:self.passwordField.text];
    if ([success isEqual:@YES]) {
        GameCreatorViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"gameCreator"];
        controller.name = self.usernameField.text;
        [self.navigationController pushViewController:controller animated:YES];
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Welcome" message:@"You logged in succesfully" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//        [alert show];
        
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Login Failure" message:@"Invalid username or password" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
}

@end
