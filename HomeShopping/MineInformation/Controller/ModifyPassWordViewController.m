//
//  ModifyPassWordViewController.m
//  HomeShopping
//
//  Created by sooncong on 16/1/24.
//  Copyright © 2016年 Administrator. All rights reserved.
//

#import "ModifyPassWordViewController.h"

@implementation ModifyPassWordViewController
{
    UITextField * _phoneTextField;
    UITextField * _oldPassWordTextField;
    UITextField * _newPassWordTextField;
    
    NSString * _telNumber;
}

-(instancetype)initWithTelPhoneNumber:(NSString *)telphoneNumber
{
    if (self = [super init]) {
        
        _telNumber = telphoneNumber;
    }
    
    return self;
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
    [self setNavigationBarLeftButtonImage:@"NavBar_Back"];
    
    [self setNavigationBarTitle:@"修改密码"];
    
    [self loadMainTableView];
}

- (void)loadMainTableView
{
    self.mainTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.view addSubview:self.mainTableView];
    [self.mainTableView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.and.bottom.mas_equalTo(self.view);
        make.top.mas_equalTo(self.customNavigationBar.bottom);
    }];
    
    self.mainTableView.delegate       = self;
    self.mainTableView.dataSource     = self;
    self.mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.mainTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    self.mainTableView.tableFooterView = [self createFooterView];
}

- (UIView *)createFooterView
{
    UIView * contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, GET_SCAlE_HEIGHT(60))];
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    [contentView addSubview:button];
    [button makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(contentView.bottom);
        make.centerX.mas_equalTo(contentView.centerX);
        make.size.mas_equalTo(CGSizeMake(GET_SCAlE_LENGTH(290), GET_SCAlE_HEIGHT(40)));
    }];
    [button setTitle:@"提 交" forState:UIControlStateNormal];
    [button.titleLabel setFont:[UIFont systemFontOfSize:LARGEFONTSIZE]];
    [button setTitleColor:UIColorFromRGB(WHITECOLOR) forState:UIControlStateNormal];
    button.backgroundColor = [UIColor orangeColor];
    button.layer.cornerRadius = 15;
    button.clipsToBounds = YES;
    [button addTarget:self action:@selector(commitChange) forControlEvents:UIControlEventTouchUpInside];
    
    return contentView;
}

#pragma mark - UITableviewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return GET_SCAlE_HEIGHT(50);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    for (id subView in cell.contentView.subviews) {
        
        if ([subView isKindOfClass:[UIView class]]) {
            
            UIView *vie = (UIView *)subView;
            [vie removeFromSuperview];
        }
    }
    
    [cell.contentView addSubview:[self viewWithCell:indexPath]];
    
    return cell;
}

- (UIView *)viewWithCell:(NSIndexPath *)indexPath
{
    UIView * contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, GET_SCAlE_HEIGHT(50))];
    
    UILabel * line = [UILabel new];
    [contentView addSubview:line];
    [line makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(contentView.mas_bottom);
        make.centerX.mas_equalTo(contentView.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 0.5));
    }];
    line.backgroundColor = UIColorFromRGB(LINECOLOR);
    
