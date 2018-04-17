//
//  ViewController.m
//  AudioVideo
//
//  Created by 陈博 on 2018/3/12.
//  Copyright © 2018年 陈博. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>

@interface ViewController ()
@property (nonatomic, strong) AVPlayer * player;
@property (nonatomic, strong) AVPlayerLayer * playerLayer;
@property (nonatomic, strong) AVPlayerItem * playerItem;

@end

@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.player = [[AVPlayer alloc] init];
    self.playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
    [self.view.layer addSublayer:self.playerLayer];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
