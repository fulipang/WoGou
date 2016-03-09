//
//  SearchViewController.h
//  XMNiao_Customer
//
//  Created by huangxiong on 15/2/5.
//  Copyright (c) 2015年 Luo. All rights reserved.
//

#import "UIBaseViewController.h"
//#import "UIScanCodeTableViewController.h"
@interface SearchViewController : UIBaseViewController

/**
 *  传值初始化方法
 *
 *  @param productType 商品类型
 */
- (instancetype)initWithProductType:(ProductType)productType;

@end
