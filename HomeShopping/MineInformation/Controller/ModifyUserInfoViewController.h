//
//  ModifyUserInfoViewController.h
//  HomeShopping
//
//  Created by sooncong on 15/12/29.
//  Copyright © 2015年 Administrator. All rights reserved.
//

#import "UIBaseViewController.h"
#import "FullTimeView.h"

@class UserInfo;

@interface ModifyUserInfoViewController : UIBaseViewController<FinishPickView>

/**
 *  初始化方法
 *
 *  @param userName    用户名
 *  @param iamgeString 头像URL
 *
 *  @return
 */
//-(instancetype)initWithUserName:(NSString *)userName ImageString:(NSString *)iamgeString;

/**
 *  传递用户信息初始化方法
 *
 *  @param userInfo 用户信息数据模型
 *
 *  @return
 */
-(instancetype)initWithUserInfo:(UserInfo *)userInfo;

@end
