//
//  HotelProductInfoCell.h
//  HomeShopping
//
//  Created by sooncong on 16/1/14.
//  Copyright © 2016年 Administrator. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductDetail.h"

@interface HotelProductInfoCell : UITableViewCell

/**
 *  商品名称标签
 */
@property (nonatomic, strong) UILabel * TitleLabel;

/**
 *  会员价格标签
 */
@property (nonatomic, strong) UILabel * memberPriceLabel;

/**
 *  购币价格
 */
@property (nonatomic, strong) UILabel * coinPriceLabel;

/**
 *  返购币金额
 */
@property (nonatomic, strong) UILabel * coinReturnLabel;

/**
 *  销量标签
 */
@property (nonatomic, strong) UILabel * salesVolumeLabel;

/**
 *  配置cell信息
 *
 *  @param model 数据模型
 */
- (void)setCellWithModel:(ProductDetail *)model;

@end
