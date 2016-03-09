//
//  ShoppingCartViewController.h
//  HomeShopping
//
//  Created by sooncong on 16/1/11.
//  Copyright © 2016年 Administrator. All rights reserved.
//

#import "UITableBaseViewController.h"

@interface ShoppingCartViewController : UITableBaseViewController

/**
 *  总金额标签
 */
@property (nonatomic, strong) UILabel * totalMoneyLabel;

/**
 *  总返购币数标签
 */
@property (nonatomic, strong) UILabel * totalCoinLabel;

/**
 *  全选按钮
 */
@property (nonatomic, strong) UIButton * AllselectionButton;

/**
 *  传值初始化方法
 *
 *  @param type 产品类型
 *
 *  @return
 */
-(instancetype)initWithProductType:(ProductType)type;

@end
