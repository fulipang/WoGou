//
//  ConfirmRoomOrderViewController.h
//  HomeShopping
//
//  Created by sooncong on 16/1/13.
//  Copyright © 2016年 Administrator. All rights reserved.
//

#import "UITableBaseViewController.h"
#import "HSProduct.h"
#import "ProductDetail.h"

@interface ConfirmRoomOrderViewController : UITableBaseViewController
/**
 *  入住日期标签
 */
@property (nonatomic, strong) UILabel * dayBeginLabel;


/**
 *  离店日期标签
 */
@property (nonatomic, strong) UILabel * datEndLabel;

/**
 *  显示一共住几日标签
 */
@property (nonatomic, strong) UILabel * totalDaysLabel;


/// 入住离店日期 俩个项 第一个项为 入住日期 离店日期
@property (nonatomic, readwrite, strong) NSArray *MonthDayArr;

@property (nonatomic, readwrite, strong) ProductDetail *productDetail;


@property (nonatomic, readwrite, strong) HSProduct *product;

/// 详细介绍
@property (nonatomic, readwrite, copy) NSString *longIntro;

/// 简单介绍
@property (nonatomic, readwrite, copy) NSString *shortIntro;

/// productid
@property (nonatomic, readwrite, copy) NSString *productid;

@end







