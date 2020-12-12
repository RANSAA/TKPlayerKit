//
//  PlayerListManager.h
//  AliPlayer
//
//  Created by mac on 2019/10/21.
//  Copyright © 2019 mac. All rights reserved.
//

/**
 AliListPlayer 单利二次封装
 一般用于短视频播放
 **/
#import <Foundation/Foundation.h>
#import "PlayerDelegate.h"


NS_ASSUME_NONNULL_BEGIN

@interface PlayerListManager : NSObject
@property(nonatomic, strong) AliListPlayer *listPlayer;//列表播放器
@property(nonatomic, strong) PlayerDelegate *managerDelegate;//代理对象
@property(nonatomic, copy  ) NSString *curTagID;
@property(nonatomic, strong) UIView *curPreView;//当前视频的预览view
@property(nonatomic, assign) BOOL isPlay;

//处理视图移除了当前可视区
//cell 切换时是否标记了暂停
@property(nonatomic, assign) BOOL tmpIsPasue;


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
/**
 当前视频的预览view
 **/
- (UIView *)curPreView;

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



#pragma mark 创建DataSource，准备播放
/**
 添加一个url到播放列表中
 url:视频路劲
 tagID:用于标识区分视频（而不是通过url）
 **/
- (void)addWithUrl:(NSString *)url tagID:(NSString *)tagID;
/**
 移出某个源
 tagID:标记视频唯一性
 **/
- (void)removeTagID:(NSString *)tagID;
/**
 播放某个视频
 **/
- (void)moveToTagID:(NSString *)tagID;
/**
 移动到下一个视频
 **/
- (void)moveToNext;
/**
 移动到上一个视频
 **/
- (void)moveToPre;
/**
 获取当前播放视频的tagID
 **/
- (NSString *)curTagID;
/**
 清除播放列表
 **/
- (void)clear;




@end

NS_ASSUME_NONNULL_END
