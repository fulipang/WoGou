//
//  MineViewController.h
//  HomeShopping
//
//  Created by sooncong on 15/12/23.
//  Copyright © 2015年 Administrator. All rights reserved.
//

#import "UIBaseViewController.h"

/**
 *  个人页面 顶部信息栏点击类型
 */
typedef NS_ENUM(NSInteger, InfoViewTapType) {
    /**
     *  点击历史
     */
    kInfoViewTypeHistory = 0,
    /**
     *  点击收藏
     */
    kInfoViewTypeCollection,
};

/**
 *  我的页面 tableview点击类型
 */
typedef NS_ENUM(NSInteger, MineTableViewSelectType) {
    /**
     *  我的商品订单
     */
    kMineTableViewSelectTypeCommodityOrder = 100,
    /**
     *  我的订房订单
     */
    kMineTableViewSelectTypeHotelOrder = 0,
    /**
     *  我的评论
     */
    kMineTableViewSelectTypeMyComment,
    /**
     *  我的购币
     */
    kMineTableViewSelectTypeMyCoin,
    /**
     *  修改账号密码
     */
    kMineTableViewSelectTypeModifyAccountOrPassWord,
    /**
     *  管理收货地址
     */
    kMineTableViewSelectTypeReceivingGoodsAddress,
    /**
     *  设置
     */
    kMineTableViewSelectTypeSetting,
};

@interface MineViewController : UIBaseViewController <UITableViewDelegate,UITableViewDataSource>


@end
