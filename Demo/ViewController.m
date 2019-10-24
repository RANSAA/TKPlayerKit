//
//  ViewController.m
//  Demo
//
//  Created by mac on 2019/10/24.
//  Copyright © 2019 mac. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (strong, nonatomic) IBOutlet TKPlayerLayerView *preView;
@property (strong, nonatomic) AVPlayer *player;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    AVPlayerItemDidPlayToEndTimeNotification
    [self testAVPlayer];
}


- (void)testAVPlayer
{
    AVAudioSession *session = [AVAudioSession sharedInstance];
    [session setCategory:AVAudioSessionCategoryPlayback
             withOptions:AVAudioSessionCategoryOptionDuckOthers
                   error:nil];

//    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];

    NSURL *url = [NSURL URLWithString:@"https://video.pearvideo.com/mp4/third/20190917/cont-1603130-11956977-103252-hd.mp4"];
    AVPlayerItem *item = [[AVPlayerItem alloc] initWithURL:url];

//    AVPlayer *player = [[AVPlayer alloc] initWithPlayerItem:item];
//    AVPlayer *player = [[AVPlayer alloc] initWithURL:url];
//    [self.preView setPlayer:player];
//    [player play];

//    _player = [[AVPlayer alloc] initWithURL:url];
    _player = [[AVPlayer alloc] initWithPlayerItem:item];
    [self.preView setPlayer:_player];
    [_player play];

//    [self addObserver:_player forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];

}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    NSLog(@"player:%ld  er:%@",_player.status,_player.error);
}

@end
