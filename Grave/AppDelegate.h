//
//  AppDelegate.h
//  Grave
//
//  Created by MM Lab on 3/11/14.
//  Copyright (c) 2014 MM Lab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property int score;

@property (strong, nonatomic) UIWindow *window;

+(AppDelegate*)appDelegate;
+(MenuViewController*)menuViewController;

@end
