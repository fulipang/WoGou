//
//  HotelSuppliesShowCell.h
//  HomeShopping
//
//  Created by sooncong on 15/12/18.
//  Copyright © 2015年 Administrator. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HSSubcategory.h"

@interface HotelSuppliesShowCell : UICollectionViewCell

/**
 *  预览图片
 */
@property (nonatomic, strong) UIImageView * imageView;

/**
 *  标题标签
 */
@property (nonatomic, strong) UILabel * titleLabel;

/**
 *  配置cell参数
 *
 *  @param model 模型
 */
- (void)setCellWithModel:(HSSubcategory *)model;

@end
