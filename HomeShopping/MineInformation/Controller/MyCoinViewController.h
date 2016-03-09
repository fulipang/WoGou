//
//  MyCoinViewController.h
//  HomeShopping
//
//  Created by sooncong on 16/1/9.
//  Copyright © 2016年 Administrator. All rights reserved.
//

#import "UITableBaseViewController.h"

/**
 *  我的购币cell类型
 */
typedef NS_ENUM(NSInteger, MyCoinCellType) {
    /**
     *  剩余购币
     */
    kCoinCellTypeRestCoin = 0,
    /**
     *  购币记录
     */
    kCoinCellTypeCoinRecord,
    /**
     *  购币规则
     */
    kCoinCellTypeCoinRules,
};

@interface MyCoinViewController : UITableBaseViewController


-(instancetype)initWithCoinNumber:(NSString *)coins;

@end
