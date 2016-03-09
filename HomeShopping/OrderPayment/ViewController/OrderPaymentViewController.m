//
//  OrderPaymentViewController.m
//  HomeShopping
//
//  Created by pfl on 16/1/14.
//  Copyright © 2016年 Administrator. All rights reserved.
//

#import "OrderPaymentViewController.h"
#import "OrderModel.h"
#import "OrderDetailHotelSuppliesViewController.h"
#import "ShoppingCarProduct.h"

NSString *const kOrderPaymentViewControllerDidReceivedMessageNotification = @"kOrderPaymentViewControllerDidReceivedMessageNotification";

NSString *const kOrderPaymentViewControllerDidPayUnsuccessedNotification = @"kOrderPaymentViewControllerDidPayUnsuccessedNotification";


@interface OrderPaymentViewController ()<WXApiManagerDelegate>
@property (nonatomic, readwrite, strong) OrderModel *orderModel;
@property (nonatomic, readwrite, strong) UILabel *payStatusLabel;
@property (nonatomic, readwrite, strong) UIImageView *payStatusImageView;

@property (nonatomic, readwrite, assign) PayType payType;
@property (nonatomic, readwrite, assign) OrderType orderType;

@property (nonatomic, readwrite, assign) BOOL isFromOrderList;


@property (nonatomic, readwrite, copy) NSArray *prducts;


/// 调用微信预支付接口 产生的订单号
@property (nonatomic, readwrite, copy) NSString *ordernum;
/// 调用微信预支付接口 产生的预付ID
@property (nonatomic, readwrite, copy) NSString *prepayID;

@end


@implementation OrderPaymentViewController

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (instancetype)initPayOrder:(OrderModel *)payOrder withPayType:(PayType)payType orderType:(OrderType)orderType {
    _orderModel = payOrder;
    return  [self initWithProducts:[self configureDataSource] withPayType:payType orderType:orderType];
    
}


- (instancetype)initPrepayID:(NSString *)prepayID orderNumber:(NSString*)ordernum payType:(PayType)payType {
    if (self = [super initWithNibName:nil bundle:nil]) {
        _prepayID = prepayID;
        _ordernum = ordernum;
        _payType = payType;
        _isFromOrderList = YES;
    }
    return self;
}

- (instancetype)initWithProducts:(NSArray *)products withPayType:(PayType)payType orderType:(OrderType)orderType {
    if (self = [super initWithNibName:nil bundle:nil]) {
        _prducts = products;
        _orderType = orderType;
        _payType = payType;
        
    }
    return self;
}



- (NSArray*)configureDataSource {
    
    
    ShoppingCarProduct *order = [ShoppingCarProduct new];
    order.productid = self.orderModel.productid;
    order.outdate = self.orderModel.outdate;
    order.indate = self.orderModel.indate;
    order.buycount = @(1).stringValue;
    //    order.sellername = self.orderModel.sellername;
    //    order.price = (self.orderModel.totalAccount).st;
    //    order.coinprice = self.orderModel.coinprice;
    //    order.coinreturn = _productDetail.coinreturn;
    //    order.logo = _productDetail.logo;
    order.title = self.orderModel.title;
    //    order.cityname = _productDetail.cityname;
    //    order.citycode = _productDetail.citycode;
    //    order.starlevel = _productDetail.starlevel;
    //    order.isneedbook = _productDetail.isneedbook;
    //    order.producttype = self.orderModel.producttype;
    //    order.turnover = _productDetail.turnover;
    //    order.distance = _productDetail.distance;
    //    order.address = _productDetail.address;
    //    order.score = _productDetail.score;
    //    order.isspecial = _productDetail.isspecial;
    self.totalMoney = self.orderModel.totalAccount;
    NSString *buyNum =@(1).stringValue;
    NSArray *products = @[order,buyNum];
    NSArray *dataSource = @[products];
    
    return dataSource;
}






- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadUpCustomeView];
    
    if (self.payType == kAliPayType) {
        [self aliPayClick];
    }
    else {
        if (self.isFromOrderList) {
            [self wechatPayClick];
        }
        else {
            [self sendRequestForPerpareWeixinPay];
        }
    }
    
    
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveMessage:) name:kOrderPaymentViewControllerDidReceivedMessageNotification object:nil];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    self.hidesBottomBarWhenPushed = YES;
}


- (void)loadUpCustomeView
{
    //  初始化自定义导航摊
    [self setUpCustomNavigationBar];
    
    //  初始化自定义视图
    [self.view addSubview:self.payStatusLabel];
}

