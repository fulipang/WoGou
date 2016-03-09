//
//  ProtocolWebViewController.h
//  HomeShopping
//
//  Created by sooncong on 16/1/8.
//  Copyright © 2016年 Administrator. All rights reserved.
//

#import "UIBaseViewController.h"

@interface ProtocolWebViewController : UIBaseViewController


/**
 *  初始化并设置导航栏标题
 *
 *  @param title 导航栏标题
 *
 *  @return 
 */
-(instancetype)initWithTitle:(NSString *)title functionID:(NSString *)functionID;

@end
