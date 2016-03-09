//
//  UITableBaseViewController.h
//  FlyingAnts
//
//  Created by Esc on 15/8/25.
//  Copyright (c) 2015年 Esc. All rights reserved.
//

#import <UIKit/UIKit.h>
#include "UIBaseViewController.h"
#import "MJRefresh.h"
#import "SCEnum.h"

@interface UITableBaseViewController : UIBaseViewController <UITableViewDelegate,UITableViewDataSource>

/**
 *  主 tableview
 */
@property (nonatomic, strong) UITableView *mainTableView;

/**
 *  上提加载视图
 */
@property (nonatomic, strong) MJRefreshFooterView *footRefreshView;

/**
 *  下拉刷新视图
 */
@property (nonatomic, strong) MJRefreshHeaderView *headRefreshView;

/**
 *  基础视图
 */
@property (nonatomic, strong) MJRefreshBaseView *baseView;


- (void)addpull2RefreshWithTableView:(UIScrollView *)tableView;
- (void)addPush2LoadMoreWithTableView:(UIScrollView *)tableView;

/**
 *  下来刷新
 *
 *  @param scrollerView 操作对象
 */
- (void)pull2RefreshWithScrollerView:(UIScrollView *)scrollerView;

/**
 *  上提加载
 *
 *  @param scrollerView 操作对象
 */
- (void)push2LoadMoreWithScrollerView:(UIScrollView *)scrollerView;

#pragma mark - 手动停止刷新

- (void)refreshOverWithTableView:(UIScrollView *)tableView;
- (void)refreshFialedWithTableView:(UIScrollView *)tableView;
- (void)infiniteOverWithTableView:(UIScrollView *)tableView;


/**
 *  刷新完毕
 */
- (void) endRefreshing;



- (void)webViewInfiteOverWithTableView:(UIScrollView *)tableView;

@end
