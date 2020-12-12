//
//  PlayerDelegate.h
//  AliPlayer
//
//  Created by mac on 2019/10/21.
//  Copyright © 2019 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PlayerDelegate : NSObject <AVPDelegate>
@property(nonatomic, strong) AliListPlayer *listPlayer;
@property(nonatomic, strong) AliPlayer *player;

@end

NS_ASSUME_NONNULL_END
