//
//  FlipViewController.h
//  Grave
//
//  Created by MM Lab on 3/11/14.
//  Copyright (c) 2014 MM Lab. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuViewController : UIViewController <UITextFieldDelegate> //MenuViewController conforms to UITextField delegate
                                                                       //allows return key to dismiss keyboard

@property (strong, nonatomic) IBOutlet UITextField *nameTextField;

@end