//    UILabel * titleLabel = [UILabel new]
    UILabel * titleLabel  = [UILabel new];
    [contentView addSubview:titleLabel];
    [titleLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(contentView.centerY).with.offset(0);
        make.left.mas_equalTo(contentView.left).with.offset(GET_SCAlE_LENGTH(15));
    }];
    titleLabel.textColor = UIColorFromRGB(GRAYFONTCOLOR);
    titleLabel.font = [UIFont systemFontOfSize:TITLENAMEFONTSIZE];
    
    switch (indexPath.row) {
        case 0:{
            titleLabel.text = @"手机号：";
         
            _phoneTextField = [UITextField new];
            [contentView addSubview:_phoneTextField];
            [_phoneTextField makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(contentView.centerY);
                make.left.mas_equalTo(titleLabel.right).with.offset(GET_SCAlE_LENGTH(15));
                make.size.mas_equalTo(CGSizeMake(GET_SCAlE_LENGTH(200), GET_SCAlE_HEIGHT(35)));
            }];
            _phoneTextField.delegate = self;
            _phoneTextField.font = [UIFont systemFontOfSize:TITLENAMEFONTSIZE];
            _phoneTextField.text = _telNumber;
            
            break;
        }
        case 1:{
            titleLabel.text = @"原密码：";
         
            _oldPassWordTextField = [UITextField new];
            [contentView addSubview:_oldPassWordTextField];
            [_oldPassWordTextField makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(contentView.centerY);
                make.left.mas_equalTo(titleLabel.right).with.offset(GET_SCAlE_LENGTH(15));
                make.size.mas_equalTo(CGSizeMake(GET_SCAlE_LENGTH(200), GET_SCAlE_HEIGHT(35)));
            }];
            _oldPassWordTextField.delegate = self;
            _oldPassWordTextField.font = [UIFont systemFontOfSize:TITLENAMEFONTSIZE];
            
            break;
        }
        case 2:{
            titleLabel.text = @"新密码：";
         
            _newPassWordTextField = [UITextField new];
            [contentView addSubview:_newPassWordTextField];
            [_newPassWordTextField makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(contentView.centerY);
                make.left.mas_equalTo(titleLabel.right).with.offset(GET_SCAlE_LENGTH(15));
                make.size.mas_equalTo(CGSizeMake(GET_SCAlE_LENGTH(200), GET_SCAlE_HEIGHT(35)));
            }];
            _newPassWordTextField.delegate = self;
            _newPassWordTextField.font = [UIFont systemFontOfSize:TITLENAMEFONTSIZE];
            
            break;
        }
        default:
            break;
    }
    
    return contentView;
}

#pragma mark - UITextFieldDelegate

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    [_phoneTextField resignFirstResponder];
    [_oldPassWordTextField resignFirstResponder];
    [_newPassWordTextField resignFirstResponder];
    
    return YES;
}

#pragma mark - 事件

- (void)commitChange
{
    if (_phoneTextField.text.length != 11) {
        
        NSString *showMsg = @"请输入正确的号码格式";
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"提示" message: showMsg delegate: self cancelButtonTitle:@"确定" otherButtonTitles: nil, nil];
        
        [alert show];
        return;
    }
    
    else if (_oldPassWordTextField.text.length < 6){
        NSString *showMsg = @"请输入不少于6位的密码";
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"提示" message: showMsg delegate: self cancelButtonTitle:@"确定" otherButtonTitles: nil, nil];
        
        [alert show];
        return;
    }
    
    else if (_newPassWordTextField.text.length < 6){
        NSString *showMsg = @"请输入不少于6位的密码";
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"提示" message: showMsg delegate: self cancelButtonTitle:@"确定" otherButtonTitles: nil, nil];
        
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
    
    NSMutableDictionary * headDic = [[NSMutableDictionary alloc] initWithCapacity:1];
    NSMutableDictionary * bodyDic = [[NSMutableDictionary alloc] initWithCapacity:1];
    [bodyDic setObject:@"updatepassword" forKey:@"functionid"];
    [bodyDic setObject:_phoneTextField.text forKey:@"phone"];
    [bodyDic setObject:_oldPassWordTextField.text forKey:@"password"];
    [bodyDic setObject:_newPassWordTextField.text forKey:@"newpassword"];
    
    if ([[AppInformationSingleton shareAppInfomationSingleton] getLoginCode]) {
        [headDic setObject:[[AppInformationSingleton shareAppInfomationSingleton] getLoginCode] forKey:@"ut"];
        [headDic setObject:[[AppInformationSingleton shareAppInfomationSingleton] getUserID] forKey:@"userid"];
    }
    
    [[NetWorkSingleton sharedManager] postWithHeadParameter:headDic bodyParameter:bodyDic SuccessBlock:^(id responseBody) {
        
        if ([self isRequestSuccess:responseBody]) {
            [SVProgressHUD dismissWithSuccess:@"修改成功" afterDelay:0.5];
        }else{
            [SVProgressHUD dismiss];
        }
        
    } FailureBlock:^(NSString *error) {
        [SVProgressHUD dismiss];
    }];
}

-(void)leftButtonClicked
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)rightButtonClicked
{
    
}

@end
