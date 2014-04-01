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

}

- (void)viewDidAppear:(BOOL)animated {
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    GameViewController *gameViewController = segue.destinationViewController;
    gameViewController.menuViewController = self;
}

// this method checks the contents of the the nameTextField, filters out spaces, and if blank, displays an alert

-(BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    NSString *noWhiteSpace = [_nameTextField.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    if(noWhiteSpace.length==0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Please Enter Your Name" message:@"" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    
    return noWhiteSpace.length>0; 
}

//this method dismisses the keyboard

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [_nameTextField resignFirstResponder];
    return NO;
}

@end
