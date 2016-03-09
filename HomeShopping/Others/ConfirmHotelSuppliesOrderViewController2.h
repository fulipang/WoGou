//
//  ConfirmHotelSuppliesOrderViewController2.h
//  HomeShopping
//
//  Created by pfl on 16/1/20.
//  Copyright © 2016年 Administrator. All rights reserved.
//


#import "UITableBaseViewController.h"
#import "ProductDetail.h"

@interface ConfirmHotelSuppliesOrderViewController2 : UITableBaseViewController

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


/// productid
@property (nonatomic, readwrite, copy) NSString *productID;


/// 入住离店日期 俩个项 第一个项为 入住日期 离店日期
@property (nonatomic, readwrite, strong) NSArray *MonthDayArr;

/// 购买数量
@property (nonatomic, readwrite, assign) NSInteger orderNumber;

/// 住几晚
@property (nonatomic, readwrite, assign) NSInteger sleepDays;


/// 数据源 包含多个 酒店用品的 productDetail
@property (nonatomic, readwrite, strong) NSArray *dataSource;

/// 实付金额
@property (nonatomic, readwrite, assign) float totalMoney;

/// 返币
@property (nonatomic, readwrite, assign) float totalReturn;


/// 合并下单初始化
- (instancetype)initWithDataSource:(NSArray*)dataSource withOrderType:(OrderType)orderType;

-(instancetype)initWithNormDic:(NSDictionary *)normDic withOrderType:(OrderType)orderType;



@end










