//
//  AppUtils.h
//  PNeayBy
//
//  Created by wpf on 15/11/15.
//  Copyright © 2015年 wpf. All rights reserved.
//
//////////////////////////---系统设置，方法替换---//////////////////////////////

#ifndef AppUtils_h
#define AppUtils_h

#pragma mark - SDK宏定义
//////////////////////////支付宝//////////////////////////////
#define AlipayPARTNER           @"2088811229131974"
#define AlipaySELLER            @"qhdazfb@163.com"
#define AlipayRSA_PRIVATE       @"MIICdwIBADANBgkqhkiG9w0BAQEFAASCAmEwggJdAgEAAoGBAN7GCzSAr0zOqPcqEGy9YZQEqZPJjlrQEHo8yo5eDrG0DmUzVM4Kj6jyqPwuFlvyMkZW6c5XhT49iahqcmM1fAD0ckEx1A0x4R2pR8/RalYlBbVf2H0VYamobbNgRmpLLy7XGSpBwpXGlFsDvsyjGk22udQI7THo49qtuJom4daDAgMBAAECgYB3Ge6XrU0LhVl0ezq4yC9JEY0QBCxlhOOqVqH8p3C3tQoVNPJcDe1sZ//Mg19U3RHf5UuvE7+a3Q+hyPdK7ydR45AOmf3OUEE0BDMtVErZjlH+TFLX19HseB82ZrDuhbx4PvWw5V0gex2bzRzTGTUHQN684pcqOLzXvSI9QePNIQJBAP1803IKvH/GrCSxodkfw929RPipQotDJ4DUqYAxCsbnV3+LJ7KGdObO6fE+1FdG9C8F0wWn9DIq1QrTYQIF3ZkCQQDg+0mGHyXlCDgq2xx0AEvOs8PPYR1/zecR14EK6w96YW2bz6a9e+KBW5/XnudJad8xeT+Aac+MnaJjETgewg57AkBMoUO6ogxCBGld3mUzIiswCVukYGbBeteiVqe3HRxI7P7Ci+rASW1lqP+H8pp2l/iRjo0wlIl58QDeePBGkEdhAkEAny4MMkIdjLPJEcFfm0+OU1xrQXIj7gYf5EbGvZPcqqj+ZUyBW/WoKABM0sFSQWYQDbAM1u2GdKYfe9p2C4UfuwJBAL0ma4V0dlu9IiQFWokR0Zpho4E+4uNfAXI3Fpvh38rCSxLyY923VJADJQKqsc1Px4E8gllGiYQVnFtKRI4044Y="
#define AlipayRSA_ALIPAY_PUBLIC @"MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDDI6d306Q8fIfCOaTXyiUeJHkrIvYISRcc73s3vF1ZT7XN8RNPwJxo8pWaJMmvyTn9N4HQ632qJBVHf8sxHi/fEsraprwCtzvzQETrNRwVxLO5jVmRGi60j8Ue1efIlzPXV9je9mkjzOmdssymZkh2QhUrCmZYI/FCEa3/cNMW0QIDAQAB"
//获取服务器端支付数据地址（商户自定义）
#define AlipayBackURL           @"http://www.baidu.com"


//////////////////////////微信//////////////////////////////
#define WeChatAppID             @"wx0761b5dd04114882"
#define WeChatAppSecret         @"3a3beed2dfee04ab6a140cab66ce006d"
//商户号，填写商户对应参数
#define WeChatMCH_ID                  @"1305185801"
//商户API密钥，填写相应参数
#define WeChatPARTNER_ID              @"7xbkdwuvec127e9ffo0a021i0fd54qws"//@"aFw1opQ90jiL88YUmwd9HVB62de4kn49"
//支付结果回调页面
#define WeChatNOTIFY_URL              @"http://wwww.51xiuxiubang.com/wywx/wxservice.do"
//获取服务器端支付数据地址（商户自定义）
#define SP_URL                  @""
//http://pay1.fujin.com/aspx/alipayreturn_m.aspx?f=app1


#pragma mark - 方法替换等
//////////////////////////方法替换//////////////////////////////
#ifdef DEBUG
#define WPFLOG(xx, ...)  NSLog(@"%s(%d): " xx, __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#elif RELEASE
#define WPFLOG(xx, ...)  ((void)0)
#else
#define WPFLOG(xx, ...)  ((void)0)
#endif


#define IMAGE(a)                     [UIImage imageNamed:(a)]


// 防止循环引用
#define WS(weakSelf)      __weak __typeof(&*self)weakSelf = self;



#pragma mark - 字体
//////////////////////////字体//////////////////////////////
#define mySysFont(a)                 [UIFont systemFontOfSize:(a)]
#define myBolFont(a)                 [UIFont boldSystemFontOfSize:(a)]
#define myItaFont(a)                 [UIFont italicSystemFontOfSize:(a)]

#pragma mark - 颜色
//////////////////////////颜色//////////////////////////////

#define RGBIntegerColor(r,g,b,a)     [UIColor colorWithRed:((r)/255.0f) green:((g)/255.0f) blue:((b)/255.0f) alpha:(a)/100.0f]

#define COLOR_WITHIMAGE(a)           [UIColor colorWithPatternImage:[UIImage imageNamed:(a)]]
//
#define COLOR_CLEARCOLOR             [UIColor clearColor]
#define COLOR_WHITECOLOR             [UIColor whiteColor]
#define COLOR_BLACKCOLOR             [UIColor blackColor]
#define COLOR_GRAYCOLOR              [UIColor grayColor]
#define COLOR_LIGHTGRAYCOLOR         [UIColor lightGrayColor]
#define COLOR_REDCOLOR               [UIColor redColor]
#define COLOR_BLUECOLOR              [UIColor blueColor]
#define COLOR_GREENCOLOR             [UIColor greenColor]





#pragma mark - 系统属性
//////////////////////////系统属性//////////////////////////////
#define NAVHEIGHT         64




#endif /* AppUtils_h */