- (void)setUpCustomNavigationBar
{
    [self setNavigationBarTitle:@"支付"];
    [self setNavigationBarLeftButtonImage:@"NavBar_Back"];
}

-(void)leftButtonClicked
{
    [self.navigationController popViewControllerAnimated:YES];
}




- (UILabel *)payStatusLabel {
    if (!_payStatusLabel) {
        _payStatusLabel = [[UILabel alloc]initWithFrame:CGRectMake(30, SCREEN_HEIGHT-104, SCREEN_WIDTH-60, 44)];
        _payStatusLabel.text = (self.payType == kAliPayType)? @"正在跳转至支付宝支付...":@"正在跳转至微信支付...";
        _payStatusLabel.textAlignment = NSTextAlignmentCenter;
        _payStatusLabel.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.3];
        _payStatusLabel.layer.cornerRadius = 4;
        _payStatusLabel.layer.masksToBounds = YES;
        [self.view addSubview:_payStatusLabel];
    }
    return _payStatusLabel;
}

- (UIImageView *)payStatusImageView {
    if (!_payStatusImageView) {
        _payStatusImageView = [[UIImageView alloc]initWithImage: [UIImage imageNamed:@"pay_success"]];
        _payStatusImageView.centerX_ = self.view.centerX_;
        _payStatusImageView.centerY_ = self.view.heightY * 0.3;
    }
    return _payStatusImageView;
}

#pragma 微信支付结果通知

- (void)receiveMessage:(NSNotification*)notifacation {
    
    PayResp *resp = (PayResp*)[notifacation object];
    NSString *strMsg = nil;
    NSInteger errCode = resp.errCode;
    switch (errCode) {
        case WXSuccess: strMsg = @"支付成功！正在跳转..."; break;
        case WXErrCodeCommon: strMsg = @"普通错误类型！"; break;
        case WXErrCodeUserCancel: strMsg = @"用户取消！"; break;
        case WXErrCodeSentFail: strMsg = @"发送失败！"; break;
        case WXErrCodeAuthDeny: strMsg = @"授权失败"; break;
        case WXErrCodeUnsupport: strMsg = @"微信不支持"; break;
        default: strMsg = [NSString stringWithFormat:@"支付结果：失败！retcode = %d, retstr = %@", resp.errCode,resp.errStr]; break;
    }
    
    [self.payStatusLabel setText:strMsg];

    
    if (errCode == WXSuccess) {
        
        [self sendRequestForHadWeixinPay];
        
    }
    else {
        
        [[NSNotificationCenter defaultCenter] postNotificationName:kOrderPaymentViewControllerDidPayUnsuccessedNotification object:nil];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.navigationController popViewControllerAnimated:YES];

        });
    }
    
    
    
}

#pragma mark 发起微信支付结果请求

- (void)sendRequestForHadWeixinPay {
    
    if(![[Reachability reachabilityForInternetConnection]isReachable])
    {
        return;
    }
    
    NSMutableDictionary * headDic = [[NSMutableDictionary alloc] initWithCapacity:1];
    NSMutableDictionary * bodyDic = [[NSMutableDictionary alloc] initWithCapacity:1];
    
    [bodyDic setObject:@"sj_wxpayresult" forKey:@"functionid"];
    
    [[NetWorkSingleton sharedManager] postWithHeadParameter:headDic bodyParameter:bodyDic SuccessBlock:^(id responseBody) {
        
        NSLog(@"支付结果 = %@",responseBody);
        
        if (responseBody) {
            if ([responseBody isKindOfClass:[NSDictionary class]]) {
                
                NSDictionary *dic = (NSDictionary*)responseBody;
                NSString *resultdesc = [[dic objectForKey:@"head"] objectForKey:@"resultdesc"];
                NSString *resultcode = [[dic objectForKey:@"head"] objectForKey:@"resultcode"];
                if ([resultcode isEqualToString:@"0000"]) {
                    [self.view addSubview:self.payStatusImageView];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                        [self popToMineViewController];
                        [self popToOrderDetail];
                    });
                }
                else {
                    [SVProgressHUD showErrorWithStatus:resultdesc duration:1.5];
                    [self.navigationController popViewControllerAnimated:YES];
                }
                
            }
            else {
                [SVProgressHUD showErrorWithStatus:@"支付失败" duration:1.5];
                [self.navigationController popViewControllerAnimated:YES];
            }
        }
                
    } FailureBlock:^(NSString *error) {
        
        [SVProgressHUD showErrorWithStatus:error duration:1.5];
        [[self navigationController] popToRootViewControllerAnimated:YES];
        
    }];
    
    
}

