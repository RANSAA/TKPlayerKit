//
//  PlayerDelegate.m
//  AliPlayer
//
//  Created by mac on 2019/10/21.
//  Copyright © 2019 mac. All rights reserved.
//

#import "PlayerDelegate.h"

@implementation PlayerDelegate

#pragma mark AVPDelegate

/**
 播放事件回调
 **/
- (void)onPlayerEvent:(AliPlayer *)player eventType:(AVPEventType)eventType
{
    switch (eventType) {
        case AVPEventPrepareDone: {
            // 准备完成
            NSLog(@"播放事件回调: 准备完成");
        }
            break;
        case AVPEventAutoPlayStart:{
            // 自动播放开始事件
            NSLog(@"播放事件回调: 自动播放开始事件");
        }
            break;
        case AVPEventLoopingStart:{
            // 循环播放开始
            NSLog(@"播放事件回调: 循环播放开始");
        }
            break;

        case AVPEventFirstRenderedStart:{
            // 首帧显示
            NSLog(@"播放事件回调: 视频首帧显示");

        }
            break;
        case AVPEventCompletion:{
            // 播放完成
            NSLog(@"播放事件回调: 播放完成");
        }
            break;
        case AVPEventLoadingStart:{
            // 缓冲开始
            NSLog(@"播放事件回调: 缓冲开始");
        }
            break;
        case AVPEventLoadingEnd:{
            // 缓冲完成
            NSLog(@"播放事件回调: 缓冲完成");
        }
            break;
        case AVPEventSeekEnd:{
            // 跳转完成
            NSLog(@"播放事件回调: 跳转完成");
        }
            break;
        default:
            break;
    }
}

/**
 播放状态改变回调
 **/
- (void)onPlayerStatusChanged:(AliPlayer *)player oldStatus:(AVPStatus)oldStatus newStatus:(AVPStatus)newStatus
{
//    if (newStatus == AVPStatusIdle) {
//        player.playerView.alpha = 0;
//    }else if(newStatus == AVPStatusStarted){
//        player.playerView.alpha = 1.0;
//    }
//    NSLog(@"oldStatus:%d    newStatus:%d",oldStatus,newStatus);

    //播放新的视频源，并且处于正在开始播放中时-->可以发送一个通知处理封面的位置
}

/**
 视频当前播放位置回调
 :更新进度条
 **/
- (void)onCurrentPositionUpdate:(AliPlayer *)player position:(int64_t)position
{
    // 更新进度条

}

/**
 视频缓存位置回调
 :更新缓冲进度
 **/
- (void)onBufferedPositionUpdate:(AliPlayer *)player position:(int64_t)position
{
    // 更新缓冲进度

}

/**
 切换码率结果通知
 **/
- (void)onTrackChanged:(AliPlayer *)player info:(AVPTrackInfo *)info
{

}


/**
 错误代理回调
 **/
- (void)onError:(AliPlayer *)player errorModel:(AVPErrorModel *)errorModel
{
    NSLog(@"error AVPErrorModel:%@",errorModel.message);
}


@end
