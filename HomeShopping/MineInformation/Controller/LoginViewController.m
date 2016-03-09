//
//  LoginViewController.m
//  HomeShopping
//
//  Created by sooncong on 16/1/7.
//  Copyright © 2016年 Administrator. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "ForgetPassWordViewController.h"
#import "UserInfoParser.h"

@implementation LoginViewController
{
    //输入基视图
    UIView * _inputBaseView;
    
    //账号输入框
    UITextField * _userNameTextField;
    
    //密码输入框
    UITextField * _passwordTextField;
}

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
    
    [self setNavigationBarTitle:@"登陆"];
    
    [self setNavigationBarRightButtonTitle:@"注册"];
    
    [self createIntupview];
    
    [self createBottomView];
    
}

/**
 *  创建输入基视图
 */
- (void)createIntupview
{
    //容器
    _inputBaseView = [UIView new];
    [self.view addSubview:_inputBaseView];
    [_inputBaseView makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.customNavigationBar.bottom).with.offset(GET_SCAlE_HEIGHT(35));
        make.centerX.mas_equalTo(self.view.centerX);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, GET_SCAlE_HEIGHT(90)));
    }];
    
    //线
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
    
    //用户名相关
    UIImageView * headImageView = [UIImageView new];
    [_inputBaseView addSubview:headImageView];
    [headImageView makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(line_one.centerY).with.offset(GET_SCAlE_HEIGHT(-45/2.0));
        make.left.mas_equalTo(line_one.left);
        make.size.mas_equalTo(CGSizeMake(GET_SCAlE_LENGTH(25), GET_SCAlE_LENGTH(25)));
    }];
    headImageView.image = [UIImage imageNamed:@"login_user"];
    
    _userNameTextField = [[UITextField alloc] init];
    [_inputBaseView addSubview:_userNameTextField];
    [_userNameTextField makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(headImageView.centerY);
        make.left.mas_equalTo(headImageView.right).with.offset(GET_SCAlE_LENGTH(8));
        make.right.mas_equalTo(self.view.right).with.offset(-5);
        make.height.mas_equalTo(@(GET_SCAlE_HEIGHT(40)));
    }];
    _userNameTextField.placeholder = @"用户名";
    _userNameTextField.delegate = self;
    
    //密码相关
    UIImageView * passWordImageView = [UIImageView new];
    [_inputBaseView addSubview:passWordImageView];
    [passWordImageView makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(line_one.centerY).with.offset(GET_SCAlE_HEIGHT(45/2.0));
        make.left.mas_equalTo(line_one.left);
        make.size.mas_equalTo(CGSizeMake(GET_SCAlE_LENGTH(25), GET_SCAlE_LENGTH(25)));
    }];
    passWordImageView.image = [UIImage imageNamed:@"login_pwd_symbol"];
    
    _passwordTextField = [[UITextField alloc] init];
    [_inputBaseView addSubview:_passwordTextField];
    [_passwordTextField makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(passWordImageView.centerY);
        make.left.mas_equalTo(passWordImageView.right).with.offset(GET_SCAlE_LENGTH(8));
        make.right.mas_equalTo(self.view.right).with.offset(-5);
        make.height.mas_equalTo(@(GET_SCAlE_HEIGHT(40)));
    }];
    _passwordTextField.placeholder = @"密码";
    _passwordTextField.delegate = self;
    _passwordTextField.secureTextEntry = YES;
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
    
    UIButton * forgetButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:forgetButton];
    [forgetButton makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(commitButton.bottom).with.offset(GET_SCAlE_HEIGHT(10));
        make.left.mas_equalTo(commitButton.left);
        make.size.mas_equalTo(CGSizeMake(GET_SCAlE_LENGTH(60), GET_SCAlE_HEIGHT(20)));
    }];
    [forgetButton setTitle:@"忘记密码" forState:UIControlStateNormal];
    [forgetButton.titleLabel setFont:[UIFont systemFontOfSize:NORMALFONTSIZE]];
    [forgetButton setTitleColor:UIColorFromRGB(GRAYFONTCOLOR) forState:UIControlStateNormal];
    [forgetButton addTarget:self action:@selector(forgetButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    
}

#pragma mark - UITextFieldDelegat

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == _userNameTextField) {
        return ([self isPureInt:string] || [string isEqualToString:@""])?YES:NO;
    }else{
        return YES;
    }
}

#pragma mark - 事件

-(void)leftButtonClicked
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

-(void)rightButtonClicked
{
    NSLog(@"%s", __func__);
    
    RegisterViewController * VC = [[RegisterViewController alloc] initWithApperType:kApperTypePush];
    [self.navigationController pushViewController:VC animated:YES];
}

/**
 *  登陆按钮点击事件
 */
- (void)commitButtonClicked
{
    NSLog(@"%s", __func__);
    
    [self loginUser];
}

/**
 *  忘记密码点击事件
 */
- (void)forgetButtonClicked
{
//    NSLog(@"%s", __func__);
    ForgetPassWordViewController * VC = [[ForgetPassWordViewController alloc] init];
    [self.navigationController pushViewController:VC animated:YES];
}

#pragma mark - 网络

/**
 *  登陆请求方法
 */
- (void)loginUser
{
    if(![[Reachability reachabilityForInternetConnection]isReachable])
    {
        return;
    }
    
    [SVProgressHUD show];
    
    [[NetWorkSingleton sharedManager] LoginUserWithPhoneNumber:_userNameTextField.text PassWord:_passwordTextField.text SuccessBlock:^(id responseBody) {
        
        NSLog(@"result = %@",responseBody);
        
        if ([[responseBody objectForKey:@"head"][@"resultcode"] isEqualToString:@"0000"]) {
            UserInfoParser * parser = [[UserInfoParser alloc] initWithDictionary:responseBody];
            [[AppInformationSingleton shareAppInfomationSingleton] setLoginCode:parser.userInfo.ut];
            [[AppInformationSingleton shareAppInfomationSingleton] setUserID:parser.userInfo.userid];
            [SVProgressHUD dismissWithSuccess:@"登录成功" afterDelay:1];
            [self dismissViewControllerAnimated:YES completion:^{
                
            }];
        }else{
            [SVProgressHUD dismissWithError:responseBody[@"head"][@"resultdesc"] afterDelay:1];
        }
        
    } FailureBlock:^(NSString *error) {
        
    }];
}


@end
