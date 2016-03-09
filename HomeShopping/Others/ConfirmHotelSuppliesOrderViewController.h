//
//  ConfirmHotelSuppliesOrderViewController.h
//  HomeShopping
//
//  Created by sooncong on 16/1/12.
//  Copyright © 2016年 Administrator. All rights reserved.
//

#import "UITableBaseViewController.h"
#import "ProductDetail.h"

@interface ConfirmHotelSuppliesOrderViewController : UITableBaseViewController



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

/// 购买数量
@property (nonatomic, readwrite, assign) NSInteger sleepDays;


/**
 *  初始化方法 用于判断订单状态
 *
 *  @param type 订单按钮点击类型
 *
 *  @return
 */
-(instancetype)initWithOrderStatusType:(OrderOperationType)type;


/**
 *  酒店用品下单初始化
 *
 *  @param productDetail 商品详情
 *
 *  @return 
 */
-(instancetype)initWithProductDetailFromHSView:(ProductDetail *) productDetail NormData:(NSDictionary *)norm;


/// 酒店下单初始化
- (instancetype)initWithProductDetail:(ProductDetail *) productDetail;



@end










