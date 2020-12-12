//
//  PlayerManager.h
//  AliPlayer
//
//  Created by mac on 2019/10/21.
//  Copyright © 2019 mac. All rights reserved.
//
/**
 AliPlayer 单利二次封装
 一般用于单个视频播放
 **/
#import <Foundation/Foundation.h>
#import "PlayerDelegate.h"


NS_ASSUME_NONNULL_BEGIN

@interface PlayerManager : NSObject
@property(nonatomic, strong) AliPlayer *player;
@property(nonatomic, strong) PlayerDelegate *managerDelegate;//代理对象

#pragma mark init
/**  单利管理播放器  **/
+ (instancetype)shared;

#pragma mark setupUI
/**
 设置预览view
 **/
- (void)setPreView:(UIView *)view;
/**
 刷新预览view
 **/
- (void)refreshPreView;

#pragma mark 控制
/**
 开始
 **/
- (void)start;
/**
 暂停
 **/
-(void)pause;
/**
 销毁播放器
 **/
-(void)stop;
/**
 重置播放器
 **/
-(void)reset;


#pragma mark 播放资源
/**
 播放url
 **/
- (void)playWithUrl:(NSString *)url;


@end

NS_ASSUME_NONNULL_END
