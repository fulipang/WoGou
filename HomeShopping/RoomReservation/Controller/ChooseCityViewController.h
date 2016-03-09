//
//  ChooseCityViewController.h
//  HomeShopping
//
//  Created by sooncong on 16/1/4.
//  Copyright © 2016年 Administrator. All rights reserved.
//

#import "UITableBaseViewController.h"

@interface ChooseCityViewController : UITableBaseViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, readwrite, copy) void (^selectedCityCallBack)(NSString *city, NSString *cityCode);


@end
