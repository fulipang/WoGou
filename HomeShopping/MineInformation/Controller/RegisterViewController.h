//
//  RegisterViewController.h
//  HomeShopping
//
//  Created by sooncong on 16/1/7.
//  Copyright © 2016年 Administrator. All rights reserved.
//

#import "UIBaseViewController.h"

@interface RegisterViewController : UIBaseViewController<UITextFieldDelegate>

/**
 *  初始化方法
 *
 *  @param apperType 弹出类型
 *
 *  @return
 */
-(instancetype)initWithApperType:(SCApperType)apperType;

@end
