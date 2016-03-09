//
//  HomePageViewController.h
//  HomeShopping
//
//  Created by Administrator on 15/12/9.
//  Copyright (c) 2015年 Administrator. All rights reserved.
//

#import "UITableBaseViewController.h"

/**
 *  往哪个放下滚动
 */
typedef NS_ENUM(NSInteger, ScrollDirection) {

    kScrollToTop = 0,
    kScrollToLeft,
    kScrollToBottom,
    kScrollToRight,
};

@interface HomePageViewController : UITableBaseViewController <UIScrollViewDelegate,UISearchBarDelegate>

/**
 *  记录上次偏移量
 */
@property (nonatomic, assign) CGFloat lastScrollOffSet_y;

/**
 *  搜索栏标题搜索图片视图
 */
@property (nonatomic, strong) UIButton * searchButton;

@end
