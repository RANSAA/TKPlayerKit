//
//  PlayerListManager.m
//  AliPlayer
//
//  Created by mac on 2019/10/21.
//  Copyright © 2019 mac. All rights reserved.
//

#import "PlayerListManager.h"

static PlayerListManager *obj = nil;

@implementation PlayerListManager

#pragma mark init
+ (instancetype)shared
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        obj = [PlayerListManager new];
        [obj initListPlayer];
        [obj configNet];
        [obj configCache];
    });
    return obj;
}

- (void)dealloc
{
    _managerDelegate = nil;
    [_listPlayer destroy];
    _listPlayer = nil;
    obj = nil;
}

/**
 配置缓存信息
 **/
- (void)configCache
{

}

- (PlayerDelegate *)managerDelegate
{
    if (!_managerDelegate) {
        _managerDelegate = [[PlayerDelegate alloc] init];
    }
    return _managerDelegate;
}


/**
 初始化列表播放器
 **/
- (void)initListPlayer
{
    _listPlayer = [[AliListPlayer alloc] init];
    _listPlayer.delegate = self.managerDelegate;
    _listPlayer.autoPlay = YES;
    _listPlayer.loop = YES;
    _listPlayer.preloadCount = 2;
//    [_listPlayer setEnableLog:NO];
}

/**
 配置网络重试时间和次数
 **/
- (void)configNet
{
    AVPConfig *config = [_listPlayer getConfig];
    //设置网络超时时间，单位ms
    config.networkTimeout = 5000;
    //设置超时重试次数。每次重试间隔为networkTimeout。networkRetryCount=0则表示不重试，重试策略app决定，默认值为2
    config.networkRetryCount = 5000;
    //设置配置给播放器
    [_listPlayer setConfig:config];
}

#pragma mark setupUI
/**
 设置预览view
 **/
- (void)setPreView:(UIView *)view
{
    _listPlayer.playerView = view;
}

/**
 刷新预览view
 **/
- (void)refreshPreView
{
    [_listPlayer redraw];
}

/**
 当前视频的预览view
 **/
- (UIView *)curPreView
{
    return _listPlayer.playerView;
}

#pragma mark 控制
/**
 开始
 **/
- (void)start
{
    [_listPlayer start];
}

/**
 暂停
 **/
-(void)pause
{
    [_listPlayer pause];
}

/**
 销毁播放器
 **/
-(void)stop
{
    [_listPlayer stop];
}

/**
 重置播放器
 **/
-(void)reset
{
    [_listPlayer reset];
}

//- (BOOL)isPlay
//{
//    return _listPlayer.pl
//}


#pragma mark 创建DataSource，准备播放
#pragma mark URL
/**
 添加一个url到播放列表中
 url:视频路劲
 tagID:用于标识区分视频（而不是通过url）
 **/
- (void)addWithUrl:(NSString *)url tagID:(NSString *)tagID
{
    [_listPlayer addUrlSource:url uid:tagID];
}

/**
 移出某个源
 tagID:标记视频唯一性
 **/
- (void)removeTagID:(NSString *)tagID
{
    [_listPlayer removeSource:tagID];
}

/**
 播放某个视频
 **/
- (void)moveToTagID:(NSString *)tagID
{
    [_listPlayer moveTo:tagID];
}

/**
 移动到下一个视频
 **/
- (void)moveToNext
{
    [_listPlayer moveToNext];
}

/**
 移动到上一个视频
 **/
- (void)moveToPre
{
    [_listPlayer moveToPre];
}

/**
 获取当前播放视频的tagID
 **/
- (NSString *)curTagID
{
    return [_listPlayer currentUid];
}

/**
 清除播放列表
 **/
- (void)clear
{
    [_listPlayer clear];
}

@end
