//
//  SpecialOffersViewController.h
//  HomeShopping
//
//  Created by sooncong on 16/1/7.
//  Copyright © 2016年 Administrator. All rights reserved.
//

#import "UITableBaseViewController.h"

/**
 *  点击标题类型
 */
typedef NS_ENUM(NSInteger, titleSortType) {
    /**
     *  酒店用品
     */
    kSortLeft = 1,
    /**
     *  订房
     */
    kSortRight,
};

@interface SpecialOffersViewController : UITableBaseViewController<UITableViewDataSource,UITableViewDelegate>

@end
