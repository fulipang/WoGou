//
//  ModifyAccountOrPasswordViewController.m
//  HomeShopping
//
//  Created by sooncong on 16/1/9.
//  Copyright © 2016年 Administrator. All rights reserved.
//

#import "ModifyAccountOrPasswordViewController.h"

@implementation ModifyAccountOrPasswordViewController

#pragma mark - 生命周期

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    [self loadCostomViw];
}

#pragma mark - 自定义视图

/**
 *  装载自定义视图 总览
 */
- (void)loadCostomViw
{
    self.view.backgroundColor = UIColorFromRGB(WHITECOLOR);
    
    [self setNavigationBarLeftButtonImage:@"NavBar_Back"];
    
    [self setNavigationBarTitle:@"修改账号密码"];
    
    [self SetUpCustomView];
    
}

- (void)SetUpCustomView
{
 
    //画线
    UILabel * line_one        = [UILabel new];
    UILabel * line_two        = [UILabel new];
    UILabel * line_three      = [UILabel new];
    UILabel * line_four       = [UILabel new];
    UILabel * line_five       = [UILabel new];

    [self positionLineWithLine:line_one Index:1];
    [self positionLineWithLine:line_two Index:2];
    [self positionLineWithLine:line_three Index:3];
    [self positionLineWithLine:line_four Index:4];
    [self positionLineWithLine:line_five Index:5];

    //输入内容
    _oldTelphoneTextField     = [UITextField new];
    _confirmCodeTextField     = [UITextField new];
    _TelPhoneTextField        = [UITextField new];
    _PassWordTextField        = [UITextField new];
    _confirmPassWordTextField = [UITextField new];
    
    [self positionContentWithTitle:@"原手机号" TextField:_oldTelphoneTextField baseLine:line_one];
    [self positionContentWithTitle:@"验证码" TextField:_confirmCodeTextField baseLine:line_two];
    [self positionContentWithTitle:@"新手机号" TextField:_TelPhoneTextField baseLine:line_three];
    [self positionContentWithTitle:@"新密码" TextField:_PassWordTextField baseLine:line_four];
    [self positionContentWithTitle:@"确认密码" TextField:_confirmPassWordTextField baseLine:line_five];
    
    //按钮
    UIButton * commitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:commitButton];
    [commitButton makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(line_five.bottom).with.offset(GET_SCAlE_HEIGHT(20));
        make.centerX.mas_equalTo(self.view.centerX);
        make.size.mas_equalTo(CGSizeMake(GET_SCAlE_LENGTH(290), GET_SCAlE_HEIGHT(40)));
    }];
    [commitButton setTitle:@"提 交" forState:UIControlStateNormal];
    [commitButton.titleLabel setFont:[UIFont systemFontOfSize:LARGEFONTSIZE]];
    [commitButton setTitleColor:UIColorFromRGB(WHITECOLOR) forState:UIControlStateNormal];
    [commitButton setBackgroundImage:[UIImage imageNamed:@"mine_confrimReceiveandCommentButtonBG"] forState:UIControlStateNormal];
    [commitButton setBackgroundImage:[UIImage imageNamed:@"mine_confrimReceiveandCommentButtonBG"] forState:UIControlStateHighlighted];
    [commitButton addTarget:self action:@selector(commitButtonClicked) forControlEvents:UIControlEventTouchUpInside];

    _oldTelphoneTextField.delegate     = self;
    _confirmCodeTextField.delegate     = self;
    _TelPhoneTextField.delegate        = self;
    _PassWordTextField.delegate        = self;
    _confirmPassWordTextField.delegate = self;
    
}

/**
 *  配置输入栏方法
 *
 *  @param title     输入栏前标签内容
 *  @param textField 当前输入栏
 *  @param line      基准线
 */
