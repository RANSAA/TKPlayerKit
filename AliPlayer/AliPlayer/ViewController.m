//
//  ViewController.m
//  AliPlayer
//
//  Created by mac on 2019/10/21.
//  Copyright © 2019 mac. All rights reserved.
//

#import "ViewController.h"
#import "PlayerManager.h"

#define mm_weakify(object) autoreleasepool   {} __weak  typeof(object) weak##object = object;


@interface ViewController ()
@property(nonatomic) NSInteger width;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self testPlayer];
}

- (void)testPlayer
{
    NSString *url = @"http://aweme.snssdk.com/aweme/v1/playwm/?s_vid=93f1b41336a8b7a442dbf1c29c6bbc56231f20511b3095714a0eb1d53a66af1131fd93c3274607b95d0e4bdb20fea880019ccc49bbbf0b2b83cab3ad93724afb&line=0";
    PlayerManager *manager = [PlayerManager shared];
    [manager setPreView:self.view];
    [manager playWithUrl:url];

//    @mm_weakify(self)
//    [self testPlayer];
    ViewController *obj = self;
    obj.mm_width(44);
}

-(ViewController * (^)(CGFloat))mm_width {
    @mm_weakify(self);
    return ^(CGFloat m_width){
        @mm_weakify(self);
        self.width = m_width;
        return self;
    };
}

-(ViewController * (^)(CGFloat))mm_height {
    @mm_weakify(self);
    return ^(CGFloat mm_height){
        @mm_weakify(self);
        self.width = mm_height;
        return self;
    };
}

@end
