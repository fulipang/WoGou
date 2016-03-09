//
//  RoomReservationDetailCell.h
//  HomeShopping
//
//  Created by sooncong on 16/1/13.
//  Copyright © 2016年 Administrator. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HSProduct.h"

typedef void(^setOrderBlock)(void);

@interface RoomReservationDetailCell : UITableViewCell


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
 *  回调方法
 *
 *  @param block 回调block
 */
- (void)callBackWithBlock:(setOrderBlock)block;

/**
 *  设置
 *
 *  @param norm <#norm description#>
 */
- (void)setNormInfoWithDic:(NSDictionary *)norm;


@end
