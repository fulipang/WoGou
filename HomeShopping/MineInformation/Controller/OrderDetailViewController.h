//
//  OrderDetailViewController.h
//  HomeShopping
//
//  Created by sooncong on 16/1/10.
//  Copyright © 2016年 Administrator. All rights reserved.
//

#import "UIBaseViewController.h"

@interface OrderDetailViewController : UIBaseViewController


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
 *  初始化方法 用于判断订单状态
 *
 *  @param type 订单按钮点击类型
 *
 *  @return 
 */
-(instancetype)initWithOrderStatusType:(OrderOperationType)type;

@end
