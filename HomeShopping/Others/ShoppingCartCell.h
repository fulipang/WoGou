//
//  ShoppingCartCell.h
//  HomeShopping
//
//  Created by sooncong on 16/1/11.
//  Copyright © 2016年 Administrator. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShoppingCarProduct.h"

/**
 *  底部按钮点击类型
 */
typedef NS_ENUM(NSInteger, PublicCollectionViewClickType) {
    /**
     *  点击查看
     */
    kPublicColletionClickTypeCheck = 0,
    /**
     *  点击删除
     */
    kPublicColletionClickTypedelete,
};

/**
 *  回调block
 *
 *  @param type 点击类型
 */
typedef void(^PublicCollectionCallBackBlock)(PublicCollectionViewClickType type);

@interface ShoppingCartCell : UITableViewCell

/**
 *  图片视图
 */
@property (nonatomic, strong) UIImageView * customHeadImageView;

/**
 *  标题标签
 */
@property (nonatomic, strong) UILabel * customTitleLabel;

/**
 *  会员价格
 */
@property (nonatomic, strong) UILabel * customPriceLabel;

/**
 *  狗币换购价格标签
 */
@property (nonatomic, strong) UILabel * shopCurrencyPriceLabel;

/**
 *  购买返狗币价格标签
 */
@property (nonatomic, strong) UILabel * rebateShopCurrencyLabel;

/**
 *  入店时间标签
 */
@property (nonatomic, strong) UILabel * beginDateLabel;

/**
 *  离店时间标签
 */
@property (nonatomic, strong) UILabel * endDateLabel;

/**
 *  总天数标签
 */
@property (nonatomic, strong) UILabel * totalDaysLabel;

/**
 *  数量操作基视图
 */
@property (nonatomic, strong) UIView * quantityBaseView;

/**
 *  显示数量标签
 */
@property (nonatomic, strong) UILabel * numberLabel;

/**
 *  勾选按钮
 */
@property (nonatomic, strong) UIButton * selectionButton;


/// 是否选择 选购数量
@property (nonatomic, readwrite, copy) void (^selectedCellCallback)(BOOL selected);

/// 住几晚
@property (nonatomic, readwrite, assign) NSInteger totalDays;

/// 是否选择选中
@property (nonatomic, readwrite, copy) void (^selectedButtonCallback)(BOOL selected);





/**
 *  设置cell参数
 *
 *  @param model 参数模型
 */
//- (void)cellForRowWithModel:(HSProduct *)model;

/**
 *  回调方法
 *
 *  @param callBackBlock 回调block
 */
- (void)callBackWithBlock:(PublicCollectionCallBackBlock)callBackBlock;

- (void)cellSetShopingCardProduct:(ShoppingCarProduct*)cardProduct;




@end
