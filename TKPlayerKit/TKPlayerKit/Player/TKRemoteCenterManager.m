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
        cmdChangePlaybackPosition.enabled = YES;
        [cmdChangePlaybackPosition addTarget:self action:@selector(remoteSlideBarEvent:)];
//        [cmdChangePlaybackPosition addTargetWithHandler:^MPRemoteCommandHandlerStatus(MPRemoteCommandEvent * _Nonnull event) {
//                MPChangePlaybackPositionCommandEvent *positionEvent = (MPChangePlaybackPositionCommandEvent *)event;
//            // 更新音频播放器的当前播放位置
//            NSLog(@"positionTime:%f",positionEvent.positionTime);
//            // 返回处理状态
//            return MPRemoteCommandHandlerStatusSuccess;
//        }];
    } else {
        // Fallback on earlier versions
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
- (MPRemoteCommandHandlerStatus)remotePlayEvent:(MPRemoteCommandEvent *)event
{
    NSLog(@"播放");
    [_player play];
    
    //必须返回一个状态，这儿默认成功，使用是应该按照实际情况
    return MPRemoteCommandHandlerStatusSuccess;
}

/** 暂停  **/
- (MPRemoteCommandHandlerStatus)remotePauseEvent:(MPRemoteCommandEvent *)event
{
    NSLog(@"暂停");
    [_player pause];
    
    //必须返回一个状态，这儿默认成功，使用是应该按照实际情况
    return MPRemoteCommandHandlerStatusSuccess;
}

/** 停止  **/
- (MPRemoteCommandHandlerStatus)remoteStopEvent:(MPRemoteCommandEvent *)event
{
    NSLog(@"stop");
    //必须返回一个状态，这儿默认成功，使用是应该按照实际情况
    return MPRemoteCommandHandlerStatusSuccess;
}

/** 下一个  **/
- (MPRemoteCommandHandlerStatus)remoteNextEvent:(MPRemoteCommandEvent *)event
{
    NSLog(@"下一个");
    //必须返回一个状态，这儿默认成功，使用是应该按照实际情况
    return MPRemoteCommandHandlerStatusSuccess;
}

/**  上一个 **/
- (MPRemoteCommandHandlerStatus)remotePreviousEvent:(MPRemoteCommandEvent *)event
{
    NSLog(@"上一个");
    //必须返回一个状态，这儿默认成功，使用是应该按照实际情况
    return MPRemoteCommandHandlerStatusSuccess;
}

/**  滑动进度条
 PS:目前无法滑动，可能是还有某个Command Action来同步滑块的值才能滑动
 **/
- (MPRemoteCommandHandlerStatus)remoteSlideBarEvent:(MPChangePlaybackPositionCommandEvent *)event
{
    NSLog(@"滑动进度条 event:%f",event.positionTime);
    CMTime time = CMTimeMake(event.positionTime, 1);
    [_player seekToTime:time completionHandler:^(BOOL finished) {
        NSLog(@"fin:%d",finished);
    }];
    
    
//    CMTime newTime = CMTimeMakeWithSeconds(event.positionTime, NSEC_PER_SEC);
//    [self.player seekToTime:newTime];
//    //必须返回一个状态，这儿默认成功，使用是应该按照实际情况
    
//    CMTime time = CMTimeMake(event.positionTime, event.timestamp);
//    time = CMTimeMakeWithSeconds(tmpEvent.positionTime, NSEC_PER_SEC);
//    [_player seekToTime:time completionHandler:^(BOOL finished) {
//        NSLog(@"fin:%d",finished);
//    }];
    
    
//    CMTime totlaTime = self.player.currentItem.duration;
//    time = CMTimeMake(totlaTime.value*event.positionTime/CMTimeGetSeconds(totlaTime), totlaTime.timescale);
//    [_player seekToTime:time];
    
    return MPRemoteCommandHandlerStatusSuccess;
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
