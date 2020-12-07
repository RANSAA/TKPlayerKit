//
//  TKPlayerTool.h
//  Demo
//
//  Created by mac on 2019/10/25.
//  Copyright © 2019 mac. All rights reserved.
//
/**
 工具类
 **/
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TKPlayerTool : NSObject
@property(nonatomic, strong) AVPlayerItem *playerItem;

/**
 *  视频截图：高清图
 *  在global中执行
 **/
- (void)snapshotImage:(void(^)(UIImage *image))compare;

@end

NS_ASSUME_NONNULL_END
