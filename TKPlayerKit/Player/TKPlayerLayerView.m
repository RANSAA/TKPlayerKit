//
//  TKPlayerLayerView.m
//  Demo
//
//  Created by mac on 2019/10/24.
//  Copyright © 2019 mac. All rights reserved.
//

#import "TKPlayerLayerView.h"
#import <AVFoundation/AVFoundation.h>

@interface TKPlayerLayerView ()
@property(nonatomic, strong, readonly) AVPlayerLayer *playerLayer;
@end

@implementation TKPlayerLayerView{
    TKPlayerLayerViewGravity _videoFillMode;
}

- (id)init
{
    if (self = [super init]) {
        _videoFillMode = TKPlayerLayerViewGravityResizeAspect;
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        _videoFillMode = TKPlayerLayerViewGravityResizeAspect;
    }
    return self;
}

+ (Class)layerClass
{
    return [AVPlayerLayer class];
}

- (AVPlayerLayer *)playerLayer
{
    return (AVPlayerLayer *)[self layer];
}

- (AVPlayer *)player
{
    return self.playerLayer.player;
}

/** 绑定播放器 **/
- (void)setPlayer:(AVPlayer *)player
{
    [self.playerLayer setPlayer:player];
    [self setVideoFillMode:_videoFillMode];
}

/** 解除与AVPlayer播放器的绑定关系 **/
- (void)removePlayer
{
    self.playerLayer.player = nil;
}

/** 设置视频渲染模式  ***/
- (void)setVideoFillMode:(TKPlayerLayerViewGravity)fillMode
{
    _videoFillMode = fillMode;
    self.playerLayer.videoGravity = [self gravityMode:_videoFillMode];
}

- (AVLayerVideoGravity)gravityMode:(TKPlayerLayerViewGravity)fillMode
{
    switch (fillMode) {
        case TKPlayerLayerViewGravityResizeAspectFill:
            return AVLayerVideoGravityResizeAspectFill;//填充
        case TKPlayerLayerViewGravityResize:
            return AVLayerVideoGravityResize;//拉伸
        default:
            return AVLayerVideoGravityResizeAspect;//裁剪 默认
    }
}

@end
