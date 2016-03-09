//
//  AdvertisementWebViewController.h
//  HomeShopping
//
//  Created by sooncong on 16/1/19.
//  Copyright © 2016年 Administrator. All rights reserved.
//

#import "UIBaseViewController.h"

@interface AdvertisementWebViewController : UIBaseViewController

/**
 *  显示内容
 */
@property (nonatomic, strong) UIWebView * webView;

/**
 *  传值初始化方法
 *
 *  @param urlString 将要显示的网站字符串
 *
 *  @return 
 */
- (instancetype)initWithUrlString:(NSString *)urlString adsTitle:(NSString *)title;

@end
