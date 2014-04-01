//
//  ViewController.m
//  Grave
//
//  Created by MM Lab on 3/11/14.
//  Copyright (c) 2014 MM Lab. All rights reserved.
//

#import "GameViewController.h"
#import "ScoresViewController.h"
#import "AppDelegate.h"

@implementation GameViewController {
    BOOL die;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    walkAnim = [self loadImagesForFilename:@"w" type:@"png" count:16];
    jumpAnim = [self loadImagesForFilename:@"j" type:@"png" count:22];
    fallAnim = [self loadImagesForFilename:@"f" type:@"png" count:9];
    
    //loading audio
    NSString *path = [[NSBundle mainBundle] pathForResource:@"gravehop" ofType:@"aif"];
    NSURL *url = [NSURL fileURLWithPath:path];
    self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    [_player prepareToPlay];

    //repeat forever!
    _player.numberOfLoops = -1;
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0/30.0 target:self
                                           selector:@selector(update)
                                           userInfo:nil
                                           repeats:YES];
    [_player play];
    [self walk];
    
    [AppDelegate appDelegate].score = 0;
}


-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [timer invalidate];
    [_player stop];
}

-(void)update {
    _grave.center = CGPointMake(_grave.center.x - 7, _grave.center.y);
    
    if(_grave.center.x + _grave.frame.size.width/2.0 <= 0) {
        _grave.center = CGPointMake(600, _grave.center.y);
        
        //increment score
        [AppDelegate appDelegate].score++;
    }
    
    if(skeletonMovingUp) {
        _button.center = CGPointMake(_button.center.x, _button.center.y-5);
    }
    else {
        _button.center = CGPointMake(_button.center.x, _button.center.y+5);
        
        if(_button.center.y + _button.frame.size.height/2.0 >= 320) {
            _button.center = CGPointMake(_button.center.x, 320 - _button.frame.size.height/2.0);
        }
    }
    
    [self checkCollision];
}

-(void)checkCollision {
    if(skeletonMovingUp)
        return;
    
    if(CGRectIntersectsRect(_button.frame, _grave.frame)) {
        if(die)
            return;        
        die = true;
        
		// stop playing the theme song
		[_player stop];
		
        [_skeleton setAnimationImages:fallAnim];
        [_skeleton setAnimationDuration:1];
		
        [_skeleton startAnimating];
        [NSTimer scheduledTimerWithTimeInterval:0.9 target:self selector:@selector(nextMenu) userInfo:nil repeats:NO];
        

    }
}

- (void) nextMenu
{
    [self performSegueWithIdentifier:@"endGame" sender:self];
}

-(void)walk {
    [_skeleton stopAnimating];
    
    _skeleton.animationImages = walkAnim;
    _skeleton.animationDuration = 1.5;
    _skeleton.animationRepeatCount = 0;
    [_skeleton startAnimating];
}

-(void)jump {
    [_skeleton stopAnimating];
    
    _skeleton.animationImages = jumpAnim;
    _skeleton.animationDuration = 2.0;
    _skeleton.animationRepeatCount = 1;
    [_skeleton startAnimating];
    
    //_button.center = CGPointMake(_button.center.x, _button.center.y - 120);
    skeletonMovingUp = YES;
    
    [UIView animateWithDuration:_skeleton.animationDuration/2.0 animations:^{
        _skeleton.center = CGPointMake(_skeleton.center.x, _skeleton.center.y - 160);
    } completion:^(BOOL finished) {
        
        skeletonMovingUp = NO;
        [UIView animateWithDuration:_skeleton.animationDuration/2.0 animations:^{
            _skeleton.center = CGPointMake(_skeleton.center.x, _skeleton.center.y + 160);
        } completion:^(BOOL finished) {
            //_button.center = CGPointMake(_button.center.x, _button.center.y + 120);
        }];
    }];
    
    double delayInSeconds = _skeleton.animationDuration;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
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
    [self jump];
}

























@end
