//
//  RegisterViewController.m
//  HomeShopping
//
//  Created by sooncong on 16/1/7.
//  Copyright © 2016年 Administrator. All rights reserved.
//

#import "RegisterViewController.h"
#import "ProtocolWebViewController.h"

@implementation RegisterViewController
{
    //输入基视图
    UIView * _inputBaseView;
    
    //记录弹出类型
    SCApperType _apperType;
    
    //用户名
    UITextField * _userNameTextField;
    //验证码
    UITextField * _confirmationCode;
    //密码
    UITextField * _passWordTextField;
    //确认密码
    UITextField * _confirmPassWordTextField;
    
    //勾选按钮
    UIButton * _selectedButton;
    
    //定时器相关
    NSTimer * _timer;
    NSInteger _count;
    UIButton * _confirmCodeButton;
    
}

-(instancetype)initWithApperType:(SCApperType)apperType
{
    self = [super init];
    
    if (self) {
        _apperType = apperType;
    }
    
    return self;
}

#pragma mark - 生命周期

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [_timer invalidate];
    _timer = nil;
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
    
    [self setNavigationBarTitle:@"注册"];
    
    [self createIntupview];
    
    [self createBottomView];
    
}

/**
 *  创建输入基视图
 */
- (void)createIntupview
{
    _inputBaseView = [UIView new];
    [self.view addSubview:_inputBaseView];
    [_inputBaseView makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.customNavigationBar.bottom).with.offset(GET_SCAlE_HEIGHT(35));
        make.centerX.mas_equalTo(self.view.centerX);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, GET_SCAlE_HEIGHT(180)));
    }];
    
    UILabel * line_top = [UILabel new];
    [_inputBaseView addSubview:line_top];
    [line_top makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_inputBaseView.top);
        make.centerX.mas_equalTo(_inputBaseView.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 0.5));
    }];
    line_top.backgroundColor = UIColorFromRGB(LINECOLOR);
    
    UILabel * line_botton = [UILabel new];
    [_inputBaseView addSubview:line_botton];
    [line_botton makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(_inputBaseView.mas_bottom);
        make.centerX.mas_equalTo(_inputBaseView.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 0.5));
    }];
    line_botton.backgroundColor = UIColorFromRGB(LINECOLOR);
    
    UILabel * line_one = [UILabel new];
    [_inputBaseView addSubview:line_one];
    [line_one makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_inputBaseView.top).with.offset(GET_SCAlE_HEIGHT(45));
        make.right.mas_equalTo(_inputBaseView.right);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - GET_SCAlE_LENGTH(15), 0.5));
    }];
    line_one.backgroundColor = UIColorFromRGB(LINECOLOR);
    
    UILabel * line_two = [UILabel new];
    [_inputBaseView addSubview:line_two];
    [line_two makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_inputBaseView.top).with.offset(GET_SCAlE_HEIGHT(90));
        make.right.mas_equalTo(_inputBaseView.right);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - GET_SCAlE_LENGTH(15), 0.5));
    }];
    line_two.backgroundColor = UIColorFromRGB(LINECOLOR);
    
    UILabel * line_three = [UILabel new];
    [_inputBaseView addSubview:line_three];
    [line_three makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_inputBaseView.top).with.offset(GET_SCAlE_HEIGHT(135));
        make.right.mas_equalTo(_inputBaseView.right);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - GET_SCAlE_LENGTH(15), 0.5));
    }];
    line_three.backgroundColor = UIColorFromRGB(LINECOLOR);
    
    //输入相关
    _userNameTextField        = [UITextField new];
    _confirmationCode         = [UITextField new];
    _passWordTextField        = [UITextField new];
    _confirmPassWordTextField = [UITextField new];
    
    [self setTextFieldUp:_userNameTextField TextfieldDown:_confirmationCode WithLine:line_one ImageUp:[UIImage imageNamed:@"login_phone"] ImageDown:[UIImage imageNamed:@"login_key"]PlaceHolderUp:@"输入手机号" placeHolderDown:@"输入验证码"];
    
    [self setTextFieldUp:_passWordTextField TextfieldDown:_confirmPassWordTextField WithLine:line_three ImageUp:[UIImage imageNamed:@"login_password"] ImageDown:[UIImage imageNamed:@"login_password"] PlaceHolderUp:@"请输入6-16位数字或字母" placeHolderDown:@"重新输入6-16位数字或字母"];
    
}

