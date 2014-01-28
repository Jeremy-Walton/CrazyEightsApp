//
//  Table.m
//  CrazyEightsApp
//
//  Created by Jeremy on 1/27/14.
//  Copyright (c) 2014 Jeremy-Walton. All rights reserved.
//

#import "TableViewController.h"
#import "JPWGame.h"

@implementation TableViewController {
@private NSMutableArray *labelList;
@private JPWPlayer *player1;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    labelList = [NSMutableArray new];
    JPWGame *game = [JPWGame new];
    player1 = [JPWPlayer newWithName:@"Jeremy"];
    [game addPlayer:player1];
    [game makeDeckForTest];
    [game makeDiscardPileForTest];
    [game shuffleDeck];
    [game dealCards];
    self.nameLabel.text = [NSString stringWithFormat:@"%@'s hand.", [player1 name]];
    
    
    
    NSArray *playerCards = player1.hand.cards;
    for (JPWPlayingCard *card in playerCards) {
        [labelList addObject:[card description]];
    }
    
    
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
   
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[player1 numberOfCards] integerValue];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.handDelegate didSelectCard:[labelList objectAtIndex:indexPath.row]];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *myIdentifier = @"cell";
    
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:myIdentifier];
    
//    cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png", [labelList objectAtIndex:indexPath.row]]];
    cell.imageView.image = [UIImage imageNamed:[labelList objectAtIndex:indexPath.row]];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.textLabel.text = [labelList objectAtIndex:indexPath.row];
    
    return cell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
