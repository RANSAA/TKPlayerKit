//
//  TKPlayer.h
//  Demo
//
//  Created by mac on 2019/10/24.
//  Copyright © 2019 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import "TKPlayerLayerView.h"


NS_ASSUME_NONNULL_BEGIN

@interface TKPlayer : NSObject
@property(nonatomic, strong) AVPlayer *player;
@property(nonatomic, strong) TKPlayerLayerView *playerView;
@end

NS_ASSUME_NONNULL_END
