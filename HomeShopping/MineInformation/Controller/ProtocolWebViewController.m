//
//  ProtocolWebViewController.m
//  HomeShopping
//
//  Created by sooncong on 16/1/8.
//  Copyright © 2016年 Administrator. All rights reserved.
//

#import "ProtocolWebViewController.h"

@implementation ProtocolWebViewController
{
    //导航标题
    NSString * _navTitle;
    
    //接口参数
    NSString * _functionID;
    
    UIWebView * _webView;
}

-(instancetype)initWithTitle:(NSString *)title functionID:(NSString *)functionID
{
    self = [super init];
    
    if (self) {
        _navTitle = title;
        _functionID = functionID;
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
    
    [self getProtocolData];
}

#pragma mark - 自定义视图

/**
 *  装载自定义视图 总览
 */
- (void)loadCostomViw
{
    [self setNavigationBarLeftButtonImage:@"NavBar_Back"];
    
    [self setNavigationBarTitle:_navTitle];
    
    _webView = [[UIWebView alloc] init];
    [self.view addSubview:_webView];
    [_webView makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.customNavigationBar.bottom);
        make.left.right.and.bottom.mas_equalTo(self.view);
    }];
}



#pragma mark - 事件

-(void)leftButtonClicked
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)rightButtonClicked
{
    
}

#pragma mark - 网络

- (void)getProtocolData
{
    if(![[Reachability reachabilityForInternetConnection]isReachable])
    {
        return;
    }
    
    NSMutableDictionary * headDic = [[NSMutableDictionary alloc] initWithCapacity:1];
    
    NSMutableDictionary * bodyDic = [[NSMutableDictionary alloc] initWithCapacity:1];
    [bodyDic setObject:_functionID forKey:@"functionid"];
    
    [[NetWorkSingleton sharedManager] postWithHeadParameter:headDic bodyParameter:bodyDic SuccessBlock:^(id responseBody) {
        
//        NSLog(@"result = %@",responseBody);
//        
        NSString * htmlString = [responseBody objectForKey:@"body"][@"content"];
        [_webView loadHTMLString:htmlString baseURL:nil];
        
    } FailureBlock:^(NSString *error) {
        
    }];
}

@end
