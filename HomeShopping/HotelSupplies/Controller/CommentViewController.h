//
//  CommentViewController.h
//  HomeShopping
//
//  Created by sooncong on 16/1/2.
//  Copyright © 2016年 Administrator. All rights reserved.
//

#import "UITableBaseViewController.h"
#import "CommentHeaderView.h"
#import "CommentCell.h"
#import "ProductDetail.h"

@interface CommentViewController : UITableBaseViewController<UITableViewDataSource,UITableViewDelegate,CommentHeaderViewDelegate>

/**
 *  传值初始化方法
 *
 *  @param product 商品详情数据模型
 *
 *  @return 
 */
-(instancetype)initWithProductDetail:(ProductDetail *)product;

@end
