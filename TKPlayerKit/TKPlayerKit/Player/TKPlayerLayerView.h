//
//  TKPlayerLayerView.h
//  Demo
//
//  Created by mac on 2019/10/24.
//  Copyright © 2019 mac. All rights reserved.
//
/**
 视频渲染view
 背景颜色默认是没有的
 **/
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/** 视频填充模式  **/
typedef NS_ENUM(NSInteger, TKPlayerLayerViewGravity) {
    TKPlayerLayerViewGravityResizeAspect = 0,        //对应：AVLayerVideoGravityResizeAspect
    TKPlayerLayerViewGravityResizeAspectFill,        //对应：AVLayerVideoGravityResizeAspectFill
    TKPlayerLayerViewGravityResize                   //对应：AVLayerVideoGravityResize
};


@class AVPlayer;
@interface TKPlayerLayerView : UIView
@property (nonatomic, strong) AVPlayer* player;

/** 绑定播放器 **/
- (void)setPlayer:(AVPlayer*)player;

/**
 将播放器从TKPlayerLayerView上移出(即取消播放器与渲染层的绑定)
 使用场景：后台播放视频
 使用方式：
        进入后台时AVPlayerLayer.player = nil;
        切换到前台时恢复AVPlayerLayer.player
 原因： AVPlayer只播放音频时可以支持后台播放，播放是平时进入后台时会自动暂停
 PS: 一般用不上，视频一般是不需要后台播放的
 **/
- (void)removePlayer;

/** 设置视频渲染模式  ***/
- (void)setVideoFillMode:(TKPlayerLayerViewGravity)fillMode;

@end

NS_ASSUME_NONNULL_END
