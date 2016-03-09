//
//  CoinRecordViewController.m
//  HomeShopping
//
//  Created by sooncong on 16/1/9.
//  Copyright © 2016年 Administrator. All rights reserved.
//

#import "CoinRecordViewController.h"

@implementation CoinRecordViewController
{
    NSMutableArray * _dataSource;
}

#pragma mark - 生命周期

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self getCoinRecordList];
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
    
    [self setNavigationBarTitle:@"狗币记录"];
    
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
}

- (UIView *)viewWithCellIndexPath:(NSIndexPath *)indexPath
{
    UIView * contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, GET_SCAlE_HEIGHT(45))];
     
     UILabel * line1 = [UILabel new];
     [contentView addSubview:line1];
     [line1 makeConstraints:^(MASConstraintMaker *make) {
     make.bottom.mas_equalTo(contentView.mas_bottom);
     make.centerX.mas_equalTo(contentView.left).with.offset(GET_SCAlE_LENGTH(135));
     make.size.mas_equalTo(CGSizeMake(1, GET_SCAlE_HEIGHT(25)));
     }];
//     line1.backgroundColor = UIColorFromRGB(LIGHTBLUECOLOR);
    
     UILabel * line3 = [UILabel new];
     [contentView addSubview:line3];
     [line3 makeConstraints:^(MASConstraintMaker *make) {
     make.bottom.mas_equalTo(contentView.mas_bottom);
     make.centerX.mas_equalTo(contentView.right).with.offset(GET_SCAlE_LENGTH(-85));
     make.size.mas_equalTo(CGSizeMake(1, GET_SCAlE_HEIGHT(25)));
     }];
//     line3.backgroundColor = UIColorFromRGB(LIGHTBLUECOLOR);
    
     UILabel * customTitleLabel  = [UILabel new];
     [contentView addSubview:customTitleLabel];
     [customTitleLabel makeConstraints:^(MASConstraintMaker *make) {
     make.centerY.mas_equalTo(contentView.centerY).with.offset(0);
     make.left.mas_equalTo(contentView.left).with.offset(GET_SCAlE_LENGTH(10));
     make.right.mas_equalTo(line1.left).with.offset(0);
     }];
     customTitleLabel.textColor = UIColorFromRGB(GRAYFONTCOLOR);
     customTitleLabel.font = [UIFont systemFontOfSize:14];
     customTitleLabel.textAlignment = NSTextAlignmentCenter;
     
     UILabel * timeLabel  = [UILabel new];
     [contentView addSubview:timeLabel];
     [timeLabel makeConstraints:^(MASConstraintMaker *make) {
     make.centerY.mas_equalTo(contentView.centerY).with.offset(0);
     make.right.mas_equalTo(contentView.right).with.offset(GET_SCAlE_LENGTH(-10));
     make.left.mas_equalTo(line3.right);
     }];
     timeLabel.textColor = UIColorFromRGB(GRAYFONTCOLOR);
     timeLabel.font = [UIFont systemFontOfSize:14];
     timeLabel.textAlignment = NSTextAlignmentCenter;
     
     UILabel * quantityLabel  = [UILabel new];
     [contentView addSubview:quantityLabel];
     
     UILabel * restLabel  = [UILabel new];
     [contentView addSubview:restLabel];
     
     [restLabel makeConstraints:^(MASConstraintMaker *make) {
     make.centerY.mas_equalTo(contentView.centerY).with.offset(0);
     make.left.mas_equalTo(quantityLabel.right);
     make.right.mas_equalTo(line3.left).with.offset(0);
     make.width.mas_equalTo(quantityLabel.width);
     }];
     restLabel.textColor = UIColorFromRGB(REDFONTCOLOR);
     restLabel.font = [UIFont systemFontOfSize:14];
     restLabel.textAlignment = NSTextAlignmentCenter;
    
     [quantityLabel makeConstraints:^(MASConstraintMaker *make) {
     make.centerY.mas_equalTo(contentView.centerY).with.offset(0);
     make.left.mas_equalTo(line1.right);
     make.right.mas_equalTo(restLabel.left).with.offset(0);
     make.width.mas_equalTo(restLabel.width);
     }];
     quantityLabel.textColor = UIColorFromRGB(LIGHTBLUECOLOR);
     quantityLabel.font = [UIFont systemFontOfSize:14];
     quantityLabel.textAlignment = NSTextAlignmentCenter;
    
    restLabel.text = @"30000";
    quantityLabel.text = @"+10000";
    timeLabel.text = @"2015/12/25";
    customTitleLabel.text = @"换购-豪华双人房";
    
    
    UILabel * line = [UILabel new];
    [contentView addSubview:line];
    [line makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(contentView.mas_bottom);
        make.centerX.mas_equalTo(contentView.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 0.5));
    }];
    line.backgroundColor = UIColorFromRGB(LINECOLOR);
    
    return contentView;
}

