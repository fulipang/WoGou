//
//  MapViewController.h
//  HomeShopping
//
//  Created by pfl on 16/1/16.
//  Copyright © 2016年 Administrator. All rights reserved.
//

#import "UIBaseViewController.h"

@interface MapViewController : UIBaseViewController

/// 选择城市回调
@property (nonatomic, readwrite, copy) void (^callBackSelectedCity) (NSString *city);

/**
 * latitude 纬度
 *  longitude 经度
 */
- (instancetype)initWithLatitude:(NSString*)latitude longitude:(NSString*)longitude;

/// 城市定位 调用此方法
- (instancetype)initForLocalCity;
@end
