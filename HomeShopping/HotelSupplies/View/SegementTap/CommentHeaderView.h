//
//  CommentHeaderView.h
//  HomeShopping
//
//  Created by sooncong on 16/1/2.
//  Copyright © 2016年 Administrator. All rights reserved.
//

#import "SegmentTapView.h"

/**
 *  提示视图样式
 */
typedef NS_ENUM(NSInteger, CommentNoticeViewType) {
    /**
     *  线
     */
    kCommentNoticeTypeLine = 0,
    /**
     *  背景
     */
    kCommentNoticeTypeBackground
};

@protocol CommentHeaderViewDelegate <NSObject>

@optional

/**
 *  选择index回调
 *
 *  @param index
 */
-(void)selectedIndex:(NSInteger)index;

@end

@interface CommentHeaderView : UIView

/**
 选择回调
 */
@property (nonatomic, assign)id<CommentHeaderViewDelegate> delegate;
/**
 数据源
 */
@property (nonatomic, strong)NSArray *dataArray;
/**
 字体非选中时颜色
 */
@property (nonatomic, strong)UIColor *textNomalColor;
/**
 字体选中时颜色
 */
@property (nonatomic, strong)UIColor *textSelectedColor;
/**
 横线颜色
 */
@property (nonatomic, strong)UIColor *lineColor;
/**
 字体大小
 */
@property (nonatomic, assign)CGFloat titleFont;
/**
 Initialization
 
 @param frame     fram
 @param dataArray 标题数组
 @param font      标题字体大小
 
 @return instance
 */
-(instancetype)initWithFrame:(CGRect)frame withDataArray:(NSArray *)dataArray withFont:(CGFloat)font;
/**
 手动选择
 
 @param index inde（从1开始）
 */
-(void)selectIndex:(NSInteger)index;

/**
 *  设置字体颜色
 *
 *  @param normalColor   正常状态颜色
 *  @param selectedColor 选中状态颜色
 */
-(void)setTextColor:(UIColor *)normalColor SelectedColor:(UIColor *)selectedColor NoticeViewColor:(UIColor *)noticeViewColor;
/**
 *  设置提示背景样式
 *
 *  @param noticeViewType 样式枚举值
 */
- (void)setNoticeType:(NoticeViewType)noticeViewType;


/**
 *  设置评论数
 *
 *  @param dataArray 数量数组
 */
-(void)setCellwithNumberArr:(NSArray *)dataArray;

@end
