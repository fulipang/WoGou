//
//  ProductSelectedView.h
//  HomeShopping
//
//  Created by sooncong on 16/1/2.
//  Copyright © 2016年 Administrator. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  底部按钮点击类型
 */
typedef NS_ENUM(NSInteger, OperationType) {
    /**
     *  啥也没选
     */
    kNone = 0,
    /**
     *  加入购物车
     */
    kShoppingCart = 1,
    /**
     *  立即购买
     */
    kBuyImmediately,
};

typedef void(^SelectedCallBackBlock)(NSDictionary * dictionary,OperationType type);

@protocol ProductSelectedDelegate<NSObject>

@optional

- (NSDictionary *)shoppingCartClicked;

- (NSDictionary *)BuyImmediatelyClicked;

- (void)maskTapWithDictionary:(NSDictionary *)dic OperationType:(OperationType)type;

@end

@interface ProductSelectedView : UIView

/**
 *  代理
 */
@property (nonatomic, assign) id<ProductSelectedDelegate> delegate;

/**
 *  标题标签
 */
@property (nonatomic, strong) UILabel *titleLabel;

/**
 *  选择基视图
 */
@property (nonatomic, strong) UIView *selectedBaseView;

/**
 *  数量基视图
 */
@property (nonatomic, strong) UIView *quantityBaseView;

/**
 *  底部基视图
 */
@property (nonatomic, strong) UIView *bottomBaseView;

/**
 *  蒙版
 */
@property (nonatomic, strong) UIView *maskLayer;

#pragma mark - method

/**
 *  显示
 */
- (void)show;

/**
 *  隐藏
 */
- (void)hide;

- (void)callBackWithBlock:(SelectedCallBackBlock)block;

- (instancetype)initWithFrame:(CGRect)frame WithDataArry:(NSArray *)dataArry CallBackBlock:(SelectedCallBackBlock)block;

/**
 *  传值初始化方法
 *
 *  @param frame     frame
 *  @param dataArray 数据源
 *
 *  @return
 */
-(instancetype)initWithFrame:(CGRect)frame withDataArray:(NSArray *)dataArray;

@end
