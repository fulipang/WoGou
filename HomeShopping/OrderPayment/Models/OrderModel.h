//
//  OrderModel.h
//  HomeShopping
//
//  Created by pfl on 16/1/14.
//  Copyright © 2016年 Administrator. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderModel : NSObject

/// 填写sj_bornwxorder
@property (nonatomic, readwrite, copy) NSString *functionid;
/// 订单商品列表
@property (nonatomic, readwrite, copy) NSArray *products;
/// products可包含多个product
@property (nonatomic, readwrite, copy) NSString *product;
/// 商品ID
@property (nonatomic, readwrite, copy) NSString *productid;
/// 此商品购买数量
@property (nonatomic, readwrite, copy) NSString *buycount;
/// 规格
@property (nonatomic, readwrite, copy) NSString *normtitle;
/// 规格id
@property (nonatomic, readwrite, copy) NSString *normid;
/// 入住日期，格式必须为YYYY-MM-DD，商品类型为虚拟时此项为必填
@property (nonatomic, readwrite, copy) NSString *indate;
/// 离店日期，格式必须为YYYY-MM-DD，商品类型为虚拟时此项为必填
@property (nonatomic, readwrite, copy) NSString *outdate;
/// 收货地址ID
@property (nonatomic, readwrite, copy) NSString *addressid;
/// 订单留言，以CDATA进行处理
@property (nonatomic, readwrite, copy) NSString *remark;
/// 快递公司ID
@property (nonatomic, readwrite, copy) NSString *expresscompanyid;
/// 使用购币个数
@property (nonatomic, readwrite, copy) NSString *usecoints;

/// 商品名称
@property (nonatomic, readwrite, copy) NSString *title;

/// 实付金额
@property (nonatomic, readwrite, assign) CGFloat totalAccount;

/// 订单号
@property (nonatomic, readwrite, copy) NSString *ordernum;
/// 预付id 微信预支付prepayid
@property (nonatomic, readwrite, copy) NSString *prepayid;


+ (void)sendRequestForPrepareWeixinPaySuccessedHandler:(void(^)(BOOL sussess, NSString *prepayid, NSString *ordernum))successedHandler;



@end














