//
//  SCSegmentControl.h
//  HomeShopping
//
//  Created by sooncong on 16/1/9.
//  Copyright © 2016年 Administrator. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  自定义分页控制器点击类型
 */
typedef NS_ENUM(NSInteger, SCSegmentControlClickType) {
    /**
     *  点击左侧
     */
    kSCSegClickLeft = 0,
    /**
     *  点击右侧
     */
    kSCSegClickRight,
};

/**
 *  回调block
 *
 *  @param clickType 点击类型
 */
typedef void(^SCSegmentCallBackBlock)(SCSegmentControlClickType clickType);

@interface SCSegmentControl : UIView

/**
 *  左侧按钮
 */
@property (nonatomic, strong) UIButton * leftButton;

/**
 *  右侧按钮
 */
@property (nonatomic, strong) UIButton * rightButton;

/**
 *  背景视图
 */
@property (nonatomic, strong) UIView * backGroundView;

/**
 *  回调方法
 *
 *  @param callBackBlock
 */
- (void)callBackWithBlock:(SCSegmentCallBackBlock)callBackBlock;

@end
