//
//  PlayerViewController.h
//  PlayerDemo
//
//  Created by PC on 2020/12/7.
//  Copyright © 2020 PC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AliyunPlayer/AliyunPlayer.h>



NS_ASSUME_NONNULL_BEGIN

@interface PlayerViewController : UIViewController
@property(nonatomic, strong) AliPlayer *player;
@property(nonatomic, strong) UIView *preView;

@end

NS_ASSUME_NONNULL_END
