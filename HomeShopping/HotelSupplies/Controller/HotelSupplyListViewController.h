//
//  HotelSupplyListView.h
//  HomeShopping
//
//  Created by sooncong on 15/12/23.
//  Copyright © 2015年 Administrator. All rights reserved.
//

#import "UITableBaseViewController.h"
#import "SCSortView.h"
#import "HPCategorysModel.h"

typedef NS_ENUM(NSInteger, sortType)
{
    kSortByPrice = 1,
    kSortBySales,
    kSortBySore,
    ksortByTime,
    kSortDefault,
};

@interface HotelSupplyListViewController : UITableBaseViewController<UITableViewDataSource,UITableViewDelegate,SCSortViewDlegate>

/**
 *  是否是酒店
 */
@property (nonatomic,assign) BOOL isHotel;

/**
 *  传category模型的初始化方法
 *
 *  @param category category模型
 *
 *  @return 
 */
- (instancetype)initWithCategoryModel:(HPCategorysModel *)category;

/**
 *  传categoryid的初始化方法
 *
 *  @param categoryId 栏目id
 *
 *  @return 
 */
- (instancetype)initWithCategoryID:(NSString *)categoryId;

/**
 *  传星级参数初始化方法
 *
 *  @param starLevel 星级参数
 *
 *  @return 
 */
-(instancetype)initWithStarLevels:(NSString *)starLevel;

@end