/**
 *  两行一组配置输入框和图像
 *
 *  @param textFieldUp   上面输入框
 *  @param textFiledDown 下面输入框
 *  @param line          基准线
 *  @param imageUp       上面图像
 *  @param imageDown     下面图像
 *  @param textUp        上面输入框placeholder文字
 *  @param textDown      下面输入框placeholder文字
 */
- (void)setTextFieldUp:(UITextField *)textFieldUp TextfieldDown:(UITextField *)textFiledDown WithLine:(UILabel *)line ImageUp:(UIImage *)imageUp ImageDown:(UIImage *)imageDown PlaceHolderUp:(NSString *)textUp placeHolderDown:(NSString *)textDown
{
    
    UIImageView * headImageView = [UIImageView new];
    [_inputBaseView addSubview:headImageView];
    [headImageView makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(line.centerY).with.offset(GET_SCAlE_HEIGHT(-45/2.0));
        make.left.mas_equalTo(line.left);
        make.size.mas_equalTo(CGSizeMake(imageUp.size.width, imageUp.size.height));
    }];
    headImageView.image = imageUp;
    
    [_inputBaseView addSubview:textFieldUp];
    [textFieldUp makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(headImageView.centerY);
        make.left.mas_equalTo(headImageView.right).with.offset(GET_SCAlE_LENGTH(8));
        if (textFieldUp == _userNameTextField) {
            make.width.mas_equalTo(@(GET_SCAlE_LENGTH(190)));
        }else{
            make.right.mas_equalTo(self.view.right).with.offset(-5);
        }
        make.height.mas_equalTo(@(GET_SCAlE_HEIGHT(40)));
    }];
    textFieldUp.placeholder = textUp;
    textFieldUp.delegate = self;
    textFieldUp.font = [UIFont systemFontOfSize:TITLENAMEFONTSIZE];
    
    if (textFieldUp == _userNameTextField) {
        _confirmCodeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_inputBaseView addSubview:_confirmCodeButton];
        [_confirmCodeButton makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(textFieldUp.centerY);
            make.right.mas_equalTo(_inputBaseView.right).with.offset(GET_SCAlE_LENGTH(-15));
            make.size.mas_equalTo(CGSizeMake(GET_SCAlE_LENGTH(70), GET_SCAlE_HEIGHT(21)));
        }];
        [_confirmCodeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_confirmCodeButton.titleLabel setFont:[UIFont systemFontOfSize:NORMALFONTSIZE]];
        [_confirmCodeButton setTitleColor:UIColorFromRGB(WHITECOLOR) forState:UIControlStateNormal];
        [_confirmCodeButton setBackgroundImage:[UIImage imageNamed:@"register_ConfirmationCode_bg"] forState:UIControlStateNormal];
        [_confirmCodeButton setBackgroundImage:[UIImage imageNamed:@"register_ConfirmationCode_bg"] forState:UIControlStateHighlighted];
        [_confirmCodeButton addTarget:self action:@selector(confrimCodeButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    UIImageView * passWordImageView = [UIImageView new];
    [_inputBaseView addSubview:passWordImageView];
    [passWordImageView makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(line.centerY).with.offset(GET_SCAlE_HEIGHT(45/2.0));
        make.left.mas_equalTo(line.left);
        make.size.mas_equalTo(CGSizeMake(imageDown.size.width, imageDown.size.height));
    }];
    passWordImageView.image = imageDown;
    
    [_inputBaseView addSubview:textFiledDown];
    [textFiledDown makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(passWordImageView.centerY);
        make.left.mas_equalTo(passWordImageView.right).with.offset(GET_SCAlE_LENGTH(8));
        make.right.mas_equalTo(self.view.right).with.offset(-5);
        make.height.mas_equalTo(@(GET_SCAlE_HEIGHT(40)));
    }];
    textFiledDown.placeholder = textDown;
    textFiledDown.delegate = self;
    textFiledDown.font = [UIFont systemFontOfSize:TITLENAMEFONTSIZE];
}

