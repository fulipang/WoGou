//
//  AdviceFeedBackViewController.m
//  HomeShopping
//
//  Created by sooncong on 16/1/9.
//  Copyright © 2016年 Administrator. All rights reserved.
//

#import "AdviceFeedBackViewController.h"

@interface AdviceFeedBackViewController ()<UITextViewDelegate>
@property (nonatomic, readwrite, strong) UILabel *placehoderLabel;
@end

@implementation AdviceFeedBackViewController

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
    
    [self setNavigationBarTitle:@"意见反馈"];
    
    [self setUpItem];
}

- (UILabel*)placehoderLabel {
    if (!_placehoderLabel) {
        _placehoderLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 200, 30)];
    }
    return _placehoderLabel;
}

- (void)setUpItem
{
    UILabel * line_one = [UILabel new];
    [self.view addSubview:line_one];
    [line_one makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.customNavigationBar.mas_bottom).with.offset(GET_SCAlE_HEIGHT(55));
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 0.5));
    }];
    line_one.backgroundColor = UIColorFromRGB(LINECOLOR);
    
    UILabel * line_two = [UILabel new];
    [self.view addSubview:line_two];
    [line_two makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(line_one.mas_bottom).with.offset(GET_SCAlE_HEIGHT(150));
        make.centerX.mas_equalTo(line_one.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 0.5));
    }];
    line_two.backgroundColor = UIColorFromRGB(LINECOLOR);
    
    UILabel * line_three = [UILabel new];
    [self.view addSubview:line_three];
    [line_three makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(line_two.mas_bottom).with.offset(GET_SCAlE_HEIGHT(55));
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 0.5));
    }];
    line_three.backgroundColor = UIColorFromRGB(LINECOLOR);
    
    _titleTextField         = [UITextField new];
    _contactMethodTextField = [UITextField new];
    _contentTextView        = [UITextView new];
    
    //配置标题输入框
    [self positionContentWithTitle:@"标题" TextField:_titleTextField baseLine:line_one];
    
    //配置内容输入框
    [self.view addSubview:_contentTextView];
    [_contentTextView makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.left).with.offset(GET_SCAlE_HEIGHT(5));
        make.top.mas_equalTo(line_one.bottom).with.offset(GET_SCAlE_HEIGHT(15));
        make.bottom.mas_equalTo(line_two.top).with.offset(GET_SCAlE_HEIGHT(-15));
        make.right.mas_equalTo(self.view.right).with.offset(GET_SCAlE_LENGTH(-5));
    }];
    self.placehoderLabel.text = @"请输入你的反馈意见";
    _contentTextView.font = [UIFont systemFontOfSize:TITLENAMEFONTSIZE];
    self.placehoderLabel.textColor = UIColorFromRGB(GRAYFONTCOLOR);
    [_contentTextView addSubview:self.placehoderLabel];
    _contentTextView.delegate = self;
    
    
    //配置联系方式
    [self.view addSubview:_contactMethodTextField];
    [_contactMethodTextField makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.left).with.offset(GET_SCAlE_LENGTH(10));
        make.right.mas_equalTo(self.view.right).with.offset(GET_SCAlE_LENGTH(-10));
        make.top.mas_equalTo(line_two.bottom).with.offset(GET_SCAlE_HEIGHT(5));
        make.bottom.mas_equalTo(line_three.bottom).with.offset(GET_SCAlE_HEIGHT(-5));
    }];
    _contactMethodTextField.placeholder = @"请输入你的邮箱地址(选填)";
    _contactMethodTextField.font = [UIFont systemFontOfSize:TITLENAMEFONTSIZE];
    //    _contactMethodTextField.textColor = UIColorFromRGB(GRAYFONTCOLOR);
    
    UIButton * sendButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:sendButton];
    [sendButton makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.centerX);
        make.top.mas_equalTo(line_three.bottom).with.offset(GET_SCAlE_HEIGHT(20));
        make.size.mas_equalTo(CGSizeMake(GET_SCAlE_LENGTH(290), GET_SCAlE_HEIGHT(40)));
    }];
    [sendButton setTitle:@"发 送" forState:UIControlStateNormal];
    [sendButton.titleLabel setFont:[UIFont systemFontOfSize:LARGEFONTSIZE]];
    [sendButton setTitleColor:UIColorFromRGB(WHITECOLOR) forState:UIControlStateNormal];
    sendButton.backgroundColor = [UIColor colorWithRed:251/255.0 green:151/255.0 blue:49/255.0 alpha:1];
    sendButton.layer.cornerRadius = 8;
    sendButton.clipsToBounds = YES;
    [sendButton addTarget:self action:@selector(sendButtonClicked) forControlEvents:UIControlEventTouchUpInside];
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
        make.left.mas_equalTo(titleLabel.right).with.offset(GET_SCAlE_LENGTH(5));
        make.centerY.mas_equalTo(titleLabel.centerY);
        make.size.mas_equalTo(CGSizeMake(GET_SCAlE_LENGTH(200), GET_SCAlE_HEIGHT(40)));
    }];
}


#pragma mark UITextViewDelegate
- (void)textViewDidBeginEditing:(UITextView *)textView {
    if (textView == _contentTextView) {
        self.placehoderLabel.hidden = YES;
    }
}


- (void)textViewDidEndEditing:(UITextView *)textView {
    if ((textView.text.length == 0 || !textView.text) && textView == _contentTextView) {
        self.placehoderLabel.hidden = NO;
    }
}

#pragma mark - 事件

-(void)leftButtonClicked
{
    [self.navigationController popViewControllerAnimated:YES];
}

/**
 *  发送按钮点击事件
 */
- (void)sendButtonClicked
{
    [self sendFeedBackRequest];
}

#pragma mark - 网络

/**
 *  发送意见反馈请求
 */
- (void)sendFeedBackRequest
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
    
    [[NetWorkSingleton sharedManager] feedBackWithTitle:_titleTextField.text Content:_contentTextView.text userContactType:kUserContactMethodTypePhone ContactDetail:_contactMethodTextField.text SuccessBlock:^(id responseBody) {
        
        if ([self isRequestSuccess:responseBody]) {
            [SVProgressHUD dismissWithSuccess:@"反馈成功" afterDelay:0.5];
        }else{
            [SVProgressHUD dismiss];
        }
        
    } FailureBlock:^(NSString *error) {
        [SVProgressHUD dismissWithError:error afterDelay:0.5];
    }];
}

@end
