//
//  SegmentTapView.h
//  SegmentTapView
//
//  Created by fujin on 15/6/20.
//  Copyright (c) 2015年 fujin. All rights reserved.
//

/**
 *  提示视图样式
 */
typedef NS_ENUM(NSInteger, NoticeViewType) {
    /**
     *  线
     */
    kNoticeTypeLine = 0,
    /**
     *  背景
     */
    kNoticeTypeBackground
};

/**
 *  回调block
 *
 *  @param index 点击按钮的下标
 */
typedef void(^SegmentTapViewCallBackBlock)(NSInteger index);

#import <UIKit/UIKit.h>

@protocol SegmentTapViewDelegate <NSObject>

@optional

/**
 *  选择index回调
 *
 *  @param index
 */
-(void)selectedIndex:(NSInteger)index;

@end

@interface SegmentTapView : UIView

/**
 选择回调
 */
@property (nonatomic, assign)id<SegmentTapViewDelegate> delegate;
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
 *  回调方法
 *
 *  @param callBackBlock 回调block
 */
-(void)callBackWithBlock:(SegmentTapViewCallBackBlock)callBackBlock;

@end
