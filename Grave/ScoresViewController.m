//
//  ScoresViewController.m
//  Grave
//
//  Created by Jimmy on 3/24/14.
//  Copyright (c) 2014 MM Lab. All rights reserved.
//

#import "ScoresViewController.h"

@implementation ScoresViewController {
    NSArray *sortedScores; //added to sort scores for the table view
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadAndSortScores]; // calls the sorting method when the table view loads
    
    // add a close button to the table view bar
    self.title = @"Leaderboard";
    UIBarButtonItem *close = [[UIBarButtonItem alloc] initWithTitle:@"Close" style:UIBarButtonItemStyleBordered target:self action:@selector(closeButtonHit:)];
    self.navigationItem.leftBarButtonItem = close;
}


// the method called when the close button is selected

-(void)closeButtonHit:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

//method to load in the score values and sort them

-(void)loadAndSortScores {
    sortedScores = [[NSUserDefaults standardUserDefaults] objectForKey:@"scores"];
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"score" ascending:NO];
    sortedScores = [sortedScores sortedArrayUsingDescriptors:@[sortDescriptor]];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return sortedScores.count;
}

// sets the content and appearance of the table view cells

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellId" forIndexPath:indexPath];
    NSDictionary *data = sortedScores[indexPath.row];
    NSString *text = [NSString stringWithFormat:@"%@ scored %@ points", data[@"name"], data[@"score"]];
    cell.textLabel.text = text;
    
    return cell;
}

@end
