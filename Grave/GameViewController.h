//
//  ViewController.h
//  Grave
//
//  Created by MM Lab on 3/11/14.
//  Copyright (c) 2014 MM Lab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVAudioPlayer.h>
#import "MenuViewController.h"

@interface GameViewController : UIViewController {
    NSMutableArray *walkAnim, *fallAnim, *jumpAnim;
    
    NSTimer *timer;
    BOOL skeletonMovingUp;
}

@property (weak, nonatomic) MenuViewController *menuViewController;

@property (strong, nonatomic) AVAudioPlayer *player;

@property (strong, nonatomic) IBOutlet UIImageView *skeleton;
@property (strong, nonatomic) IBOutlet UIImageView *grave;
@property (strong, nonatomic) IBOutlet UIButton *button;

- (IBAction)buttonHit:(id)sender;

@end
