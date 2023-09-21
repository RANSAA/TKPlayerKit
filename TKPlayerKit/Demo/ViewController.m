//
//  ViewController.m
//  Demo
//
//  Created by mac on 2019/10/24.
//  Copyright © 2019 mac. All rights reserved.
//

#import "ViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import "TKRemoteCenterManager.h"
#import "TKPlayerTool.h"


@interface ViewController ()<AVPlayerItemOutputPullDelegate>
@property (strong, nonatomic) IBOutlet TKPlayerLayerView *preView;
@property (strong, nonatomic) AVPlayer *player;
@property (strong, nonatomic) TKPlayerTool *tool;
@end

@implementation ViewController{

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    AVPlayerItemDidPlayToEndTimeNotification
    [self testAVPlayer];

}


- (void)testAVPlayer
{
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];

    NSURL *url = [NSURL URLWithString:@"https://video.pearvideo.com/mp4/third/20190917/cont-1603130-11956977-103252-hd.mp4"];
    url = [NSBundle.mainBundle URLForResource:@"test.mp4" withExtension:nil];
    url = [NSBundle.mainBundle URLForResource:@"test.mp3" withExtension:nil];
    
    AVPlayerItem *item = [[AVPlayerItem alloc] initWithURL:url];
    _player = [[AVPlayer alloc] initWithPlayerItem:item];
    [self.preView setPlayer:_player];
    [_player play];

    _tool = [TKPlayerTool new];
    _tool.playerItem = item;



    [_player addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    NSLog(@"player:%ld  er:%@",_player.status,_player.error);
    if (_player.status == 1) {//开始播放时可以设置控制中心信息
        CMTime time = _player.currentItem.duration;
        CMTime curTime = _player.currentTime;
        CGFloat total = time.value/(time.timescale?time.timescale:1);
        CGFloat cur   = curTime.value/(curTime.timescale?curTime.timescale:1);
        UIImage *image = [UIImage imageNamed:@"2345"];
        [[TKRemoteCenterManager shared] setPlayer:_player];
        [[TKRemoteCenterManager shared] setRemoteSongInfo:@"向风一样的街道" artist:@"saya" image:image duration:total progress:cur];
    }
}

#pragma mark 视频截图

- (IBAction)tapCaptureAction:(UIButton *)sender {
    [_tool snapshotImage:^(UIImage *image) {
        NSString *path = [NSString stringWithFormat:@"%@%u%u.png",NSTemporaryDirectory(),arc4random()%99998789,arc4random()%986597435];
        [UIImagePNGRepresentation(image) writeToFile:path atomically:YES];
        NSLog(@"path:%@",path);
    }];
}


@end
