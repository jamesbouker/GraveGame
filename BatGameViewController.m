//
//  BatGameViewController.m
//  Grave
//
//  Created by Christopher Aranguren on 3/27/14.
//  Copyright (c) 2014 MM Lab. All rights reserved.
//

#import "BatGameViewController.h"
#import "MenuViewController.h"
#import "ScoresViewController.h"
#import "AppDelegate.h"

@interface BatGameViewController ()

@end

@implementation BatGameViewController {
    BOOL die;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    
    
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0/30.0 target:self selector:@selector(update) userInfo:nil repeats:YES];
    [_player play];
    [self walk];
}

-(void)walk {
    [_skeleton stopAnimating];
    
    _skeleton.animationImages = walkAnim;
    _skeleton.animationDuration = 1.5;
    _skeleton.animationRepeatCount = 0;
    [_skeleton startAnimating];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    walkAnim = [self loadImagesForFilename:@"w" type:@"png" count:16];
    dodgeAnim = [self loadImagesForFilename:@"dodge" type:@"png" count:12];
    fallAnim = [self loadImagesForFilename:@"f" type:@"png" count:9];
    batAnim = [self loadImagesForFilename:@"b" type:@"png" count:9];
    
    _bat.animationImages = batAnim;
    _bat.animationDuration = 1.0;
    [_bat startAnimating];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"gravehop" ofType:@"aif"];
    NSURL *url = [NSURL fileURLWithPath:path];
    self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    [_player prepareToPlay];
    
    _player.numberOfLoops = -1;
}


-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [timer invalidate];
    [_player stop];
}

-(void)update {
    _bat.center = CGPointMake(_bat.center.x - 7, _bat.center.y);
    
    if(_bat.center.x + _bat.frame.size.width/2.0 <= 0) {
        _bat.center = CGPointMake(600, _bat.center.y);
        
        //increment score
        [AppDelegate appDelegate].score++;
    }
    
    [self checkCollision];
}

-(void)checkCollision {
    if(skeletonDodging)
        return;
    
    if(CGRectIntersectsRect(_button.frame, _bat.frame)) {
        if(die)
         return;
        
        die = true;
        [self fall];
        [NSTimer scheduledTimerWithTimeInterval:0.9
                                         target:self
                                       selector:@selector(scorecard)
                                       userInfo:nil repeats:NO];
    }
}

-(void)scorecard {
    
    [self addScore];
    MenuViewController *menuViewController = [AppDelegate menuViewController];
    [menuViewController dismissViewControllerAnimated:YES completion:^{

        ScoresViewController *scoresViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ScoresViewController"];
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:scoresViewController];
        [menuViewController presentViewController:navController animated:YES completion:nil];
    }];
}

//this method fetches the user name and associates it with the score

-(void)addScore {
    NSMutableArray *scores = [[NSMutableArray alloc]
                              initWithArray:[[NSUserDefaults standardUserDefaults]
                                             objectForKey:@"scores"]];
    
    [scores addObject:@{@"name" : [AppDelegate menuViewController].nameTextField.text,
                        @"score" : @([AppDelegate appDelegate].score)}];
    [[NSUserDefaults standardUserDefaults] setObject:scores forKey:@"scores"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(void)drop {
    
    if(skeletonDodging)
        return;
    
    [_skeleton stopAnimating];
    
    _skeleton.animationImages = dodgeAnim;
    _skeleton.animationDuration = 2.0;
    _skeleton.animationRepeatCount = 1;
    [_skeleton startAnimating];
    
    skeletonDodging = YES;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(_skeleton.animationDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        skeletonDodging = NO;
        [self walk];
    });
}


-(void)fall {
    [_skeleton stopAnimating];
    
    _skeleton.animationImages = fallAnim;
    _skeleton.animationDuration = 1.0;
    _skeleton.animationRepeatCount = 1;
    [_skeleton startAnimating];
}

-(NSMutableArray*)loadImagesForFilename:(NSString *)filename type:(NSString*)extension count:(int)count {
    NSMutableArray *images = [NSMutableArray array];
    for(int i=1; i<= count; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%@%d.%@", filename, i, extension]];
        if(image != nil)
            [images addObject:image];
    }
    return images;
}

- (IBAction)buttonHit:(id)sender {
    [self drop];
}

@end
