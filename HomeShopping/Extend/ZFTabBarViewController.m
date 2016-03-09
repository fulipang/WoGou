//
//  ZFTabBarViewController.m
//  ZFTabBar
//
//  Created by 任子丰 on 15/9/10.
//  Copyright (c) 2014年 任子丰. All rights reserved.
//

#import "ZFTabBarViewController.h"
#import "ZFTabBar.h"
#import "HomePageViewController.h"
#import "HotelSuppliesViewController.h"
#import "MineViewController.h"
#import "RoomReservatioinViewController.h"
#import "SpecialOffersViewController.h"

@interface ZFTabBarViewController () <ZFTabBarDelegate>

/**
 *  自定义的tabbar
 */
@property (nonatomic, weak) ZFTabBar *customTabBar;
@end

@implementation ZFTabBarViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // 初始化tabbar
    [self setupTabbar];
    
    // 初始化所有的子控制器
    [self setupAllChildViewControllers];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // 删除系统自动生成的UITabBarButton
    for (UIView *child in self.tabBar.subviews) {
        if ([child isKindOfClass:[UIControl class]]) {
            [child removeFromSuperview];
        }
    }
}

/**
 *  初始化tabbar
 */
- (void)setupTabbar
{
    ZFTabBar *customTabBar = [[ZFTabBar alloc] init];
    customTabBar.frame = self.tabBar.bounds;
    customTabBar.delegate = self;
    [self.tabBar addSubview:customTabBar];
    self.customTabBar = customTabBar;
}

/**
 *  监听tabbar按钮的改变
 *  @param from   原来选中的位置
 *  @param to     最新选中的位置
 */
- (void)tabBar:(ZFTabBar *)tabBar didSelectedButtonFrom:(NSInteger)from to:(NSInteger)to
{
//    if (self.selectedIndex == to && to == 0 ) {//双击刷新制定页面的列表
//        UINavigationController *nav = self.viewControllers[0];
//        HomePageViewController *firstVC = nav.viewControllers[0];
//        [HomePageViewController refrshUI];
//    }
    self.selectedIndex = to;
}

/**
 *  初始化所有的子控制器
 */
- (void)setupAllChildViewControllers
{
    // 1.首页
    HomePageViewController *homePage = [[HomePageViewController alloc] init];
    [self setupChildViewController:homePage title:@"首页" imageName:@"TabBar_Home" selectedImageName:@"TabBar_Home_selected"];
    
    // 2.酒店用品
    HotelSuppliesViewController *hotelSupply = [[HotelSuppliesViewController alloc] init];
    [self setupChildViewController:hotelSupply title:@"酒店用品" imageName:@"TabBar_HotelThing" selectedImageName:@"TabBar_HotelThing_selected"];

    //3.订房
    RoomReservatioinViewController * roomReservation = [[RoomReservatioinViewController alloc] init];
    [self setupChildViewController:roomReservation title:@"订房" imageName:@"TabBar_Subscribes" selectedImageName:@"TabBar_Subscribes_selected"];

    //4.特惠
    SpecialOffersViewController * specailOffers = [[SpecialOffersViewController alloc] init];
    [self setupChildViewController:specailOffers title:@"特惠" imageName:@"TabBar_Bargain" selectedImageName:@"TabBar_Bargain_selected"];
    
    //5.我的
    MineViewController * mineViewController = [[MineViewController alloc] init];
    [self setupChildViewController:mineViewController title:@"我的" imageName:@"TabBar_Mine" selectedImageName:@"TabBar_Mine_selected"];
    

    
}

/**
 *  初始化一个子控制器
 *
 *  @param childVc           需要初始化的子控制器
 *  @param title             标题
 *  @param imageName         图标
 *  @param selectedImageName 选中的图标
 */
- (void)setupChildViewController:(UIViewController *)childVc title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName
{
    // 1.设置控制器的属性
    childVc.title = title;
    // 设置图标
    childVc.tabBarItem.image = [UIImage imageNamed:imageName];
    
    // 设置选中的图标
    UIImage *selectedImage = [UIImage imageNamed:selectedImageName];
    if (iOS7) {
        childVc.tabBarItem.selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    } else {
        childVc.tabBarItem.selectedImage = selectedImage;
    }
    
    // 2.包装一个导航控制器
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:childVc];
//    nav.navigationBar.hidden = YES;
    [self addChildViewController:nav];
    
    // 3.添加tabbar内部的按钮
    [self.customTabBar addTabBarButtonWithItem:childVc.tabBarItem];
}

@end
