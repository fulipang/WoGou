//
//  WaitCommentCell.h
//  HomeShopping
//
//  Created by sooncong on 16/1/10.
//  Copyright © 2016年 Administrator. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  点击按钮时调用
 */
typedef void(^WaitCommentBlock)(void);

@interface WaitCommentCell : UITableViewCell

/**
 *  头像
 */
@property (nonatomic, strong) UIImageView * headImageView;

/**
 *  价格标签
 */
@property (nonatomic, strong) UILabel * priceLabel;

/**
 *  数量标签
 */
@property (nonatomic, strong) UILabel * numberLabel;

/**
 *  标题标签
 */
@property (nonatomic, strong) UILabel * titleLabel;

/**
 *  点击按钮时外部调用方法
 *
 *  @param block 
 */
- (void)toCommentButtonClicked:(WaitCommentBlock)block;

@end