#pragma mark - UITableviewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return GET_SCAlE_HEIGHT(25);
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, GET_SCAlE_HEIGHT(25))];
    headView.backgroundColor = UIColorFromRGB(GRAYBGCOLOR);
    
    UILabel * line1 = [UILabel new];
    [headView addSubview:line1];
    [line1 makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(headView.mas_bottom);
        make.centerX.mas_equalTo(headView.left).with.offset(GET_SCAlE_LENGTH(135));
        make.size.mas_equalTo(CGSizeMake(1, GET_SCAlE_HEIGHT(25)));
    }];
//    line1.backgroundColor = UIColorFromRGB(LIGHTBLUECOLOR);
    
    UILabel * line3 = [UILabel new];
    [headView addSubview:line3];
    [line3 makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(headView.mas_bottom);
        make.centerX.mas_equalTo(headView.right).with.offset(GET_SCAlE_LENGTH(-85));
        make.size.mas_equalTo(CGSizeMake(1, GET_SCAlE_HEIGHT(25)));
    }];
//    line3.backgroundColor = UIColorFromRGB(LIGHTBLUECOLOR);
    
    UILabel * customTitleLabel  = [UILabel new];
    [headView addSubview:customTitleLabel];
    [customTitleLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(headView.centerY).with.offset(0);
        make.left.mas_equalTo(headView.left).with.offset(GET_SCAlE_LENGTH(10));
        make.right.mas_equalTo(line1.left).with.offset(0);
    }];
    customTitleLabel.textColor = UIColorFromRGB(GRAYFONTCOLOR);
    customTitleLabel.font = [UIFont systemFontOfSize:12];
    customTitleLabel.text = @"详情";
    customTitleLabel.textAlignment = NSTextAlignmentCenter;
    
    UILabel * timeLabel  = [UILabel new];
    [headView addSubview:timeLabel];
    [timeLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(headView.centerY).with.offset(0);
        make.right.mas_equalTo(headView.right).with.offset(GET_SCAlE_LENGTH(-10));
        make.left.mas_equalTo(line3.right);
    }];
    timeLabel.textColor = UIColorFromRGB(GRAYFONTCOLOR);
    timeLabel.font = [UIFont systemFontOfSize:12];
    timeLabel.text = @"时间";
    timeLabel.textAlignment = NSTextAlignmentCenter;
    
    UILabel * quantityLabel  = [UILabel new];
    [headView addSubview:quantityLabel];
    
    UILabel * restLabel  = [UILabel new];
    [headView addSubview:restLabel];
    
    
    [restLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(headView.centerY).with.offset(0);
        make.left.mas_equalTo(quantityLabel.right);
        make.right.mas_equalTo(line3.left).with.offset(0);
        make.width.mas_equalTo(quantityLabel.width);
    }];
    restLabel.textColor = UIColorFromRGB(GRAYFONTCOLOR);
    restLabel.font = [UIFont systemFontOfSize:12];
    restLabel.textAlignment = NSTextAlignmentCenter;
    restLabel.text = @"余额";
    
    [quantityLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(headView.centerY).with.offset(0);
        make.left.mas_equalTo(line1.right);
        make.right.mas_equalTo(restLabel.left).with.offset(0);
        make.width.mas_equalTo(restLabel.width);
    }];
    quantityLabel.textColor = UIColorFromRGB(GRAYFONTCOLOR);
    quantityLabel.font = [UIFont systemFontOfSize:12];
    quantityLabel.textAlignment = NSTextAlignmentCenter;
    quantityLabel.text = @"数量";
    
    return headView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return GET_SCAlE_LENGTH(45);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return (_dataSource)?_dataSource.count:0;
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
    
    [cell.contentView addSubview:[self viewWithCellIndexPath:indexPath]];
    
    return cell;
}

#pragma mark - 网络

- (void)getCoinRecordList
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
    
    NSMutableDictionary * headDic = [[NSMutableDictionary alloc] initWithCapacity:1];
    NSMutableDictionary * bodyDic = [[NSMutableDictionary alloc] initWithCapacity:1];
    [bodyDic setObject:@"getmycointlog" forKey:@"functionid"];
    
    if ([[AppInformationSingleton shareAppInfomationSingleton] getLoginCode]) {
        [headDic setObject:[[AppInformationSingleton shareAppInfomationSingleton] getLoginCode] forKey:@"ut"];
        [headDic setObject:[[AppInformationSingleton shareAppInfomationSingleton] getUserID] forKey:@"userid"];
    }
    
    [[NetWorkSingleton sharedManager] postWithHeadParameter:headDic bodyParameter:bodyDic SuccessBlock:^(id responseBody) {
        
        if ([self isRequestSuccess:responseBody]) {
            [SVProgressHUD dismissWithSuccess:@"加载成功" afterDelay:0.5];
        }else{
            [SVProgressHUD dismiss];
        }
        
        if (_dataSource == nil) {
            _dataSource = [NSMutableArray array];
        }
        
        [self showEmptyViewWithTableView:self.mainTableView];
        
    } FailureBlock:^(NSString *error) {
        
        [SVProgressHUD dismiss];
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


@end