- (void)createBottomView
{
    UIButton * commitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:commitButton];
    [commitButton makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_inputBaseView.bottom).with.offset(GET_SCAlE_HEIGHT(25));
        make.centerX.mas_equalTo(self.view.centerX);
        make.size.mas_equalTo(CGSizeMake(GET_SCAlE_LENGTH(290), GET_SCAlE_HEIGHT(40)));
    }];
    [commitButton setTitle:@"登 陆" forState:UIControlStateNormal];
    [commitButton.titleLabel setFont:[UIFont systemFontOfSize:TITLENAMEFONTSIZE]];
    [commitButton setTitleColor:UIColorFromRGB(WHITECOLOR) forState:UIControlStateNormal];
    [commitButton setBackgroundImage:[UIImage imageNamed:@"register_button_bg"] forState:UIControlStateNormal];
    [commitButton setBackgroundImage:[UIImage imageNamed:@"register_button_bg"] forState:UIControlStateHighlighted];
    [commitButton addTarget:self action:@selector(commitButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    
    _selectedButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_selectedButton setImage:[UIImage imageNamed:@"selected"] forState:UIControlStateNormal];
    [_selectedButton setImage:[UIImage imageNamed:@"selected_d"] forState:UIControlStateSelected];
    [self.view addSubview:_selectedButton];
    [_selectedButton makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(commitButton.bottom).with.offset(GET_SCAlE_HEIGHT(10));
        make.left.mas_equalTo(commitButton.left);
        make.size.mas_equalTo(CGSizeMake(GET_SCAlE_LENGTH(15), GET_SCAlE_LENGTH(15)));
    }];
//    selectedButton.backgroundColor = [UIColor orangeColor];
    [_selectedButton addTarget:self action:@selector(selectionButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    _selectedButton.selected = YES;
    
    NSString * protocolString = @"我已看过并同意《购窝网》协议" ;
    CGFloat protocolWidth = [self sizeForText:protocolString WithMaxSize:CGSizeMake(1000, GET_SCAlE_HEIGHT(20)) AndWithFontSize:12].width;
    UIButton * protocolButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:protocolButton];
    [protocolButton makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_selectedButton.centerY);
        make.left.mas_equalTo(_selectedButton.right).with.offset(GET_SCAlE_LENGTH(5));
        make.size.mas_equalTo(CGSizeMake(protocolWidth, GET_SCAlE_HEIGHT(20)));
    }];
    [protocolButton setTitle:protocolString forState:UIControlStateNormal];
    [protocolButton.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [protocolButton setTitleColor:UIColorFromRGB(GRAYFONTCOLOR) forState:UIControlStateNormal];
    [protocolButton addTarget:self action:@selector(protocolTaped) forControlEvents:UIControlEventTouchUpInside];
    
    
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [_userNameTextField resignFirstResponder];
    [_confirmationCode resignFirstResponder];
    [_passWordTextField resignFirstResponder];
    [_confirmPassWordTextField resignFirstResponder];
    
    return YES;
}

#pragma mark - 定时器
- (void) setTimer
{
    _count = 30;
    
    _timer = [NSTimer scheduledTimerWithTimeInterval: 1.0 target: self selector: @selector(timerSelect) userInfo: nil repeats: YES];
    _confirmCodeButton.enabled = NO;
    [[NSRunLoop mainRunLoop] addTimer: _timer forMode: NSRunLoopCommonModes];
}

- (void) timerSelect
{
    _count--;
    
    [_confirmCodeButton setTitle:[NSString stringWithFormat: @"获取验证码(%ld)", (long)_count] forState:
     UIControlStateDisabled];
    
    [_confirmCodeButton updateConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(_inputBaseView.right).with.offset(GET_SCAlE_LENGTH(-5));
        make.size.mas_equalTo(CGSizeMake(GET_SCAlE_LENGTH(120), GET_SCAlE_HEIGHT(21)));
    }];
    
    if (_count == 0)
    {
        _count = 30;
        [_timer invalidate];
        _confirmCodeButton.enabled = YES;
        
        [_confirmCodeButton setTitle: @"获取验证码" forState: UIControlStateNormal];
        [_confirmCodeButton updateConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(_inputBaseView.right).with.offset(GET_SCAlE_LENGTH(-15));
            make.size.mas_equalTo(CGSizeMake(GET_SCAlE_LENGTH(90), GET_SCAlE_HEIGHT(21)));
        }];
    }
}


