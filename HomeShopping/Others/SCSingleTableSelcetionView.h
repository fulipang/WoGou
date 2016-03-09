//
//  SCSingleTableSelcetionView.h
//  HomeShopping
//
//  Created by sooncong on 16/1/13.
//  Copyright © 2016年 Administrator. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SCSingleTableSelcetionViewDelegate <NSObject>

@optional

/**
 *  完成点击
 *
 *  @param subArea 回传商圈模型
 */
- (void)seletedAtIndex:(NSInteger)index Title:(NSString *)title;

@end

@interface SCSingleTableSelcetionView : UIView <UITableViewDataSource,UITableViewDelegate>

/**
 *  代理
 */
@property (nonatomic, assign) id<SCSingleTableSelcetionViewDelegate> delegate;

/**
 *  表视图
 */
@property (nonatomic, strong) UITableView * selectionTableView;


#pragma mark - method

/**
 *  设置数据
 *
 *  @param dataSource 数据源
 */
-(void)setParameterWithDataSource:(NSArray *)dataSource;

@end
