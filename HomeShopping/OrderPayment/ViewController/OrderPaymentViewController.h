//
//  OrderPaymentViewController.h
//  HomeShopping
//
//  Created by pfl on 16/1/14.
//  Copyright © 2016年 Administrator. All rights reserved.
//

/// 支付类型
typedef enum : NSUInteger {
    /// 支付宝支付
    kAliPayType,
    /// 微信支付
    kWeixinPayType,
} PayType;







#import "UIBaseViewController.h"
#import "OrderProductCell.h"

@class OrderModel;


extern NSString *const kOrderPaymentViewControllerDidReceivedMessageNotification;

/// 支付未成功通知
extern NSString *const kOrderPaymentViewControllerDidPayUnsuccessedNotification;


@interface OrderPaymentViewController : UIBaseViewController


/// 总金额
@property (nonatomic, readwrite, assign) float totalMoney;

/// 此方法已不再使用
- (instancetype)initPayOrder:(OrderModel*)payOrder  withPayType:(PayType)payType orderType:(OrderType)orderType;

/// 已有订单号和预付id
- (instancetype)initPrepayID:(NSString *)prepayID orderNumber:(NSString*)ordernum payType:(PayType)payType;

/// 合并订单初始化
- (instancetype)initWithProducts:(NSArray*)products withPayType:(PayType)payType orderType:(OrderType)orderType;





@end
