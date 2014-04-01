//
//  BatGameViewController.h
//  Grave
//
//  Created by Christopher Aranguren on 3/27/14.
//  Copyright (c) 2014 MM Lab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface BatGameViewController : UIViewController {
    NSMutableArray *walkAnim, *fallAnim, *dodgeAnim, *batAnim;
    NSTimer *timer;
    
    BOOL skeletonDodging;
}

@property (strong, nonatomic) AVAudioPlayer *player;
@property (weak, nonatomic) IBOutlet UIImageView *skeleton;
@property (weak, nonatomic) IBOutlet UIImageView *bat;
@property (strong, nonatomic) IBOutlet UIButton *button;

- (IBAction)buttonHit:(id)sender;

@end
