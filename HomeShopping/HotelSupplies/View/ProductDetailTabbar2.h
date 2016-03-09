//
//  ProductDetailTabbar.h
//  HomeShopping
//
//  Created by sooncong on 15/12/31.
//  Copyright © 2015年 Administrator. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  商品详情底栏点击状态枚举
 */
typedef NS_ENUM(NSInteger, ProductTabType) {
    /**
     *  点击客服
     */
    kTapGustclothing = 1,
    /**
     *  点击电话
     */
    kTapTelPhone,
    /**
     *  点击收藏
     */
    kTapCollection,
    /**
     *  点击购物车
     */
    kTapShoppingCart,
    /**
     *  点击立即购买
     */
    kTapBuy,
};

typedef void(^productTabCallBackBlock)(ProductTabType type);

@interface ProductDetailTabbar2 : UIView

/**
 *  客服按钮
 */
@property (nonatomic, strong) UIButton *GuestclothingButton;

/**
 *  拨打电话按钮
 */
@property (nonatomic, strong) UIButton *telPhoneButton;

/**
 *  收藏按钮
 */
@property (nonatomic, strong) UIButton *collectionButton;

/**
 *  加入购物车按钮
 */
@property (nonatomic, strong) UIButton *ShoppingCartButton;

/**
 *  立即购买按钮
 */
@property (nonatomic, strong) UIButton *buyButton;

/**
 *  回调方法
 *
 *  @param callBackBlock 
 */
- (void)callBakcWithBlock:(productTabCallBackBlock)callBackBlock;

- (instancetype)initWithFrame:(CGRect)frame callBackBlock:(productTabCallBackBlock)callBackBlock;

@end
