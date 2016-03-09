//
//  OrderDetailHotelSuppliesViewController.h
//  HomeShopping
//
//  Created by sooncong on 16/1/11.
//  Copyright © 2016年 Administrator. All rights reserved.
//

#import "UITableBaseViewController.h"

@interface OrderDetailHotelSuppliesViewController : UITableBaseViewController



/**
 *  头像
 */
@property (nonatomic, strong) UIImageView * headImageView;

/**
 *  价格标签
 */
@property (nonatomic, strong) UILabel * priceLabel;

/**
 *  数量标签
 */
@property (nonatomic, strong) UILabel * numberLabel;

/**
 *  标题标签
 */
@property (nonatomic, strong) UILabel * titleLabel;

/**
 *  购币价格标签
 */
@property (nonatomic, strong) UILabel * coinPriceLabel;

/**
 *  消费返购币标签
 */
@property (nonatomic, strong) UILabel * coinReturnLabel;

@property (nonatomic) BOOL isHotel;

/// 是否来自支付
@property (nonatomic, readwrite, assign) BOOL isFromPay;

/**
 *  初始化方法
 *
 *  @param model 订单模型
 *
 *  @return
 */
-(instancetype)initWithOrderModel:(Orders *)model;


@end
