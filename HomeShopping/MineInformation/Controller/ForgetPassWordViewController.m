//
//  ForgetPassWordViewController.m
//  HomeShopping
//
//  Created by sooncong on 16/1/8.
//  Copyright © 2016年 Administrator. All rights reserved.
//

#import "ForgetPassWordViewController.h"

@implementation ForgetPassWordViewController
{
    UIView * _inputBaseView;
    
    UITextField * _phoneTextField;
    UITextField * _confirmCodeTextField;
    UITextField * _newPassWordTextField;

    NSTimer * _timer;
    NSInteger _count;
    UIButton * _confirmCodeButton;
}

#pragma mark - 生命周期

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [_timer invalidate];
    _timer = nil;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    _count = 30;
    
    [self loadCostomViw];
    
//    [self setTimer];
}

#pragma mark - 自定义视图

/**
 *  装载自定义视图 总览
 */
- (void)loadCostomViw
{
    self.view.backgroundColor = UIColorFromRGB(WHITECOLOR);
    
    [self setNavigationBarLeftButtonImage:@"NavBar_Back"];
    
    [self setNavigationBarTitle:@"忘记密码"];
    
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
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, GET_SCAlE_HEIGHT(135)));
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

    
    //输入相关
    _phoneTextField       = [UITextField new];
    _confirmCodeTextField = [UITextField new];
    _newPassWordTextField = [UITextField new];
    
    [self setTextFieldUp:_phoneTextField TextfieldDown:_confirmCodeTextField WithLine:line_one ImageUp:[UIImage imageNamed:@"login_phone"] ImageDown:[UIImage imageNamed:@"login_password"] PlaceHolderUp:@"输入手机号" placeHolderDown:@"输入验证码"];
    
    [self setTextFieldUp:_newPassWordTextField TextfieldDown:nil WithLine:line_botton ImageUp:[UIImage imageNamed:@"login_password"] ImageDown:nil PlaceHolderUp:@"输入新密码" placeHolderDown:nil];
    
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
        make.left.mas_equalTo(_inputBaseView.left).with.offset(GET_SCAlE_LENGTH(15));
        make.size.mas_equalTo(CGSizeMake(imageUp.size.width, imageUp.size.height));
    }];
    headImageView.image = imageUp;
    
    [_inputBaseView addSubview:textFieldUp];
    [textFieldUp makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(headImageView.centerY);
        make.left.mas_equalTo(headImageView.right).with.offset(GET_SCAlE_LENGTH(8));
        if (textFieldUp == _phoneTextField) {
            make.width.mas_equalTo(@(GET_SCAlE_LENGTH(190)));
        }else{
            make.right.mas_equalTo(self.view.right).with.offset(-5);
        }
        make.height.mas_equalTo(@(GET_SCAlE_HEIGHT(40)));
    }];
    textFieldUp.placeholder = textUp;
    textFieldUp.delegate = self;
    textFieldUp.font = [UIFont systemFontOfSize:TITLENAMEFONTSIZE];
    
    if (textFieldUp == _phoneTextField) {
        _confirmCodeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_inputBaseView addSubview:_confirmCodeButton];
        [_confirmCodeButton makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(textFieldUp.centerY);
            make.right.mas_equalTo(_inputBaseView.right).with.offset(GET_SCAlE_LENGTH(-15));
            make.size.mas_equalTo(CGSizeMake(GET_SCAlE_LENGTH(90), GET_SCAlE_HEIGHT(21)));
        }];
        [_confirmCodeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_confirmCodeButton.titleLabel setFont:[UIFont systemFontOfSize:NORMALFONTSIZE]];
        [_confirmCodeButton setTitleColor:UIColorFromRGB(WHITECOLOR) forState:UIControlStateNormal];
        [_confirmCodeButton setBackgroundImage:[UIImage imageNamed:@"register_ConfirmationCode_bg"] forState:UIControlStateNormal];
        [_confirmCodeButton setBackgroundImage:[UIImage imageNamed:@"register_ConfirmationCode_bg"] forState:UIControlStateHighlighted];
        [_confirmCodeButton addTarget:self action:@selector(ConfirmCodeButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    if (textFiledDown == nil) {
        return;
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
    [commitButton setTitle:@"提 交" forState:UIControlStateNormal];
    [commitButton.titleLabel setFont:[UIFont systemFontOfSize:TITLENAMEFONTSIZE]];
    [commitButton setTitleColor:UIColorFromRGB(WHITECOLOR) forState:UIControlStateNormal];
    [commitButton setBackgroundImage:[UIImage imageNamed:@"register_button_bg"] forState:UIControlStateNormal];
    [commitButton setBackgroundImage:[UIImage imageNamed:@"register_button_bg"] forState:UIControlStateHighlighted];
    [commitButton addTarget:self action:@selector(commitButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    
}

#pragma mark - UITextFieldDelegate

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [_phoneTextField resignFirstResponder];
    [_confirmCodeTextField resignFirstResponder];
    [_newPassWordTextField resignFirstResponder];
    
    return YES;
}

#pragma mark - 定时器
- (void) setTimer
{
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

-(void)leftButtonClicked
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)rightButtonClicked
{
    
}

- (void)commitButtonClicked
{
//    NSLog(@"%s", __func__);
    [self findPassWrod];
}

- (void)ConfirmCodeButtonClicked
{
    [self getConfirmCode];
}

#pragma mark - 网络

- (void)getConfirmCode
{
    if (_phoneTextField.text.length != 11) {
        
        NSString *showMsg = @"请输入正确地号码格式";
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"提示"
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
    
    [self setTimer];

    [[NetWorkSingleton sharedManager] getConfirmCodeWithTelNumber:_phoneTextField.text ConfirmCodeType:kConfirmTypeGetBackPassWord SuccessBlock:^(id responseBody) {
        
        NSLog(@"code = %@",responseBody);
        
        NSString * desc = responseBody[@"head"][@"resultdesc"];
        NSString * code = responseBody[@"head"][@"resultcode"];
        
        if ([code isEqualToString:@"0000"]) {
            [SVProgressHUD dismissWithSuccess:@"发送验证码成功" afterDelay:1];
        }else{
            [SVProgressHUD dismissWithError:desc afterDelay:1];
        }
        
    } FailureBlock:^(NSString *error) {
       
        [SVProgressHUD dismiss];
    }];
}

- (void)findPassWrod
{
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
    
    [[NetWorkSingleton sharedManager] getBackPassWordWithPhoneNumber:_phoneTextField.text ConfirmCode:_confirmCodeTextField.text NewPassWord:_newPassWordTextField.text SuccessBlock:^(id responseBody) {
        
        NSLog(@"code = %@",responseBody);
        
        NSString * desc = responseBody[@"head"][@"resultdesc"];
        NSString * code = responseBody[@"head"][@"resultcode"];
        
        if ([code isEqualToString:@"0000"]) {
            [SVProgressHUD dismissWithSuccess:@"修改成功" afterDelay:1];
            [self leftButtonClicked];
        }else{
            [SVProgressHUD dismissWithError:desc afterDelay:1];
        }
        
    } FailureBlock:^(NSString *error) {
        
        [SVProgressHUD dismiss];
    }];
}

@end
