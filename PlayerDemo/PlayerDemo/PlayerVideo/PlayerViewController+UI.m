//
//  PlayerViewController+UI.m
//  PlayerDemo
//
//  Created by PC on 2020/12/7.
//  Copyright © 2020 PC. All rights reserved.
//

#import "PlayerViewController+UI.h"

#define ScreenWidth  [UIScreen mainScreen].bounds.size.width
#define ScreenHeight  [UIScreen mainScreen].bounds.size.height

@implementation PlayerViewController (UI)

- (void)setupPreView
{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = UIColor.grayColor;
    [self.view addSubview:view];
    self.preView = view;
    [self setNeedPreViewFrame];

}

- (void)setNeedPreViewFrame
{
    CGFloat width = 0;
    CGFloat height = 0;
    CGFloat topHeight = 0;
    UIInterfaceOrientation orientation = UIInterfaceOrientationUnknown;
    if (@available(iOS 13.0, *)) {
        orientation = UIApplication.sharedApplication.windows.firstObject.windowScene.interfaceOrientation;
    } else {
        orientation = UIApplication.sharedApplication.statusBarOrientation;
    }

    if (orientation == UIInterfaceOrientationPortrait ) {
        width = ScreenWidth;
        height = ScreenWidth * 9 / 16.0;
        topHeight = 64;
    }else{
        width = ScreenWidth;
        height = ScreenHeight;
        topHeight = 0;
    }
    self.preView.frame = CGRectMake(0, topHeight, width, height);
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    [self setNeedPreViewFrame];
}

@end
