//
//  TKRemoteCenterManager.m
//  Demo
//
//  Created by mac on 2019/10/25.
//  Copyright © 2019 mac. All rights reserved.
//

#import "TKRemoteCenterManager.h"
#import <MediaPlayer/MediaPlayer.h>

@implementation TKRemoteCenterManager

+ (instancetype)shared
{
    static TKRemoteCenterManager *obj = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        obj = [TKRemoteCenterManager new];
        [obj instanceRemoteCenter];
    });
    return obj;
}

- (void)setPlayer:(AVPlayer *)player
{
    _player = player;
}

#pragma mark 添加远程控制
/** 创建控制信息  **/
- (void)instanceRemoteCenter
{
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
    [[AVAudioSession sharedInstance] setActive:YES error:nil];

    MPRemoteCommandCenter *center = [MPRemoteCommandCenter sharedCommandCenter];
    MPRemoteCommand *cmdPlay = [center playCommand];
    cmdPlay.enabled = YES;
    [cmdPlay addTarget:self action:@selector(remotePlayEvent:)];
    MPRemoteCommand *cmdPasue = [center pauseCommand];
    cmdPasue.enabled = YES;
    [cmdPasue addTarget:self action:@selector(remotePauseEvent:)];
    MPRemoteCommand *cmdStop = [center stopCommand];
    cmdStop.enabled = YES;
    [cmdStop addTarget:self action:@selector(remoteStopEvent:)];
    MPRemoteCommand *cmdNext = [center nextTrackCommand];
    cmdNext.enabled = YES;
    [cmdNext addTarget:self action:@selector(remoteNextEvent:)];
    MPRemoteCommand *cmdPrevious = [center previousTrackCommand];
    cmdPrevious.enabled = YES;
    [cmdPrevious addTarget:self action:@selector(remotePreviousEvent:)];
    if (@available(iOS 9.1, *)) {
        MPRemoteCommand *cmdChangePlaybackPosition = [center changePlaybackPositionCommand];
        [cmdChangePlaybackPosition setEnabled:YES];
        [cmdChangePlaybackPosition addTarget:self action:@selector(remoteSlideBarEvent:)];
    }

}

/** 开始-可选  **/
- (void)beginReceivingRemoteControlEvents
{
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];

}

/** 结束-可选  **/
- (void)endReceivingRemoteControlEvents
{
    [[UIApplication sharedApplication] endReceivingRemoteControlEvents];
}

#pragma mark 控制中心事件响应
/**  播放 **/
- (void)remotePlayEvent:(MPRemoteCommandEvent *)event
{
    NSLog(@"播放");
    [_player play];
}

/** 暂停  **/
- (void)remotePauseEvent:(MPRemoteCommandEvent *)event
{
    NSLog(@"暂停");
    [_player pause];
}

/** 停止  **/
- (void)remoteStopEvent:(MPRemoteCommandEvent *)event
{
    NSLog(@"stop");
}

/** 下一个  **/
- (void)remoteNextEvent:(MPRemoteCommandEvent *)event
{
    NSLog(@"下一个");
}

/**  上一个 **/
- (void)remotePreviousEvent:(MPRemoteCommandEvent *)event
{
    NSLog(@"上一个");
}

/**  滑动进度条 **/
- (void)remoteSlideBarEvent:(MPChangePlaybackPositionCommandEvent *)event
{
    NSLog(@"滑动进度条");
    CMTime time = CMTimeMake(event.positionTime, 1);
    [_player seekToTime:time completionHandler:^(BOOL finished) {
        NSLog(@"fin:%d",finished);
    }];
}

#pragma mark  控制中心展示的信息
/**
 设置音乐信息到控制中心
 title: 歌曲名称
 artist:歌手名称
 image: 图片
 duration:总时长
 progress:已经播放的时长
 ps: https://www.jianshu.com/p/21396afffe62
 **/
- (void)setRemoteSongInfo:(nullable NSString *)title artist:(nullable NSString *)artist image:(nullable UIImage *)image duration:(CGFloat)duration progress:(CGFloat)progress
{
    //注意： 如果你没配置歌曲信息，点击暂停，锁屏状态下的控制中心界面消失
    NSMutableDictionary *infoDic = [NSMutableDictionary dictionary];
    if (title) {//设置歌曲题目
        [infoDic setObject:title forKey:MPMediaItemPropertyTitle];
    }
    if (artist) {//设置歌手名
        [infoDic setObject:artist forKey:MPMediaItemPropertyArtist];
    }
    if (image) {//设置显示的图片
        MPMediaItemArtwork *artwork = [[MPMediaItemArtwork alloc] initWithImage:image];
        [infoDic setObject:artwork forKey:MPMediaItemPropertyArtwork];
    }
    //设置播放总时长
    [infoDic setObject:@(duration) forKey:MPMediaItemPropertyPlaybackDuration];
    //设置当前播放的进度时间
    [infoDic setObject:@(progress) forKey:MPNowPlayingInfoPropertyElapsedPlaybackTime];

    /**
     这些设置都是按照默认播放进行的，比如修改了播放速率时，就需要设置其它的属性（可以进入：MPMediaItemPropertyPlaybackDuration 查看）
     **/

    //设置信息到控制中心
    [[MPNowPlayingInfoCenter defaultCenter] setNowPlayingInfo:infoDic];
}

@end
