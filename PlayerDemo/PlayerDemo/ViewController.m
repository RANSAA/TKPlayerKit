//
//  ViewController.m
//  PlayerDemo
//
//  Created by PC on 2020/12/7.
//  Copyright © 2020 PC. All rights reserved.
//

#import "ViewController.h"
#import "PlayerDefine.h"

@interface ViewController ()
@property(nonatomic, strong) PlayerViewController *playerVC;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.playerVC = [[PlayerViewController alloc] init];
    self.playerVC.modalPresentationStyle = UIModalPresentationFullScreen;
    [self addChildViewController:self.playerVC];
    [self.view addSubview:self.playerVC.view];
    self.playerVC.view.frame = self.view.bounds;

//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        self.playerVC = [[PlayerViewController alloc] init];
//        self.playerVC.modalPresentationStyle = UIModalPresentationFullScreen;
//        self.playerVC.modalInPresentation = YES;
//        [self presentViewController:self.playerVC animated:YES completion:nil];
//    });
}



#pragma mark 旋屏控制
- (BOOL)shouldAutorotate//是否支持旋转屏幕
{
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations//支持哪些方向
{
    return UIInterfaceOrientationMaskAll;
}
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation//默认显示的方向
{
    return UIInterfaceOrientationPortrait;
}

@end
