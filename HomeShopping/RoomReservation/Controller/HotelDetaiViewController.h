//
//  HotelDetaiViewController.h
//  HomeShopping
//
//  Created by pfl on 16/1/16.
//  Copyright © 2016年 Administrator. All rights reserved.
//

//
//@interface HotelDetaiModel3 : NSObject
///// 商家logo
//@property (nonatomic, readwrite, copy) NSString *logo;
//
///// 商家店名
//@property (nonatomic, readwrite, copy) NSString *shopName;
//
///// 评分
//@property (nonatomic, readwrite, copy) NSString *rateScore;
//
///// 收藏人数
//@property (nonatomic, readwrite, copy) NSString *favNumber;
//
////@property (nonatomic, readwrite, copy) NSString *allSh
//
//@end
//
//@implementation HotelDetaiModel3
//
//@end


#import "UITableBaseViewController.h"
#import "RoomReserVationDetailViewController.h"

#import "SegmentTapView.h"
#import "FlipTableView.h"
#import "HSProduct.h"

/**
 *  自定义导航条上segment点击类型
 */
typedef NS_ENUM(NSInteger, TitleSegmentClickType) {
    /**
     *  商品
     */
    kClickCommodity = 1,
    /**
     *  详情
     */
    kClickDetails
};

typedef NS_ENUM(NSInteger, productType)
{
    kProductPhysical = 1,
    kProductVirtual =2
};

@interface HotelDetaiViewController : UITableBaseViewController

/// 入住离店
@property (nonatomic, readwrite, strong) NSArray *monthDayArr;

/**
 *  自定义分页控制器
 */
@property (nonatomic, strong) SegmentTapView * segMentTapView;

/**
 *  左侧表视图
 */
@property (nonatomic, strong) UITableView * leftTableView;

/**
 *  右侧底层视图
 */
@property (nonatomic, strong) UIView *rightBaseView;

/// 商家logo
@property (nonatomic, readwrite, copy) NSString *logo;

/// 商家店名
@property (nonatomic, readwrite, copy) NSString *shopName;

/// 评分
@property (nonatomic, readwrite, copy) NSString *rateScore;

/// 收藏人数
@property (nonatomic, readwrite, copy) NSString *favNumber;

// 商家介绍
@property (nonatomic, readwrite, copy) NSString *intro;

/**
 *  商家id
 */
@property (nonatomic, strong) NSString *sellerid;

/**
 *  是否是从用品页面过来
 */
@property (nonatomic) BOOL isProduct;

/**
 *  传值初始化方法
 *
 *  @param product 商品模型
 *
 *  @return
 */
-(instancetype)initWithProduct:(id)product;



@end
