//
//  TestList.m
//  AliPlayer
//
//  Created by mac on 2019/10/21.
//  Copyright © 2019 mac. All rights reserved.
//

#import "TestList.h"
#import "PlayerListManager.h"

@interface TestList ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *mTableView;
@property (strong, nonatomic) NSMutableArray *urls;
@property (strong, nonatomic) NSMutableArray *tags;
@property (strong, nonatomic) NSMutableArray *imgs;
@property (assign, nonatomic) CGFloat rowHeight;
@property (strong, nonatomic) UIView *preView;//预览视图
@property (strong, nonatomic) UITableViewCell *curCell;//当前播放的cell
@property (assign, nonatomic) CGFloat lastY;
@end

@implementation TestList

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initData];
    [self initSubView];
}

- (void)initData
{
    _rowHeight = [UIScreen mainScreen].bounds.size.height;
    _urls = @[].mutableCopy;
    _tags = @[].mutableCopy;
    _imgs = @[].mutableCopy;

    NSString *path = [[NSBundle mainBundle] pathForResource:@"Video" ofType:@"json"];
    NSData *data = [[NSData alloc] initWithContentsOfFile:path];
    NSArray *ary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    for (NSDictionary *dic in ary) {
        NSString *url = dic[@"play_url"];
        NSString *tag = dic[@"file_id"];
        NSString *img = dic[@"frontcover"];
        [_urls addObject:url];
        [_tags addObject:tag];
        [_imgs addObject:img];
        [[PlayerListManager shared] addWithUrl:url tagID:tag];
    }
    NSLog(@"urls:%@",ary);
}

- (void)initSubView
{

    self.mTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    self.mTableView.pagingEnabled = YES;
    self.mTableView.rowHeight  = [UIScreen mainScreen].bounds.size.height;
    self.mTableView.estimatedRowHeight = _rowHeight;
    self.mTableView.dataSource = self;
    self.mTableView.delegate = self;

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self scrollViewDidEndDecelerating:self.mTableView];
    });
}


- (UIView *)preView
{
    if (!_preView) {
        _preView = [UIView new];
    }
    return _preView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _urls.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return _rowHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    NSLog(@"row:%ld",row);
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    UIImageView *img = [cell viewWithTag:20];
    UIView *preView  = [cell viewWithTag:21];
    [img sd_setImageWithURL:[NSURL URLWithString:_imgs[row]] placeholderImage:nil];
    [cell.contentView sendSubviewToBack:preView];
    cell.tag = row;
    return cell;
}

/**
 分页切换视频源
 **/
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
//    return;
    CGPoint point = scrollView.contentOffset;
    NSInteger row = point.y/_rowHeight;
    if (row<0) {
        row = 0;
    }else if (row>_urls.count-1){
        row = _urls.count-1;
    }

    UITableViewCell *cell = [self.mTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:row inSection:0]];
    UIView *prwView  = [cell viewWithTag:21];
    UIImageView *coverView = [cell viewWithTag:20];
    UIView *contentView = cell.contentView;
    self.curCell = cell;

    NSString *tag = _tags[row];
    NSString *curTag = [PlayerListManager shared].curTagID;
    PlayerListManager *manager = [PlayerListManager shared];
    if (![tag isEqualToString:curTag]) {
        [contentView bringSubviewToFront:coverView];
        [manager pause];
        [manager moveToTagID:tag];
        [manager setPreView:prwView];

        //这儿应该监听到开始播放时才处理
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [contentView sendSubviewToBack:coverView];
        });
    }

}



/**
 当前播放的视频超出可视区时，暂停播放
 **/
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    return;
    NSInteger row = scrollView.contentOffset.y/_rowHeight;
    if (row<0) {
        row = 0;
    }else if (row>_urls.count-1){
        row = _urls.count-1;
    }
    BOOL upward = NO;//是否是向上滑
    if (scrollView.contentOffset.y>_lastY) {
        upward = YES;
    }
    _lastY = scrollView.contentOffset.y;
    CGPoint point = [self.curCell convertPoint:self.curCell.bounds.origin toView:self.view];
    BOOL isPause = YES;
    if (upward) {//向上滑
        if (point.y > -_rowHeight) {
            isPause = NO;
        }
    }else{//向下拉
        if (point.y < _rowHeight) {
            isPause = NO;
        }
    }
    if (isPause) {
        [[PlayerListManager shared] pause];
        [PlayerListManager shared].tmpIsPasue = isPause;
    }

}

/**
 回到可视区后恢复播放
 **/
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
//    return;
    NSLog(@"scrollViewDidEndDragging");
    //需要进行条件判断
    if ([PlayerListManager shared].tmpIsPasue) {
        [PlayerListManager shared].tmpIsPasue = NO;

        [[PlayerListManager shared] start];
        UIView *preView  = [self.curCell viewWithTag:21];
        [self.curCell.contentView bringSubviewToFront:preView];
    }
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
