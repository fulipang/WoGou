//
//  AdviceFeedBackViewController.h
//  HomeShopping
//
//  Created by sooncong on 16/1/9.
//  Copyright © 2016年 Administrator. All rights reserved.
//

#import "UIBaseViewController.h"

@interface AdviceFeedBackViewController : UIBaseViewController

/**
 *  标题输入框
 */
@property (nonatomic, strong) UITextField * titleTextField;

/**
 *  意见内容输入框
 */
@property (nonatomic, strong) UITextView * contentTextView;

/**
 *  联系方式输入框
 */
@property (nonatomic, strong) UITextField * contactMethodTextField;

@end
