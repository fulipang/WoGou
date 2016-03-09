//
//  Top5Cell.h
//  HomeShopping
//
//  Created by pfl on 16/1/23.
//  Copyright © 2016年 Administrator. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PossibleLike.h"

@interface Top5Cell : UITableViewCell

/**
 *  图片视图
 */
@property (nonatomic, strong) UIImageView * HeadImageView;

/**
 *  标题标签
 */
@property (nonatomic, strong) UILabel * customTitleLabel;

/**
 *  评分标签
 */
@property (nonatomic, strong) UILabel * customScoreLabel;

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
@property (nonatomic, strong) UILabel * customDistanceLabel;

/**
 *  预订标签
 */
@property (nonatomic, strong) UILabel * customReservationLabel;

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
@property (nonatomic, strong) UILabel * turnOverLabel;

/// top标识
@property (nonatomic, strong) UIImageView *topImageView;

///
@property (nonatomic, readwrite, strong) UILabel *topLabel;

/**
 *  设置cell参数
 *
 *  @param model 参数模型
 */
- (void)cellForRowWithModel:(PossibleLike *)model;


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
