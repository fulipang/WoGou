//
//  AdvertisementWebViewController.m
//  HomeShopping
//
//  Created by sooncong on 16/1/19.
//  Copyright © 2016年 Administrator. All rights reserved.
//

#import "AdvertisementWebViewController.h"

@implementation AdvertisementWebViewController
{
    NSString * _urlString;
    
    NSString * _title;
}

-(instancetype)initWithUrlString:(NSString *)urlString adsTitle:(NSString *)title
{
    self = [super init];
    
    if (self) {
        
        _urlString = urlString;
        _title = title;
    }
    
    return self;
}

#pragma mark - 生命周期

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    [self loadCostomViw];
}

#pragma mark - 自定义视图

/**
 *  装载自定义视图 总览
 */
- (void)loadCostomViw
{
    [self setNavigationBarLeftButtonImage:@"NavBar_Back"];
    
    [self setNavigationBarTitle:_title];
    
    _webView = [UIWebView new];
    [self.view addSubview:_webView];
    [_webView makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.customNavigationBar.bottom);
        make.left.right.and.bottom.mas_equalTo(self.view);
    }];
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_urlString]]];
}



#pragma mark - 事件

-(void)leftButtonClicked
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

-(void)rightButtonClicked
{
    
}

@end
