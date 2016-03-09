//
//  ProductDetailHeaderView.h
//  HomeShopping
//
//  Created by sooncong on 15/12/31.
//  Copyright © 2015年 Administrator. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductDetailHeaderView : UIView

/**
 *  背景视图
 */
@property (nonatomic, strong) UIImageView *baseView;

/**
 *  头像
 */
@property (nonatomic, strong) UIImageView *headImageView;

/**
 *  标题标签
 */
@property (nonatomic, strong) UILabel *titleLabel;

/**
 *  评分标签
 */
@property (nonatomic, strong) UILabel *scoreLabel;

/**
 *  收藏标签
 */
@property (nonatomic, strong) UILabel *collectionLabel;

/**
 *  配置数据
 *
 *  @param model 参数模型
 */
-(void)setParameterWithModel:(id)model;

@end
