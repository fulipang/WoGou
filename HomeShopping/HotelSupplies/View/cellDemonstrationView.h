//
//  cellDemonstrationView.h
//  HomeShopping
//
//  Created by sooncong on 16/1/1.
//  Copyright © 2016年 Administrator. All rights reserved.
//     cell 顶部 展示视图

#import <UIKit/UIKit.h>

@interface cellDemonstrationView : UIView

/**
 *  标题标签
 */
@property (nonatomic, strong) UILabel *titleLabel;

/**
 *  标题副标签
 */
@property (nonatomic, strong) UILabel *subLabel;

/**
 *  右侧标签
 */
@property (nonatomic, strong) UILabel *rightLabel;

/**
 *  右侧图片
 */
@property (nonatomic, strong) UIImageView *symBolImageView;

/**
 *  设置参数方法
 *
 *  @param title     标题内容
 *  @param subtitle  副标题内容
 *  @param rightText 右侧标签内容
 *  @param image     箭头图像
 */
- (void)setViewWithTitle:(NSString *)title SubTitle:(NSString *)subtitle RightTitle:(NSString *)rightText SymbolImage:(UIImage *)image;

@end
