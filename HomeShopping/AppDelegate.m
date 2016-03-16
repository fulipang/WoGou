//
//  AppDelegate.m
//  HomeShopping
//
//  Created by Administrator on 15/12/9.
//  Copyright (c) 2015年 Administrator. All rights reserved.
//

#import "AppDelegate.h"
#import "ZFTabBarViewController.h"
#import "HomePageViewController.h"
#import "HotelSuppliesViewController.h"
#import "RoomReservatioinViewController.h"
#import "SpecialOffersViewController.h"
#import "MineViewController.h"
//#import <MAMapKit/MAMapKit.h>

#define kBaiduMapKey @"wlU1IVkxMfTTaZv6fSFIwolx"
#define IS_IOS8_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8)

#import "AppDelegate.h"
#import <BaiduMapAPI_Map/BMKMapComponent.h>

#import "UMSocial.h"
#import "UMSocialWechatHandler.h"
#import "UMSocialQQHandler.h"
#import "UMSocialAlipayShareHandler.h"
#import "UMSocialSinaSSOHandler.h"

@interface AppDelegate ()<BMKGeneralDelegate>

@end

@implementation AppDelegate


void SNImageCacheConfig(void)
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        //设置图片缓存最大内存
        [[SDImageCache sharedImageCache] setMaxMemoryCost:1024*1024*10];
        [[SDImageCache sharedImageCache] setMaxCacheAge:3600*24*7];
    });
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window                    = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor    = [UIColor whiteColor];
    
    //    ZFTabBarViewController * VC    = [[ZFTabBarViewController alloc] init];
    //    self.window.rootViewController = VC;
    
    [self setupTabbarController];
    
    [self registerUM];
    
    
    // 设置图片缓存大小
    SNImageCacheConfig();
    
    [WXApi registerApp:WeixinAppKey withDescription:@"HomeShopping"];
    
    
    BMKMapManager *mapManager = [BMKMapManager new];
    
    BOOL ret = [mapManager start:kBaiduMapKey generalDelegate:self];
    
    if (!ret) {
        NSLog(@"manager start failed!");
    }
    
    [self.window makeKeyAndVisible];
    
    return YES;
}

#pragma mark UMeng分享

- (void)registerUM {
    [UMSocialData setAppKey:@"56dfd3b1e0f55a9f6c000d99"];
    
#if DEBUG
    [UMSocialData openLog:YES];
#endif
    
    NSString *urlString = @"http://www.baidu.com";
    
    [UMSocialWechatHandler setWXAppId:@"wx0761b5dd04114882" appSecret:@"3a3beed2dfee04ab6a140cab66ce006d" url: urlString];
    
    // demo的数据
    [UMSocialQQHandler setQQWithAppId:@"1104231525" appKey:@"dX6nQwFwj93nC0t9" url: urlString];
    
    [UMSocialAlipayShareHandler setAlipayShareAppId:@"2016011101083286"];
    
    
    // demo的数据
    [UMSocialSinaSSOHandler openNewSinaSSOWithAppKey:@"3921700954"
                                              secret:@"04b48b094faeb16683c32669824ebdad"
                                         RedirectURL:@"http://sns.whalecloud.com/sina2/callback"];

    
    [UMSocialConfig hiddenNotInstallPlatforms:@[UMShareToQQ,UMShareToWechatTimeline,UMShareToWechatSession,UMShareToQzone]];
}

