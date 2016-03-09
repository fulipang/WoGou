//
//  ModifyAddrViewController.h
//  HomeShopping
//
//  Created by sooncong on 16/1/8.
//  Copyright © 2016年 Administrator. All rights reserved.
//

#import "UIBaseViewController.h"
@class Addresse;
@interface ModifyAddrViewController : UIBaseViewController<UITextFieldDelegate,UITextViewDelegate>

/**
 *  姓名输入栏
 */
@property (nonatomic, strong) UITextField * NameTextField;

/**
 *  电话输入栏
 */
@property (nonatomic, strong) UITextField * TelPhoneTextField;

/**
 *  邮编输入栏
 */
@property (nonatomic, strong) UITextField * PostCodeTextField;

/**
 *  区域输入栏
 */
@property (nonatomic, strong) UITextField * regionTextField;

/**
 *  详细地址输入栏
 */
@property (nonatomic, strong) UITextView * detailTextView;

@property (nonatomic, readwrite, assign) BOOL defaultAddress;

/**
 *  传值初始化方法
 *
 *  @param navTitle 导航标题
 *
 *  @return
 */
-(instancetype)initWithWithTitle:(NSString *)navTitle;

/// 修改地址初始方法
-(instancetype)initWithWithAddressID:(NSString *)addressID;


/// 最好用这个:修改地址初始化方法
- (instancetype)initForUpdateAddress:(Addresse*)address selected:(BOOL)selected;

@end








