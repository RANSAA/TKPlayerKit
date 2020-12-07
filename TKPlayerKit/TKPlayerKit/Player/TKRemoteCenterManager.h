//
//  TKRemoteCenterManager.h
//  Demo
//
//  Created by mac on 2019/10/25.
//  Copyright © 2019 mac. All rights reserved.
//
/**
 控制中心管理
 PS:https://www.jianshu.com/p/71ab0e828c0a
 PS: https://www.jianshu.com/p/21396afffe62
 **/
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class AVPlayer;
@interface TKRemoteCenterManager : NSObject
@property(nonatomic, strong, nullable)AVPlayer *player;

/** 单利 **/
+ (instancetype)shared;
/** 设置播放器 **/
- (void)setPlayer:(AVPlayer * _Nullable)player;

/** 开始-可选  **/
- (void)beginReceivingRemoteControlEvents;
/** 结束-可选  **/
- (void)endReceivingRemoteControlEvents;


/**
 设置音乐信息到控制中心
 title: 歌曲名称
 artist:歌手名称
 image: 图片
 duration:总时长
 progress:已经播放的时长
 ps: https://www.jianshu.com/p/21396afffe62
 **/
- (void)setRemoteSongInfo:(nullable NSString *)title artist:(nullable NSString *)artist image:(nullable UIImage *)image duration:(CGFloat)duration progress:(CGFloat)progress;


@end

NS_ASSUME_NONNULL_END
