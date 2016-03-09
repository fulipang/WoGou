//
//  ModifyAccountOrPasswordViewController.h
//  HomeShopping
//
//  Created by sooncong on 16/1/9.
//  Copyright © 2016年 Administrator. All rights reserved.
//

#import "UIBaseViewController.h"

@interface ModifyAccountOrPasswordViewController : UIBaseViewController <UITextFieldDelegate>

/**
 *  原手机号码输入框
 */
@property (nonatomic, strong) UITextField * oldTelphoneTextField;

/**
 *  验证码输入框
 */
@property (nonatomic, strong) UITextField * confirmCodeTextField;

/**
 *  新手机号码输入框
 */
@property (nonatomic, strong) UITextField * TelPhoneTextField;

/**
 *  新密码输入框
 */
@property (nonatomic, strong) UITextField * PassWordTextField;

/**
 *  确认密码输入框
 */
@property (nonatomic, strong) UITextField * confirmPassWordTextField;

@end
