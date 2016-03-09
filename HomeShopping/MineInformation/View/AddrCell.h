//
//  AddrCell.h
//  HomeShopping
//
//  Created by sooncong on 16/1/8.
//  Copyright © 2016年 Administrator. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Addresse.h"

/**
 *  地址cell点击类型
 */
typedef NS_ENUM(NSInteger, AddrClickType) {
    /**
     *  点击勾选
     */
    kAddrClickTypeSelection = 0,
    /**
     *  点击编辑
     */
    kAddrClickTypeEdit,
    /**
     *  点击删除
     */
    kAddrClickTypeDelete,
};

/**
 *  回调块代码
 *
 *  @param AddrClickType 点击类型
 */
typedef void(^AddrCallBackBlock)(AddrClickType AddrClickType);

@interface AddrCell : UITableViewCell

/**
 *  收货人姓名标签
 */
@property (nonatomic, strong) UILabel * userNameLabel;

/**
 *  电话号码标签
 */
@property (nonatomic, strong) UILabel * telePhoneNumberLabel;

/**
 *  详细地址标签
 */
@property (nonatomic, strong) UILabel * detailAddrLabel;

/**
 *  默认勾选按钮
 */
@property (nonatomic, strong) UIButton * selectionButton;

/**
 *  回调方法
 *
 *  @param callBackBlock 回调块代码
 */
- (void)callBackWithBlock:(AddrCallBackBlock)callBackBlock;

/**
 *  配置cell信息
 *
 *  @param address 地址数据模型
 */
- (void)cellForRowWithModel:(Addresse *)address;

@end