- (void)setupTabbarController {
    
    HomePageViewController *homePage = [[HomePageViewController alloc] initWithNibName:nil bundle:nil];
//    HotelSuppliesViewController *hotelSupply = [[HotelSuppliesViewController alloc] initWithNibName:nil bundle:nil];
    RoomReservatioinViewController *roomReservation = [[RoomReservatioinViewController alloc] initWithNibName:nil bundle:nil];
    SpecialOffersViewController *specailOffers = [[SpecialOffersViewController alloc] initWithNibName:nil bundle:nil];
    
    MineViewController *mineViewController = [[MineViewController alloc] initWithNibName:nil bundle:nil];
    
    
    homePage.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"首页"
                                                        image:[[UIImage imageNamed:@"TabBar_Home"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                                selectedImage:[[UIImage imageNamed:@"TabBar_Home_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
//    hotelSupply.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"酒店用品"
//                                                           image:[[UIImage imageNamed:@"TabBar_HotelThing"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
//                                                   selectedImage:[[UIImage imageNamed:@"TabBar_HotelThing_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    roomReservation.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"订房"
                                                               image:[[UIImage imageNamed:@"TabBar_Subscribes"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                                       selectedImage:[[UIImage imageNamed:@"TabBar_Subscribes_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    specailOffers.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"特惠" image:[[UIImage imageNamed:@"TabBar_Bargain"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                                     selectedImage:[[UIImage imageNamed:@"TabBar_Bargain_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    mineViewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"我的" image:[[UIImage imageNamed:@"TabBar_Mine"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                                          selectedImage:[[UIImage imageNamed:@"TabBar_Mine_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    UINavigationController *homeNavigationController = [[UINavigationController alloc] initWithRootViewController:homePage];
//    UINavigationController *hotelSupplyNavigationController = [[UINavigationController alloc] initWithRootViewController:hotelSupply];
    UINavigationController *roomReservationNavigationController = [[UINavigationController alloc] initWithRootViewController:roomReservation];
    UINavigationController *specailOffersNavigationController = [[UINavigationController alloc] initWithRootViewController:specailOffers];
    
    UINavigationController *mineNav = [[UINavigationController alloc] initWithRootViewController:mineViewController];
    
    UITabBarController *tabBarController = [[UITabBarController alloc] initWithNibName:nil bundle:nil];
    tabBarController.viewControllers = @[homeNavigationController, roomReservationNavigationController,specailOffersNavigationController,mineNav];
    
    
    [self.window.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    self.window.rootViewController = tabBarController;
}



- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    return [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    //如果极简开发包不可用，会跳转支付宝钱包进行支付，需要将支付宝钱包的支付结果回传给开发包
    if ([url.host isEqualToString:@"safepay"]) {
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            //【由于在跳转支付宝客户端支付的过程中，商户app在后台很可能被系统kill了，所以pay接口的callback就会失效，请商户对standbyCallback返回的回调结果进行处理,就是在这个方法里面处理跟callback一样的逻辑】
            NSString *message = @"";
            switch([[resultDic objectForKey:@"resultStatus"] integerValue])
            {
                case 9000:message = @"订单支付成功";break;
                case 8000:message = @"正在处理中";break;
                case 4000:message = @"订单支付失败";break;
                case 6001:message = @"用户中途取消";break;
                case 6002:message = @"网络连接错误";break;
                default:message = @"未知错误";
            }
            
            //            UIAlertController *aalert = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleAlert];
            //            [aalert addAction:[UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleCancel handler:nil]];
            //            UIViewController *root = self.window.rootViewController;
            //            [root presentViewController:aalert animated:YES completion:nil];
            
            NSLog(@"result = %@",resultDic);
        }];
    }
    else
    {
        return [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]];
    }
    return YES;
}



- (void)applicationWillResignActive:(UIApplication *)application {
    [BMKMapView willBackGround];//当应用即将后台时调用，停止一切调用opengl相关的操作
}
- (void)applicationDidBecomeActive:(UIApplication *)application {
    [BMKMapView didForeGround];//当应用恢复前台状态时调用，回复地图的渲染和opengl相关的操作
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}

- (void)onGetNetworkState:(int)iError
{
    if (0 == iError) {
        NSLog(@"联网成功");
    }
    else{
        NSLog(@"onGetNetworkState %d",iError);
    }
    
}

- (void)onGetPermissionState:(int)iError
{
    if (0 == iError) {
        NSLog(@"授权成功");
    }
    else {
        NSLog(@"onGetPermissionState %d",iError);
    }
}


@end





