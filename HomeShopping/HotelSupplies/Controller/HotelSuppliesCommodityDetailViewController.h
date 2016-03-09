//
//  HotelSuppliesCommodityDetailViewController.h
//  HomeShopping
//
//  Created by sooncong on 15/12/14.
//  Copyright © 2015年 Administrator. All rights reserved.
//

#import "UIBaseViewController.h"
#import "SegmentTapView.h"
#import "FlipTableView.h"
#import "HSProduct.h"
#import "ProductSelectedView.h"
#import "HotelDetaiViewController.h"

///**
// *  自定义导航条上segment点击类型
// */
//typedef NS_ENUM(NSInteger, TitleSegmentClickType) {
//    /**
//     *  商品
//     */
//    kClickCommodity = 1,
//    /**
//     *  详情
//     */
//    kClickDetails
//};
//
//typedef NS_ENUM(NSInteger, productType)
//{
//    kProductPhysical = 1,
//    kProductVirtual =2
//};

@interface HotelSuppliesCommodityDetailViewController : UIBaseViewController<ProductSelectedDelegate>

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


/**
 *  传值初始化方法
 *
 *  @param product 商品模型
 *
 *  @return 
 */
-(instancetype)initWithProduct:(id)product;

/**
 *  传值初始化方法
 *
 *  @param productID 商品id
 *
 *  @return 
 */
-(instancetype)initWithProductID:(NSString * )productID;


@end
