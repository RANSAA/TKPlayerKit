//
//  TKPlayerTool.m
//  Demo
//
//  Created by mac on 2019/10/25.
//  Copyright © 2019 mac. All rights reserved.
//

#import "TKPlayerTool.h"

@interface TKPlayerTool ()
@property(nonatomic, strong) AVPlayerItemVideoOutput *snapshotOutput;
@end

@implementation TKPlayerTool

#pragma mark 视频截图
/** 设置当前的playerItem **/
-(void)setPlayerItem:(AVPlayerItem *)playerItem
{
    if (_playerItem && _snapshotOutput) {
        [_playerItem removeOutput:_snapshotOutput];
    }
    _playerItem = playerItem;
    self.snapshotOutput = [[AVPlayerItemVideoOutput alloc] initWithPixelBufferAttributes:NULL];
    [_playerItem addOutput:self.snapshotOutput];
}

/**
 获取视频当前帧buffer
 **/
- (nullable CVPixelBufferRef)currentPixelBuffer
{
    CMTime time = [self.snapshotOutput itemTimeForHostTime:CACurrentMediaTime()];
    CVPixelBufferRef buffer = nil;
//    if ([snapshotOutput hasNewPixelBufferForItemTime:time]) {
        buffer = [self.snapshotOutput copyPixelBufferForItemTime:time itemTimeForDisplay:nil];
//    }
    return buffer;
}

/**
 *  视频截图：高清图
 *  在global中执行
 **/
- (void)snapshotImage:(void(^)(UIImage *image))compare
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        UIImage *image = nil;
        CVPixelBufferRef buffer = [self currentPixelBuffer];
        if (buffer) {
            CIImage *ciImage = [CIImage imageWithCVPixelBuffer:buffer];
            CIContext *context = [CIContext contextWithOptions:NULL];
            CGRect rect = CGRectMake(0,
                                     0,
                                     CVPixelBufferGetWidth(buffer),
                                     CVPixelBufferGetHeight(buffer)
                                     );
            CGImageRef cgImage = [context createCGImage:ciImage fromRect:rect];
            image = [UIImage imageWithCGImage:cgImage];
            CGImageRelease(cgImage);
            CVPixelBufferRelease(buffer);
        }
        compare(image);
    });
}

- (void)dealloc
{
    NSLog(@"dealloc TKPlayerTool");
}

@end
