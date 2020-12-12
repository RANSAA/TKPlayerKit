//
//  PlayerManager.m
//  AliPlayer
//
//  Created by mac on 2019/10/21.
//  Copyright © 2019 mac. All rights reserved.
//

#import "PlayerManager.h"

static PlayerManager *obj = nil;


@implementation PlayerManager

#pragma mark 初始化播放器

/**  单利管理播放器  **/
+ (instancetype)shared
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        obj = [PlayerManager new];
        [obj configLocalVideo];
        [obj initPlayer];
        [obj configNet];
    });
    return obj;
}

- (void)dealloc
{
    _managerDelegate = nil;
    [_player destroy];
    _player = nil;
    obj = nil;
}

/**
 配置本地的安全视频文件
 如果播放的视频是安全下载后的本地文件（即经过阿里云加密转码过后的），那么还需要设置一个加密校验信息（建议在Application中配置一次即可）：
 **/
- (void)configLocalVideo
{
//    NSString *encrptyFilePath = [[NSBundle mainBundle] pathForResource:@"encryptedApp" ofType:@"dat"];
//    [AliPrivateService initKey:encrptyFilePath];
}

- (PlayerDelegate *)managerDelegate
{
    if (!_managerDelegate) {
        _managerDelegate = [[PlayerDelegate alloc] init];
    }
    return _managerDelegate;
}

/**
 初始化播放器
 **/
- (void)initPlayer
{
    _player = [[AliPlayer alloc] init];
    _player.delegate = self.managerDelegate;
    _player.loop = YES;
}

/**
 配置网络重试时间和次数
 **/
- (void)configNet
{
    AVPConfig *config = [_player getConfig];
    //设置网络超时时间，单位ms
    config.networkTimeout = 5000;
    //设置超时重试次数。每次重试间隔为networkTimeout。networkRetryCount=0则表示不重试，重试策略app决定，默认值为2
    config.networkRetryCount = 5000;
    //设置配置给播放器
    [_player setConfig:config];
}



#pragma mark setupUI

/**
 设置预览view
 **/
- (void)setPreView:(UIView *)view
{
    _player.playerView = view;
}

/**
 刷新预览view
 **/
- (void)refreshPreView
{
    [_player redraw];
}


#pragma mark 控制
/**
 开始
 **/
- (void)start
{
    [_player start];
}

/**
 暂停
 **/
-(void)pause
{
    [_player pause];
}

/**
 销毁播放器
 **/
-(void)stop
{
    [_player stop];
}

/**
 重置播放器
 **/
-(void)reset
{
    [_player reset];
}




#pragma mark 创建DataSource，准备播放
/**
 播放url
 **/
- (void)playWithUrl:(NSString *)url
{
    AVPUrlSource *src = [[AVPUrlSource alloc] urlWithString:url];
    [_player setUrlSource:src];
    [_player prepare];
    [_player start];
}





@end
