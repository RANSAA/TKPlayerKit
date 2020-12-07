//
//  PlayerViewController.m
//  PlayerDemo
//
//  Created by PC on 2020/12/7.
//  Copyright © 2020 PC. All rights reserved.
//

#import "PlayerViewController.h"
#import "PlayerViewController+UI.h"


@interface PlayerViewController ()

@end

@implementation PlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.view.backgroundColor = UIColor.redColor;
    [self setupPreView];
    [self initAliPlayer];
}

- (void)initAliPlayer
{
//    self.player = [[AliPlayer alloc] init:@"DisableAnalytics"];
    self.player = [[AliPlayer alloc] init];
    self.player.autoPlay = YES;
    self.player.loop = YES;
    self.player.playerView = self.preView;
    [self.player setUrlSource:[self sourceItem]];
    [self.player prepare];
    [self.player start];

}

- (AVPUrlSource *)sourceItem
{
    NSString *url = @"https://vd2.bdstatic.com/mda-kjvff32ndsjugqc1/v1-cae/1080p/mda-kjvff32ndsjugqc1.mp4?auth_key=1607334101-0-0-65a20454db5039356afa23e0aa4fe256&bcevod_channel=searchbox_feed&pd=1&pt=3&abtest=7873_4-8010_3-8012_2-8157_2";
    AVPUrlSource *item = [[AVPUrlSource alloc] urlWithString:url];
    return item;;
}


#pragma mark 旋屏控制
- (BOOL)shouldAutorotate//是否支持旋转屏幕
{
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations//支持哪些方向
{
    return UIInterfaceOrientationMaskAll;
}
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation//默认显示的方向
{
    return UIInterfaceOrientationPortrait;
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
