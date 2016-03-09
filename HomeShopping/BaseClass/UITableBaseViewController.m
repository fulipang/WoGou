//
//  UITableBaseViewController.m
//  FlyingAnts
//
//  Created by Esc on 15/8/25.
//  Copyright (c) 2015年 Esc. All rights reserved.
//

#import "UITableBaseViewController.h"

@interface UITableBaseViewController ()<MJRefreshBaseViewDelegate>

@end

@implementation UITableBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.navigationController.navigationBarHidden = YES;
}

#pragma mark - 添加刷新事件

- (void)addpull2RefreshWithTableView:(UIScrollView *)tableView
{
    _headRefreshView = [[MJRefreshHeaderView alloc] initWithScrollView: tableView andDelegate: self];
    [_headRefreshView endRefreshing];
}


- (void)addPush2LoadMoreWithTableView:(UITableView *)tableView
{
    _footRefreshView = [[MJRefreshFooterView alloc] initWithScrollView: tableView andDelegate: self];
    [_footRefreshView endRefreshing];
}


#pragma mark - MJRefreshBaseViewDelegate

- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    _baseView = refreshView;
    
    if (refreshView == _headRefreshView)
    {
        [self pull2RefreshWithScrollerView: _mainTableView];
    }
    else
    {
        [self push2LoadMoreWithScrollerView: _mainTableView];
    }
}

- (void) endRefreshing
{
    if (_baseView == _headRefreshView)
    {
        [_headRefreshView endRefreshing];
    }
    else
    {
        [_footRefreshView endRefreshing];
    }
    [_mainTableView reloadData];
}

- (void)insertRowAtTopWithTableView:(UIScrollView *)tableView  WithIsInset:(BOOL)isInset{
    
    float_t delayInSeconds;
    if (isInset) {
        delayInSeconds = .2;
    }else{
        delayInSeconds = .5;
    }
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^{
        if ([tableView isKindOfClass:[UITableView class]]) {
            
            [(UITableView *)tableView beginUpdates];
        }
        
        [self pull2RefreshWithScrollerView:tableView];
        
        if ([tableView isKindOfClass:[UITableView class]]) {
            
            [(UITableView *)tableView endUpdates];
        }
    });
    
    
}


- (void)insertRowAtBottomWithTableView:(UIScrollView *)tableView  WithIsInset:(BOOL)isInset{
    float_t delayInSeconds;
    if (isInset) {
        delayInSeconds = .2;
    }else{
        
        delayInSeconds = .5;
    }
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds *NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^{
        if ([tableView isKindOfClass:[UITableView class]]) {
            
            [(UITableView *)tableView beginUpdates];
        }
        [self push2LoadMoreWithScrollerView:tableView];
        if ([tableView isKindOfClass:[UITableView class]]) {
            
            [(UITableView *)tableView endUpdates];
        }
    });
    
    
    
}
//下拉刷新
- (void)pull2RefreshWithScrollerView:(UIScrollView *)scrollerView{
    
    
}

//上提加载
- (void)push2LoadMoreWithScrollerView:(UIScrollView *)scrollerView{
    
}

- (void)refreshOverWithTableView:(UIScrollView *)tableView{
    
    [self endRefreshing];
}

- (void)refreshFialedWithTableView:(UITableView *)tableView{
    
    [self endRefreshing];
}
//上提加载完成
- (void)infiniteOverWithTableView:(UITableView *)tableView{
    
    [self endRefreshing];
}

//webView上提加载完成

- (void)webViewInfiteOverWithTableView:(UIScrollView *)tableView{
    
    [self endRefreshing];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    // 移除监听
    [_headRefreshView free];
    
    // 移除监听
    [_footRefreshView free];
    
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
