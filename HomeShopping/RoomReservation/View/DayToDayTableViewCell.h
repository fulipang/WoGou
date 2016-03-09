//
//  DayToDayTableViewCell.h
//  HomeShopping
//
//  Created by pfl on 16/1/18.
//  Copyright © 2016年 Administrator. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductDetail.h"
#import "HSProduct.h"


@interface DayToDayTableViewCell : UITableViewCell

/**
 *  入住日期标签
 */
@property (nonatomic, strong) UILabel * dayBeginLabel;


/**
 *  离店日期标签
 */
@property (nonatomic, strong) UILabel * datEndLabel;

/**
 *  显示一共住几日标签
 */
@property (nonatomic, strong) UILabel * totalDaysLabel;

/// 购买数量
@property (nonatomic, readwrite, assign) NSInteger orderNumber;


/// 入住离店日期 俩个项 第一个项为 入住日期 离店日期
@property (nonatomic, readwrite, strong) NSArray *MonthDayArr;

@property (nonatomic, readwrite, strong) ProductDetail *productDetail;


/**
 *  图片视图
 */
@property (nonatomic, strong) UIImageView * customHeadImageView;

/**
 *  标题标签
 */
@property (nonatomic, strong) UILabel * customTitleLabel;


/**
 *  星级标签
 */
@property (nonatomic, strong) UILabel * customStarLevelLabel;

/**
 *  会员价格
 */
@property (nonatomic, strong) UILabel * customPriceLabel;

/**
 *  距离标签
 */
//@property (nonatomic, strong) UILabel * customDistanceLabel;

/**
 *  预订标签
 */
//@property (nonatomic, strong) UILabel * customReservationLabel;

/**
 *  狗币换购价格标签
 */
@property (nonatomic, strong) UILabel * shopCurrencyPriceLabel;

/**
 *  购买返狗币价格标签
 */
@property (nonatomic, strong) UILabel * rebateShopCurrencyLabel;

/**
 *  成交量标签
 */
//@property (nonatomic, strong) UILabel * turnOverLabel;

/**
 *  特惠标志
 */
@property (nonatomic, strong) UIImageView * specailOfferImageView;

/**
 *  设置cell参数
 *
 *  @param model 参数模型
 */
- (void)cellForRowWithModel:(HSProduct *)model;


/**
 *  设置cell参数
 *
 *  @param model 参数模型
 */
//- (void)cellForRowWithPossibleLike:(PossibleLike *)model;


/**
 *  判断是否显示星级 距离 是否预订标签
 *
 *  @param flag 判断条件
 */
- (void)cellForHoelSuppListVC:(BOOL)flag;

/**
 *  判断是否显示特惠标志
 *
 *  @param isShow 判断条件
 */
- (void)cellShowSpecialSymbol:(BOOL)isShow;


@end
