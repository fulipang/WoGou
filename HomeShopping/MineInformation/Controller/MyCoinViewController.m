//
//  MyCoinViewController.m
//  HomeShopping
//
//  Created by sooncong on 16/1/9.
//  Copyright © 2016年 Administrator. All rights reserved.
//

#import "MyCoinViewController.h"
#import "ImageScrollView.h"
#import "ProtocolWebViewController.h"
#import "CoinRecordViewController.h"
#import "HPModelListsParser.h"
#import "HSAdsLists.h"

@implementation MyCoinViewController
{
    NSArray * _titles;
    
    NSMutableArray * _adsData;
    
    ImageScrollView * _headerView;
    
    NSString * _coinsNumber;
}

-(instancetype)initWithCoinNumber:(NSString *)coins
{
    self = [super init];
    
    if (self) {
        
        _coinsNumber = coins;
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
    
    [self initData];
    
    [self getAdsData];
    
    [self loadCostomViw];
}

#pragma mark - 初始化数据

/**
 *  初始化数据
 */
- (void)initData
{
    _adsData = [NSMutableArray array];
    
    _titles = [NSArray arrayWithObjects:@"剩余狗币",@"狗币记录",@"狗币规则", nil];
}

#pragma mark - 自定义视图

/**
 *  装载自定义视图 总览
 */
- (void)loadCostomViw
{
    [self setNavigationBarLeftButtonImage:@"NavBar_Back"];
    
    [self setNavigationBarTitle:@"我的狗币"];
    
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
    
    
    _headerView = [[ImageScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, GET_SCAlE_HEIGHT(145))];
    self.mainTableView.tableHeaderView = _headerView;
    [_headerView callBackWithBlock:^(NSInteger index) {
        
        if (_adsData.count > 0) {
            HPAddsModel * ads = _adsData[index];
            
            [self JumpToadvertisementWithModel:ads];
        }
        
    }];
    
    //    _headerView.delegate = self;
}


/**
 *  自定义cell控件方法
 *
 *  @param indexPath 位置
 *
 *  @return 自定义 contentView
 */
- (UIView *)viewWithCell:(NSIndexPath *)indexPath
{
    UIView * contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, GET_SCAlE_HEIGHT(45))];
    
    UILabel * line = [UILabel new];
    [contentView addSubview:line];
    [line makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(contentView.mas_bottom);
        make.right.mas_equalTo(contentView.right);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - GET_SCAlE_LENGTH(15), 0.5));
    }];
    line.backgroundColor = UIColorFromRGB(LINECOLOR);
    
    UILabel * customTitleLabel  = [UILabel new];
    [contentView addSubview:customTitleLabel];
    [customTitleLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(contentView.centerY).with.offset(0);
        make.left.mas_equalTo(contentView.left).with.offset(GET_SCAlE_LENGTH(20));
    }];
    customTitleLabel.textColor = UIColorFromRGB(BLACKFONTCOLOR);
    customTitleLabel.font = [UIFont systemFontOfSize:TITLENAMEFONTSIZE];
    customTitleLabel.text = _titles[indexPath.row];
    
    if (indexPath.row == 0) {
        UILabel * coinNumberLabel  = [UILabel new];
        [contentView addSubview:coinNumberLabel];
        [coinNumberLabel makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(customTitleLabel.centerY).with.offset(0);
            make.right.mas_equalTo(contentView.right).with.offset(GET_SCAlE_LENGTH(-15));
        }];
        coinNumberLabel.textColor = UIColorFromRGB(BLACKFONTCOLOR);
        coinNumberLabel.font = [UIFont systemFontOfSize:TITLENAMEFONTSIZE];
        coinNumberLabel.text = _coinsNumber;
    }else{
        UIImageView * arrow = [UIImageView new];
        [contentView addSubview:arrow];
        arrow.image = [UIImage imageNamed:@"arrow_right"];
        [arrow makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(contentView.centerY);
            make.right.mas_equalTo(contentView.right).with.offset(GET_SCAlE_LENGTH(-15));
            make.size.mas_equalTo(CGSizeMake(arrow.image.size.width, arrow.image.size.height));
        }];
    }
    
    return contentView;
}


#pragma mark - UITableviewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return GET_SCAlE_HEIGHT(45);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _titles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    for (id subView in cell.contentView.subviews) {
        
        if ([subView isKindOfClass:[UIView class]]) {
            
            UIView *vie = (UIView *)subView;
            [vie removeFromSuperview];
        }
    }
    
    [cell.contentView addSubview:[self viewWithCell:indexPath]];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyCoinCellType type = indexPath.row;
    
    switch (type) {
        case kCoinCellTypeRestCoin: {
            
            break;
        }
        case kCoinCellTypeCoinRecord: {
            self.hidesBottomBarWhenPushed = YES;
            CoinRecordViewController * VC  = [[CoinRecordViewController alloc] init];
            [self.navigationController pushViewController:VC animated:YES];
            break;
        }
        case kCoinCellTypeCoinRules: {
            self.hidesBottomBarWhenPushed  = YES;
            ProtocolWebViewController * VC = [[ProtocolWebViewController alloc] initWithTitle:@"狗币规则" functionID:@"coinrule"];
            [self.navigationController pushViewController:VC animated:YES];
            break;
        }
    }
}

#pragma mark - 网络

- (void)getAdsData
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
    
    NSMutableDictionary * headDic = [[NSMutableDictionary alloc] initWithCapacity:1];
    NSMutableDictionary * bodyDic = [[NSMutableDictionary alloc] initWithCapacity:1];
    
    [bodyDic setObject:@"mygold" forKey:@"functionid"];
    
    if ([[AppInformationSingleton shareAppInfomationSingleton] getLoginCode]) {
        [headDic setObject:[[AppInformationSingleton shareAppInfomationSingleton] getLoginCode] forKey:@"ut"];
        [headDic setObject:[[AppInformationSingleton shareAppInfomationSingleton] getUserID] forKey:@"userid"];
    }
    
    [[NetWorkSingleton sharedManager] postWithHeadParameter:headDic bodyParameter:bodyDic SuccessBlock:^(id responseBody) {
        
        
        
        HPModelListsParser * Parser = [[HPModelListsParser alloc] initWithDictionary:responseBody];
        NSArray * arrM = Parser.modelLists.addsModel;
        [arrM enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj isKindOfClass:[HPAddsModel class]]) {
                [_adsData addObject:obj];
            }
        }];
        
        [_headerView setImageArray:_adsData];
        
    } FailureBlock:^(NSString *error) {
        
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
