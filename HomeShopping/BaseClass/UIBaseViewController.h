//
//  UIBaseViewController.h
//  HomeShopping
//
//  Created by Administrator on 15/12/9.
//  Copyright (c) 2015年 Administrator. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "SCEnum.h"
#import "Comments.h"
#import "BaiduMapHeader.h"

#define CUSTOM_LEFT_TAG (100)
#define CUSTOM_RIGHT_TAG (101)
#define CUSTOM_TITLE_TAG (102)

@interface UIBaseViewController : UIViewController <UIAlertViewDelegate,UIGestureRecognizerDelegate>


@property (nonatomic) BMKLocationService *locationService;

/**
 *  默认空显示内容
 */
@property (nonatomic, strong) UIView * emptyImageView;

/**
 *  自定义导航条
 */
@property (nonatomic, strong) UIView * customNavigationBar;

/**
 *  自定义导航条左按钮
 */
@property (nonatomic, strong) UIButton * customNavBarLeftBtn;

/**
 *  自定义导航条右按钮
 */
@property (nonatomic, strong) UIButton * customNavBarRightBtn;

/**
 *  自定义导航条标题视图
 */
@property (nonatomic, strong) UILabel * customNavBarTitleLabel;

/**
 *  自定义导航栏背景视图
 */
@property (nonatomic, strong) UIImageView * navBackGroundView;

#pragma mark - 设置相关
#pragma mark -- 导航条

/**
 *  设置导航栏左边按钮图片
 *
 *  @param leftButtonImageStr
 */
- (void)setNavigationBarLeftButtonImage:(NSString *)leftButtonImageStr;

/**
 *  设置导航栏右边按钮图片
 *
 *  @param rightButtonImageStr
 */
- (void)setNavigationBarRightButtonImage:(NSString *)rightButtonImageStr;


/**
 *  设置导航栏标题
 *
 *  @param title
 */
- (void)setNavigationBarTitle:(NSString *)title;

/**
 *  设置导航栏左边按钮文字
 *
 *  @param leftButtonTitleStr 按钮文字
 */
- (void) setNavigationBarLeftButtonTitle: (NSString *)leftButtonTitleStr;

/**
 *  设置导航栏右边按钮文字
 *
 *  @param rightButtonTitleStr 按钮文字
 */
- (void) setNavigationBarRightButtonTitle: (NSString *)rightButtonTitleStr;

#pragma mark - 事件相关

///**
// *  显示底栏
// */
//- (void)showTabBar;
//
///**
// *  隐藏底栏
// */
//- (void)hideTabBar;

/**
 *  自定义导航条 左按钮点击事件
 */
- (void)leftButtonClicked;

/**
 *  自定义导航条 右按钮点击事件
 */
- (void)rightButtonClicked;

/**
 *  隐藏自定义导航栏
 */
- (void) hidenCustomNavigationBar;

/**
 *  显示自定义导航栏
 */
- (void) showCustonNavigationBar;

/**
 *  添加蒙版
 *
 *  @param showView 蒙版上层视图
 */
- (void)addMaskViewWithShowView:(UIView *)showView;

-(void)setMaskFrame:(CGRect)frame WithReferenceView:(UIView *)referenceView;


/**
 *  蒙版点击事件
 */
- (void)maskTap;

/**
 *  移除蒙版
 */
- (void)removeMask;

/**
 *  计算labelsize
 *
 *  @param text
 *  @param maxSize
 *  @param fontSize 字号
 *
 *  @return
 */
- (CGSize) sizeForText:(NSString *)text WithMaxSize:(CGSize)maxSize AndWithFontSize:(CGFloat)fontSize;

/**
 *  计算评论cell 高度方法
 *
 *  @param comment 评论数据模型
 *
 *  @return 评论cell实际高度
 */
- (CGFloat)countCommentCellHeightWithModel:(Comments *)comment;

-(void)setNavigationBarLeftButtonImage:(NSString *)leftButtonImageStr WithTitle:(NSString *)title;

-(void)setNavigationBarRightButtonImage:(NSString *)rightButtonImageStr WithTitle:(NSString *)title;

/**
 *  跳转到广告公共方法
 *
 *  @param model 广告模型
 */
- (void)JumpToadvertisementWithModel:(id)model;

/**
 *  显示表视图空白图示
 *
 *  @param tableView
 */
- (void)showEmptyViewWithTableView:(UITableView *)tableView;

/**
 *  移除表视图空白图示
 *
 *  @param tableView
 */
- (void)removeEmptyViewWithTableView:(UITableView *)tableView;

/**
 *  判断请求是否成功
 *
 *  @param responseBody 返回数据
 *
 *  @return 
 */
- (BOOL)isRequestSuccess:(NSDictionary *)responseBody;

/**
 *  展示评论图片
 *
 *  @param model 评论模型
 */
- (void)CommentImageTapWithComment:(Comments *)model;

/**
 *  判断是否为纯数字
 *
 *  @param string 待判断字符串
 *
 *  @return 结果
 */
- (BOOL)isPureInt:(NSString*)string;

/**
 *  计算当前定位位置到酒店的距离
 *
 *  @param location  定位信息
 *  @param longitude 经度
 *  @param latitude  维度
 *
 *  @return 距离
 */
- (NSString *)countDistanceWithOriginLocaton:(CLLocationCoordinate2D)location HotelLongitude:(NSString *)longitude HotelLatitude:(NSString *)latitude;

/**
 *  根据两个经纬度计算距离
 *
 *  @param lon1 目标经度
 *  @param lat1 目标维度
 *  @param lon2 当前经度
 *  @param lat2 当前维度
 *
 *  @return 距离字符串
 */
- (NSString *) LantitudeLongitudeDist:(double)lon1 other_Lat:(double)lat1 self_Lon:(double)lon2 self_Lat:(double)lat2;


@end
