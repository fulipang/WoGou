//
//  SCHomeNormalCell.h
//  HomeShopping
//
//  Created by sooncong on 15/12/10.
//  Copyright © 2015年 Administrator. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HPPossibleLikeModel.h"

@interface SCHomeNormalCell : UITableViewCell

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
 *  设置cell参数
 *
 *  @param model 参数模型
 */
- (void)cellForRowWithModel:(HPPossibleLikeModel *)model;

@end
