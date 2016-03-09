//
//  SearchResultViewController.h
//  XMNiao_Customer
//
//  Created by huangxiong on 14/12/1.
//  Copyright (c) 2014年 Luo. All rights reserved.
//

#import "UITableBaseViewController.h"

@interface SearchResultViewController : UITableBaseViewController

/**
 *  关键字，即搜索的关键字
 */
@property (nonatomic, copy) NSString *keyWord;

/**
 *  搜索框
 */
@property (nonatomic, strong) UISearchBar *searchBar;

/**
 *  传值初始化方法
 *
 *  @param keyWords    关键字
 *  @param productType 商品类型
 *
 *  @return
 */
- (instancetype)initWithKeyWorks:(NSString * )keyWords ProductType:(ProductType)productType;


@end
