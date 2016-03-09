//
//  SCTableSlectionView.h
//  HomeShopping
//
//  Created by sooncong on 16/1/3.
//  Copyright © 2016年 Administrator. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Subareas.h"
#import "Areas.h"


@protocol SCTableSelectionViewDelegate <NSObject>

@optional

/**
 *  完成点击
 *
 *  @param subArea 回传商圈模型
 */
- (void)seletedArea:(Areas *)area subArea:(Subareas *)subArea;

@end

@interface SCTableSlectionView : UIView <UITableViewDataSource,UITableViewDelegate>

/**
 *  代理
 */
@property (nonatomic, assign) id<SCTableSelectionViewDelegate> delegate;

/**
 *  父表视图
 */
@property (nonatomic, strong) UITableView * fatherTableView;

/**
 *  子表视图
 */
@property (nonatomic, strong) UITableView *subTableView;


#pragma mark - method

/**
 *  设置数据
 *
 *  @param dataSource 数据源
 */
-(void)setParameterWithDataSource:(NSArray *)dataSource;


@end