- (void)positionContentWithTitle:(NSString *)title TextField:(UITextField *)textField baseLine:(UILabel *)line
{
    UILabel * titleLabel  = [UILabel new];
    [self.view addSubview:titleLabel];
    [titleLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(line.centerY).with.offset(GET_SCAlE_HEIGHT(-55/2.0));
        make.left.mas_equalTo(self.view.left).with.offset(GET_SCAlE_LENGTH(10));
    }];
    titleLabel.textColor = UIColorFromRGB(GRAYFONTCOLOR);
    titleLabel.font = [UIFont systemFontOfSize:TITLENAMEFONTSIZE];
    titleLabel.text = title;
    
    if (textField == nil) {
        return;
    }
    
    [self.view addSubview:textField];
    [textField makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.left).with.offset(GET_SCAlE_LENGTH(100));
        make.centerY.mas_equalTo(titleLabel.centerY);
        make.size.mas_equalTo(CGSizeMake(GET_SCAlE_LENGTH(200), GET_SCAlE_HEIGHT(40)));
    }];
    
    if (textField == _confirmCodeTextField) {
        UIButton * confirmCodeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.view addSubview:confirmCodeButton];
        [confirmCodeButton makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(textField.centerY);
            make.right.mas_equalTo(self.view.right).with.offset(GET_SCAlE_LENGTH(-15));
            make.size.mas_equalTo(CGSizeMake(GET_SCAlE_LENGTH(70), GET_SCAlE_HEIGHT(21)));
        }];
        [confirmCodeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        [confirmCodeButton.titleLabel setFont:[UIFont systemFontOfSize:NORMALFONTSIZE]];
        [confirmCodeButton setTitleColor:UIColorFromRGB(WHITECOLOR) forState:UIControlStateNormal];
        [confirmCodeButton setBackgroundImage:[UIImage imageNamed:@"register_ConfirmationCode_bg"] forState:UIControlStateNormal];
        [confirmCodeButton setBackgroundImage:[UIImage imageNamed:@"register_ConfirmationCode_bg"] forState:UIControlStateHighlighted];
        [confirmCodeButton addTarget:self action:@selector(confrimCodeButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        
        [textField updateConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(GET_SCAlE_HEIGHT(100), 40));
        }];
        
    }
}

/**
 *  画线方法
 *
 *  @param line      当前配置的线
 *  @param index     下标
 */
- (void)positionLineWithLine:(UILabel *)line Index:(NSInteger)index
{
    [self.view addSubview:line];
    [line makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.customNavigationBar.bottom).with.offset(GET_SCAlE_HEIGHT(55 * index));
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 0.5));
    }];
    line.backgroundColor = UIColorFromRGB(LINECOLOR);
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [_oldTelphoneTextField resignFirstResponder];
    [_confirmCodeTextField resignFirstResponder];
    [_TelPhoneTextField resignFirstResponder];
    [_PassWordTextField resignFirstResponder];
    [_confirmPassWordTextField resignFirstResponder];
    
    return YES;
}

#pragma mark - 网络

- (void)getConfirmCode
{
//    NSString * str = _TelPhoneTextField.text;
//    
//    NSLog(@"result = %@",str);
    if (_oldTelphoneTextField.text.length != 11) {
        NSString *showMsg = @"请输入正确的号码格式";
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"提示"
                                                        message: showMsg
                                                       delegate: self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles: nil, nil];
        
        [alert show];

    }
    
    if(![[Reachability reachabilityForInternetConnection]isReachable])
    {
        NSString *showMsg = @"请检查网络";
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"提示"
                                                        message: showMsg
                                                       delegate: self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles: nil, nil];
        
        [alert show];

        
        return;
    }
    
    [SVProgressHUD show];
    
    [[NetWorkSingleton sharedManager] getConfirmCodeWithTelNumber:_oldTelphoneTextField.text ConfirmCodeType:KConfirmTypeModifyPassWord SuccessBlock:^(id responseBody) {
        
        NSLog(@"result = %@",responseBody);
        
        if ([[responseBody objectForKey:@"head"][@"resultcode"] isEqualToString:@"0000"]) {
            [SVProgressHUD dismissWithSuccess:@"发送成功" afterDelay:1];
        }else{
            [SVProgressHUD dismiss];
        }
        
    } FailureBlock:^(NSString *error) {
        
        [SVProgressHUD dismissWithError:error afterDelay:1];
        
    }];
}

#pragma mark - 事件

-(void)leftButtonClicked
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)rightButtonClicked
{
    
}

- (void)confrimCodeButtonClicked
{
    [self getConfirmCode];
}

/**
 *  提交按钮点击事件
 */
- (void)commitButtonClicked
{
    NSLog(@"%s", __func__);
    
//    [self getConfirmCode];
}

///**
// *  点击获取验证码事件
// */
//- (void)confrimCodeButtonClicked
//{
//    NSLog(@"%s", __func__);
//    
//    [[NetWorkSingleton sharedManager] getConfirmCodeWithTelNumber:_TelPhoneTextField.text ConfirmCodeType:kConfirmTypeModifyPhoneNumber SuccessBlock:^(id responseBody) {
//        
//    } FailureBlock:^(NSString *error) {
//        
//    }];
//}

@end
