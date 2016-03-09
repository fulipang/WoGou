//
//  PublicCollectionCell.h
//  HomeShopping
//
//  Created by sooncong on 16/1/9.
//  Copyright © 2016年 Administrator. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HSProduct.h"
#import "CollectionProduct.h"
#import "Sellers.h"
#import "HotelDetailModel.h"

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

@interface PublicCollectionCell : UITableViewCell

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
 *  设置cell参数
 *
 *  @param model 参数模型
 */
- (void)cellForRowWithModel:(HSProduct *)model;

/**
 *  设置cell参数
 *
 *  @param model 参数模型
 */
- (void)setCellWithCollectionModel:(CollectionProduct *)model;

/**
 *  设置参数
 *
 *  @param model 收藏酒店商家模型
 */
- (void)setCellWithSellerModel:(Sellers *)model;

/**
 *  设置参数
 *
 *  @param model 酒店详情模型
 */
- (void)setCellWithHotelDetailModel:(HotelDetailModel *)model;

/**
 *  回调方法
 *
 *  @param callBackBlock 回调block
 */
- (void)callBackWithBlock:(PublicCollectionCallBackBlock)callBackBlock;



@end
