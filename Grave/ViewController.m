//
//  ViewController.m
//  Grave
//
//  Created by MM Lab on 3/11/14.
//  Copyright (c) 2014 MM Lab. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (strong, nonatomic) NSMutableArray *anim;
@end

@implementation ViewController {
    //instance variables
    int x,y;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    walkAnim = [self loadImagesForFilename:@"w" type:@"png" count:16];
    jumpAnim = [self loadImagesForFilename:@"j" type:@"png" count:22];
    fallAnim = [self loadImagesForFilename:@"f" type:@"png" count:9];
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0/30.0 target:self selector:@selector(update) userInfo:nil repeats:YES];
    
    [self walk];
}

-(void)update {
    _grave.center = CGPointMake(_grave.center.x - 4, _grave.center.y);
    
    if(_grave.center.x + _grave.frame.size.width/2.0 <= 0) {
        _grave.center = CGPointMake(600, _grave.center.y);
    }
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
    
    
}

-(void)fall {
    [_skeleton stopAnimating];
    
    _skeleton.animationImages = fallAnim;
    _skeleton.animationDuration = 2.0;
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
