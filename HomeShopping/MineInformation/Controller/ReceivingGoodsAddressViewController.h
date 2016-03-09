//
//  ReceivingGoodsAddressViewController.h
//  HomeShopping
//
//  Created by sooncong on 16/1/8.
//  Copyright © 2016年 Administrator. All rights reserved.
//

#import "UITableBaseViewController.h"

@class Addresse;

@interface ReceivingGoodsAddressViewController : UITableBaseViewController

@property (nonatomic, readwrite, copy) void (^callbackAddressID) (Addresse *addresse);

@end
