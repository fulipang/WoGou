//
//  SettingViewController.m
//  HomeShopping
//
//  Created by sooncong on 16/1/9.
//  Copyright © 2016年 Administrator. All rights reserved.
//

#import "SettingViewController.h"
#import "AdviceFeedBackViewController.h"
#import "ProtocolWebViewController.h"
#import "AboutUsViewController.h"
#import "SDImageCache.h"


typedef void(^caculateSize)(NSUInteger fileCount, NSUInteger totalSize);

@implementation SettingViewController
{
    //标题数组
    NSArray * _titles;
}

#pragma mark - 生命周期

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initDataSource];
    
    [self loadCostomViw];
}

#pragma mark - 初始化数据

- (void)initDataSource
{
    _titles = [NSArray arrayWithObjects:@"清除缓存",@"意见反馈",@"关于我们", nil];
}

#pragma mark - 自定义视图

/**
 *  装载自定义视图 总览
 */
- (void)loadCostomViw
{
    [self setNavigationBarLeftButtonImage:@"NavBar_Back"];
    
    [self setNavigationBarTitle:@"设置"];
    
    [self loadMainTableView];
}

- (void)loadMainTableView
{
    self.mainTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.view addSubview:self.mainTableView];
    [self.mainTableView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.and.bottom.mas_equalTo(self.view);
        make.top.mas_equalTo(self.customNavigationBar.bottom);
    }];
    
    self.mainTableView.delegate       = self;
    self.mainTableView.dataSource     = self;
    self.mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.mainTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
}

/**
 *  创建自定义cell 的contentview方法
 *
 *  @param indexPath 位置
 *
 *  @return
 */
- (UIView *)createCustomViewWithIndexPath:(NSIndexPath *)indexPath
{
    UIView * contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, GET_SCAlE_HEIGHT(45))];
    
    UILabel * line = [UILabel new];
    [contentView addSubview:line];
    [line makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(contentView.mas_bottom);
        make.right.mas_equalTo(contentView.right);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - GET_SCAlE_LENGTH(15), 0.5));
    }];
    line.backgroundColor = UIColorFromRGB(LINECOLOR);
    
    UILabel * customTitleLabel  = [UILabel new];
    [contentView addSubview:customTitleLabel];
    [customTitleLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(contentView.centerY).with.offset(0);
        make.left.mas_equalTo(contentView.left).with.offset(GET_SCAlE_LENGTH(20));
    }];
    customTitleLabel.textColor = UIColorFromRGB(BLACKFONTCOLOR);
    customTitleLabel.font = [UIFont systemFontOfSize:TITLENAMEFONTSIZE];
    customTitleLabel.text = _titles[indexPath.row];
    
    UIImageView * arrow = [UIImageView new];
    arrow.image = [UIImage imageNamed:@"arrow_right"];
    [contentView addSubview:arrow];
    [arrow makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(contentView.centerY);
        make.right.mas_equalTo(contentView.right).with.offset(GET_SCAlE_LENGTH(-15));
        make.size.mas_equalTo(CGSizeMake(arrow.image.size.width, arrow.image.size.height));
    }];
    
    return contentView;
}

#pragma mark - UITableviewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return GET_SCAlE_HEIGHT(45);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _titles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    for (id subView in cell.contentView.subviews) {
        
        if ([subView isKindOfClass:[UIView class]]) {
            
            UIView *vie = (UIView *)subView;
            [vie removeFromSuperview];
        }
    }
    
    [cell.contentView addSubview:[self createCustomViewWithIndexPath:indexPath]];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SettingClickType type = indexPath.row;
    
    switch (type) {
        case kSettingClickTypeCleanChache: {
            [self clearCach];
            break;
        }
        case kSettingClickTypeAdviceFeedBack: {
            self.hidesBottomBarWhenPushed = YES;
            AdviceFeedBackViewController * VC = [[AdviceFeedBackViewController alloc] init];
            [self.navigationController pushViewController:VC animated:YES];
            break;
        }
            //        case kSettingClickTypeCheckVersion: {
            //
            //            break;
            //        }
        case kSettingClickTypeAboutUs: {
            self.hidesBottomBarWhenPushed = YES;
            //            ProtocolWebViewController * VC = [[ProtocolWebViewController alloc] initWithTitle:@"关于我们" functionID:@"aboutus"];
            //            [self.navigationController pushViewController:VC animated:YES];
            AboutUsViewController * VC = [[AboutUsViewController alloc] init];
            [self.navigationController pushViewController:VC animated:YES];
            self.hidesBottomBarWhenPushed = NO;
            break;
        }
    }
}




#pragma mark 清除缓存

void SNImageCacheClearWithCompletion(void(^completion)(NSUInteger, NSUInteger)) {
    [[SDImageCache sharedImageCache] calculateSizeWithCompletionBlock:^(NSUInteger fileCount, NSUInteger totalSize) {
        completion(fileCount, totalSize);
    }];
    [[SDImageCache sharedImageCache] clearDiskOnCompletion:nil];
    
}
- (void)clearCach {
    SNImageCacheClearWithCompletion(^(NSUInteger fileCount, NSUInteger totalSize){
        [self clearCacheSuccess:totalSize];
    });
}


- (void)clearCacheSuccess:(NSUInteger)cachData {
    
    NSString *cachStr;
    
    if (cachData/1024/1024.0 < 0.2) {
        
        cachStr = [NSString stringWithFormat:@"清除成功！"];
    }else{
        cachStr = [NSString stringWithFormat:@"本次清除缓存%.2fM",cachData/1024/1024.0];
    }
    
    [self showAlertView:cachStr];
}

- (void)showAlertView:(NSString*)msg {
    [[[UIAlertView alloc]initWithTitle:@"提示" message:msg delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil] show];
}


#pragma mark - 事件

-(void)leftButtonClicked
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)rightButtonClicked
{
    
}

@end












