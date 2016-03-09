//
//  OrderProductCell.h
//  HomeShopping
//
//  Created by sooncong on 16/1/10.
//  Copyright © 2016年 Administrator. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Products.h"
#import "Orders.h"

/**
 *  订单类型
 */
typedef NS_ENUM(NSInteger, OrderType) {
    /**
     *  酒店用品
     */
    kOrderTypeHotelSupplies = 0,
    /**
     *  订房
     */
    kOrderTypeReservation,
};

typedef void(^OrderCellCallBackBlock)(void);

@interface OrderProductCell : UITableViewCell

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
 *  订房天数标签
 */
@property (nonatomic, strong) UILabel * orderDays;

/**
 *  入店日期
 */
@property (nonatomic, strong) UILabel * beginDateLabel;

/**
 *  离店日期
 */
@property (nonatomic, strong) UILabel * endDateLabel;

/**
 *  验证码标签
 */
@property (nonatomic, strong) UILabel * confirmCodeLabel;

/**
 *  订单状态标签
 */
@property (nonatomic, strong) UILabel * statusLabel;

/**
 *  验证码标题标签
 */
@property (nonatomic, strong) UILabel * codeTitleLabel;

/**
 *  根据订单类型配置cell
 *
 *  @param type 订单类型
 */
- (void)setCellTypeWithOrderType:(OrderType)type;

/**
 *  回调方法
 *
 *  @param type 按钮点击类型
 */
- (void)callBackWithBlock:(OrderCellCallBackBlock)block;

/**
 *  配置cell参数
 *
 *  @param model 数据模型
 */
- (void)setCellWithModel:(Products *)model OrderModel:(Orders *)order;


@end