#pragma mark - 事件

/**
 *  提交点击事件
 */
- (void)commitButtonClicked
{
    NSLog(@"%s", __func__);
    [self registUser];
}

/**
 *  查看协议事件
 */
- (void)protocolTaped
{
    ProtocolWebViewController * VC = [[ProtocolWebViewController alloc] initWithTitle:@"用户注册协议" functionID:@"registintro"];
    [self.navigationController pushViewController:VC animated:YES];
    _selectedButton.selected = YES;
}

/**
 *  已阅读勾选按钮点击事件
 */
- (void)selectionButtonClicked
{
    NSLog(@"%s", __func__);
    _selectedButton.selected = !_selectedButton.selected;
}

-(void)leftButtonClicked
{
    
    switch (_apperType) {
        case kApperTypePush: {
            [self.navigationController popViewControllerAnimated:YES];
            break;
        }
        case kApperTypePresent: {
            [self dismissViewControllerAnimated:YES completion:^{}];
            break;
        }
    }
}

-(void)rightButtonClicked
{
    
}

- (void)confrimCodeButtonClicked
{
    [self getConfirmCode];
}

#pragma mark - 网络

/**
 *  获取验证码
 */
- (void)getConfirmCode
{
    if (_userNameTextField.text.length != 11) {
        NSString *showMsg = @"请输入正确的号码格式";
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @""
                                                        message: showMsg
                                                       delegate: self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles: nil, nil];
        
        [alert show];
        return;
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
    
    [[NetWorkSingleton sharedManager] getConfirmCodeWithTelNumber:_userNameTextField.text ConfirmCodeType:kConfirmTypeRegister SuccessBlock:^(id responseBody) {
        
        if ([responseBody[@"head"][@"resultcode"] isEqualToString:@"0000"]) {
            [SVProgressHUD dismissWithSuccess:@"发送成功" afterDelay:1];
            
            [self setTimer];
        
        }else{
            NSString * desc = responseBody[@"head"][@"resultdesc"];
            [SVProgressHUD dismissWithError:desc afterDelay:1];
        }
        
        
    } FailureBlock:^(NSString *error) {
        
        [SVProgressHUD dismissWithError:error afterDelay:1];
    }];
}

/**
 *  注册用户
 */
- (void)registUser
{
    if (_passWordTextField.text.length <6 || _passWordTextField.text.length > 16) {
        NSString *showMsg = @"提示";
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"请输入正确的密码格式"
                                                        message: showMsg
                                                       delegate: self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles: nil, nil];
        
        [alert show];
        return;

    }
    
    else if (_confirmPassWordTextField.text.length <6 || _confirmPassWordTextField.text.length > 6) {
        NSString *showMsg = @"提示";
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"请输入正确的密码格式"
                                                        message: showMsg
                                                       delegate: self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles: nil, nil];
        
        [alert show];
        return;
        
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
    
    [[NetWorkSingleton sharedManager] registerUserWithPhoneNumber:_userNameTextField.text ConfirmCode:_confirmationCode.text PassWord:_passWordTextField.text SuccessBlock:^(id responseBody) {
        
        if ([responseBody[@"head"][@"resultcode"] isEqualToString:@"0000"]) {
            [SVProgressHUD dismissWithSuccess:@"注册成功" afterDelay:1];
            
            [[AppInformationSingleton shareAppInfomationSingleton] setUserID:responseBody[@"body"][@"userid"]];
            [[AppInformationSingleton shareAppInfomationSingleton] setLoginCode:responseBody[@"body"][@"ut"]];

            [self leftButtonClicked];
        }else{
            NSString * desc = responseBody[@"head"][@"resultdesc"];
            [SVProgressHUD dismissWithError:desc afterDelay:1];
        }
        
    } FailureBlock:^(NSString *error) {
        [SVProgressHUD dismiss];
    }];
}



@end
