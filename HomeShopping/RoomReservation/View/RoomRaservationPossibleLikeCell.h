//
//  RoomRaservationPossibleLikeCell.h
//  HomeShopping
//
//  Created by sooncong on 16/1/13.
//  Copyright © 2016年 Administrator. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HSProduct.h"

@interface RoomRaservationPossibleLikeCell : UITableViewCell

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
 *  排位状况
 */
@property (nonatomic, strong) UIImageView * positionImageView;

///**
// *  特惠标志
// */
//@property (nonatomic, strong) UIImageView * specailOfferImageView;

/**
 *  设置cell参数
 *
 *  @param model 参数模型
 */
- (void)cellForRowWithModel:(HSProduct *)model;


@end
