//
//  ViewController.h
//  Grave
//
//  Created by MM Lab on 3/11/14.
//  Copyright (c) 2014 MM Lab. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController {
    NSMutableArray *walkAnim, *fallAnim, *jumpAnim;
    
    NSTimer *timer;
}

@property (strong, nonatomic) IBOutlet UIImageView *skeleton;
@property (strong, nonatomic) IBOutlet UIImageView *grave;
@property (strong, nonatomic) IBOutlet UIButton *button;

- (IBAction)buttonHit:(id)sender;

@end