#pragma mark 跳转到订单详情
- (void)popToOrderDetail {
    
    Orders *model = [Orders new];
    model.orderid = self.ordernum?:@"";
    model.ordernum = self.ordernum?:@"";
    OrderDetailHotelSuppliesViewController *detail = [[OrderDetailHotelSuppliesViewController alloc]initWithOrderModel:model];
    detail.isHotel = _orderType == kOrderTypeReservation;
    detail.isFromPay = YES;
    [self.navigationController pushViewController:detail animated:YES];
}


#pragma mark 跳转到 '我的'
- (void)popToMineViewController {
    [self.navigationController.tabBarController setSelectedViewController:self.navigationController.tabBarController.viewControllers[self.navigationController.tabBarController.viewControllers.count-1]];
    [[self navigationController] popToRootViewControllerAnimated:YES];

}

#pragma mark 发起微信预支付请求

- (void)sendRequestForPerpareWeixinPay
{
    if(![[Reachability reachabilityForInternetConnection]isReachable])
    {
        return;
    }
    
    NSMutableDictionary * headDic = [[NSMutableDictionary alloc] initWithCapacity:1];
    NSMutableDictionary * bodyDic = [[NSMutableDictionary alloc] initWithCapacity:1];
    NSMutableDictionary * productDic = [[NSMutableDictionary alloc] initWithCapacity:3];
    NSMutableDictionary * productsDic = [[NSMutableDictionary alloc] initWithCapacity:1];
    
    NSMutableArray *orders = [NSMutableArray array];
    
    /// 合并下单
    if (self.prducts) {
        for (OrderModel *order in self.prducts) {
            NSMutableDictionary * productDic = [[NSMutableDictionary alloc] initWithCapacity:3];
            switch (self.orderType) {
                case kOrderTypeReservation:
                    [productDic setObject:order.indate?:@"" forKey:@"indate"];
                    [productDic setObject:order.outdate?:@"" forKey:@"outdate"];
                    break;
                case kOrderTypeHotelSupplies:
                    [productDic setObject:order.normtitle?:@"" forKey:@"normtitle"];
                    //                    [bodyDic setObject:order.usecoints?:@"0" forKey:@"usecoints"];
                    
                    if (![bodyDic objectForKey:@"addressid"]) {
                        [bodyDic setObject:order.addressid?:@"" forKey:@"addressid"];
                    }
                    if (![bodyDic objectForKey:@"expresscompanyid"]) {
                        [bodyDic setObject:order.expresscompanyid?:@"" forKey:@"expresscompanyid"];
                    }
                    break;
                default:
                    break;
            }
            
            [productDic setObject:order.buycount?:@"" forKey:@"buycount"];
            [productDic setObject:order.productid?:@"" forKey:@"productid"];
            if (![bodyDic objectForKey:@"remark"]) {
                [bodyDic setObject:order.remark?:@"" forKey:@"remark"];
            }
            
            [orders addObject:productDic];
        }
        [bodyDic setObject:orders forKey:@"products"];
        
    }
    else { // 单个单
        [productDic setObject:self.orderModel.normtitle?:@"" forKey:@"normtitle"];
        [productDic setObject:self.orderModel.buycount?:@"" forKey:@"buycount"];
        [productDic setObject:self.orderModel.productid?:@"" forKey:@"productid"];
        [productDic setObject:self.orderModel.indate?:@"" forKey:@"indate"];
        [productDic setObject:self.orderModel.outdate?:@"" forKey:@"outdate"];
        [bodyDic setObject:self.orderModel.remark?:@"" forKey:@"remark"];
        
        NSArray *arr = @[productDic];
        [bodyDic setObject:arr forKey:@"products"];
        
    }
    
    if ([[AppInformationSingleton shareAppInfomationSingleton] getLoginCode]) {
        [headDic setObject:[[AppInformationSingleton shareAppInfomationSingleton] getLoginCode] forKey:@"ut"];
        [headDic setObject:[[AppInformationSingleton shareAppInfomationSingleton] getUserID] forKey:@"userid"];
    }
    [bodyDic setObject:@"sj_bornwxorder" forKey:@"functionid"];
    
    
    
    [[NetWorkSingleton sharedManager] postWithHeadParameter:headDic bodyParameter:bodyDic productsParameter:productsDic SuccessBlock:^(id responseBody) {
        
        NSLog(@"微信预支付 = %@",responseBody);
        
        if (responseBody) {
            if ([responseBody isKindOfClass:[NSDictionary class]]) {
                
                NSDictionary *dic = (NSDictionary*)responseBody;
                NSString *resultcode = [[dic objectForKey:@"head"] objectForKey:@"resultcode"];
                NSString *resultdesc = [[dic objectForKey:@"head"] objectForKey:@"resultdesc"];
                if ([resultcode isEqualToString:@"0000"]) {
                    
                    self.prepayID = [[responseBody objectForKey:@"body"] objectForKey:@"prepayid"];
                    self.ordernum = [[responseBody objectForKey:@"body"] objectForKey:@"orderid"];
                    NSLog(@"self.prepayID:%@",self.prepayID);
                    [self wechatPayClick];
                    
                }
                else {
                    [SVProgressHUD showErrorWithStatus:resultdesc duration:1.5];
                    [self.navigationController popViewControllerAnimated:YES];
                }
            }
        }
        
    } FailureBlock:^(NSString *error) {
        
        NSLog(@"erro = %@",error);
        
    }];
}



