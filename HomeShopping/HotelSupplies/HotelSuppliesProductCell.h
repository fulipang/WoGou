//
//  HotelSuppliesProductCell.h
//  HomeShopping
//
//  Created by sooncong on 15/12/24.
//  Copyright © 2015年 Administrator. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HSProduct.h"
#import "Hotels.h"

#import "PossibleLike.h"

@interface HotelSuppliesProductCell : UITableViewCell
 
 /**
 *  图片视图
 */
@property (nonatomic, strong) UIImageView * customHeadImageView;

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
- (void)cellForRowWithPossibleLike:(PossibleLike *)model;

/**
 *  设置cell参数
 *
 *  @param model 酒店数据模型
 */
- (void)cellForRowWithHotelModel:(Hotels *)model;


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

/**
 *  是否显示“起”
 *
 *  @param isDetail 
 */
- (void)showDetail:(BOOL)isShow;


@end
