//
//  CommentCell.h
//  HomeShopping
//
//  Created by sooncong on 16/1/1.
//  Copyright © 2016年 Administrator. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Comments.h"

typedef void(^CommentImageTapBlock)(Comments * model);

@interface CommentCell : UITableViewCell

/**
 *  头像
 */
@property (nonatomic, strong) UIImageView *headImageView;

/**
 *  昵称标签
 */
@property (nonatomic, strong) UILabel *nickNameLabel;

/**
 *  评论时间标签
 */
@property (nonatomic, strong) UILabel *commentTimeLabel;

/**
 *  客服评分基视图
 */
@property (nonatomic, strong) UIView *guestClothingScoreBaseView;

/**
 *  描述评分基视图
 */
@property (nonatomic, strong) UIView *descriptionScroeBaseView;

/**
 *  评论内容基视图
 */
@property (nonatomic, strong) UIView *commentDetailBaseView;

/**
 *  评论内容标签
 */
@property (nonatomic, strong) UILabel * commentLabel;

/**
 *  商家回复基视图
 */
@property (nonatomic, strong) UIView *businessReplyBaseView;

/**
 *  商家回复标签
 */
@property (nonatomic, strong) UILabel * businessReplyLabel;

/**
 *  cell高度
 */
@property (nonatomic, assign) CGFloat cellHeight;

/**
 *  配置cell参数
 *
 *  @param comment 数据模型
 */
- (void)setCellWithModel:(Comments *)comment;

/**
 *  评论图片点击回调
 *
 *  @param block 
 */
- (void)imageTaped:(CommentImageTapBlock)block;

@end