#pragma mark 集成支付方式 ======微信和支付宝支付=======

#pragma mark ======支付宝支付========

- (void)aliPayClick
{
    Product *product = [Product new];
    product.orderId = [AppMethod getRandomString];
    product.subject = self.orderModel.title?:@"22";
    product.body = self.orderModel.title?:@"22";
    product.price = self.totalMoney/100;
    [[AlipayHelper shared] alipay:product block:^(NSDictionary *result) {
        
        NSString *message = @"";
        NSInteger resultStatu = [[result objectForKey:@"resultStatus"] integerValue];
        
        switch(resultStatu)
        {
            case 9000:message = @"订单支付成功,正在跳转中..."; break;
            case 8000:message = @"正在处理中...";break;
            case 4000:message = @"订单支付失败!";break;
            case 6001:message = @"用户中途取消";break;
            case 6002:message = @"网络连接错误";break;
            default:message = @"未知错误";
        }
        if (resultStatu == 9000) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self popToMineViewController];
            });
        }
        else {
            [self.navigationController popViewControllerAnimated:YES];
        }
        [self.payStatusLabel setText:message];
        
    }];
    
}


#pragma mark ======微信========

- (void)wechatPayClick
{
//    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
//    [dict setObject:WeixinAppKey forKey:@"appid"];
    //    [dict setObject:self.orderModel.title?:@"" forKey:@"body"];
//    [dict setObject:WeChatMCH_ID forKey:@"mch_id"];
//    [dict setObject:[AppMethod getRandomString] forKey:@"nonce_str"];
    //    [dict setObject:WeChatNOTIFY_URL forKey:@"notify_url"];
    //    [dict setObject:self.ordernum?:@"" forKey:@"out_trade_no"];
    //    [dict setObject:@"120.197.89.189" forKey:@"spbill_create_ip"];
    //    [dict setObject:[NSString stringWithFormat:@"%.0f",self.orderModel.totalAccount*100.0] forKey:@"total_fee"];
    //    [dict setObject:@"APP" forKey:@"trade_type"];
    
    PayReq* req             = [[PayReq alloc]init];
    req.partnerId           = WeChatMCH_ID;
    req.prepayId            = self.prepayID;
    req.nonceStr            = [AppMethod getRandomString];
    req.timeStamp           = [[NSString stringWithFormat:@"%.0f",[[NSDate date] timeIntervalSince1970]] intValue];
    req.package             = @"Sign=WXPay";
    
    NSMutableDictionary *rdict = [NSMutableDictionary dictionary];
    [rdict setObject:WeChatAppID forKey:@"appid"];
    [rdict setObject:req.partnerId forKey:@"partnerid"];
    [rdict setObject:self.prepayID forKey:@"prepayid"];
    [rdict setObject:req.nonceStr forKey:@"noncestr"];
    [rdict setObject:[NSString stringWithFormat:@"%u",(unsigned int)req.timeStamp] forKey:@"timestamp"];
    [rdict setObject:req.package forKey:@"package"];
    NSDictionary *result = [AppMethod partnerSignOrder:rdict];
    req.sign = [result objectForKey:@"sign"];
    
    [WXApi sendReq:req];
    
    
}




@end
