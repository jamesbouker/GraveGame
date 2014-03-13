//
//  FlipViewController.m
//  Grave
//
//  Created by MM Lab on 3/11/14.
//  Copyright (c) 2014 MM Lab. All rights reserved.
//

#import "MenuViewController.h"
#import "GameViewController.h"

@implementation MenuViewController

-(void)viewDidLoad {
    _scoreLabel.text = @"Score: ";
}

- (void)viewDidAppear:(BOOL)animated {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    GameViewController *gameViewController = segue.destinationViewController;
    gameViewController.menuViewController = self;
}

@end
