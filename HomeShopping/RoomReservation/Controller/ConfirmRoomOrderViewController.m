//
//  ConfirmRoomOrderViewController.m
//  HomeShopping
//
//  Created by sooncong on 16/1/13.
//  Copyright © 2016年 Administrator. All rights reserved.
//

#import "ConfirmRoomOrderViewController.h"
#import "HotelSuppliesProductCell.h"
#import "cellDemonstrationView.h"
#import "ProductDetailTabbar2.h"
#import "ConfirmHotelSuppliesOrderViewController2.h"
#import "ShoppingCartViewController.h"
#import "ProductDetailModelParser.h"
#import "CalendarHomeViewController.h"
#import "LoginViewController.h"

#import "ShoppingCarProduct.h"

@interface ConfirmRoomOrderViewController ()
/**
 *  数量操作基视图
 */
{
    UILabel *_numberLabel;
    NSInteger _count;
    ProductDetailTabbar2 *_tabbar;
    //请求参数
    NSMutableDictionary * _postNormDic;
    
    NSInteger _sleepDays;
    NSArray  *_monthDayArr;
    
    
}

@property (nonatomic, strong) UIView * quantityBaseView;
@property (nonatomic, readwrite, strong) UIWebView *webView;

@end

@implementation ConfirmRoomOrderViewController

#pragma mark - 生命周期

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    _postNormDic = [NSMutableDictionary dictionary];
    [self loadCostomViw];
    _count = 1;
    _sleepDays = 1;
    [self getProductDetailData];
}




#pragma mark - 网络

- (void)getProductDetailData
{
    NSMutableDictionary * headDic = [[NSMutableDictionary alloc] initWithCapacity:1];
    NSMutableDictionary * bodyDic = [[NSMutableDictionary alloc] initWithCapacity:1];
    
    [bodyDic setObject:self.productid forKey:@"productid"];
    [bodyDic setObject:@"productdetail" forKey:@"functionid"];
    
    [[NetWorkSingleton sharedManager] postWithHeadParameter:headDic bodyParameter:bodyDic SuccessBlock:^(id responseBody) {
        
        NSLog(@"responseBody:%@",responseBody);
        
        ProductDetailModelParser * parser = [[ProductDetailModelParser alloc] initWithDictionary:responseBody];
        _productDetail = parser.productDetailModel.productDetail;
        
        HSProduct *model = [HSProduct new];
        model.price = _productDetail.price;
        model.coinprice = _productDetail.coinprice;
        model.coinreturn = _productDetail.coinreturn;
        model.logo = _productDetail.logo;
        model.title = _productDetail.title;
        self.longIntro = _productDetail.longintro;
        self.product = model;
        
        [self.mainTableView reloadData];
        
        [self refreshWebView];
        
    } FailureBlock:^(NSString *error) {
        
    }];
}

#pragma mark 刷新webview

- (void)refreshWebView {
    [_webView loadHTMLString:self.longIntro baseURL:nil];
}

#pragma mark - 自定义视图

/**
 *  装载自定义视图 总览
 */
- (void)loadCostomViw
{
    [self setNavigationBarLeftButtonImage:@"NavBar_Back"];
    
    [self setNavigationBarTitle:@"订单确认"];
    
    [self setNavigationBarRightButtonImage:@"NavBar_shopCart" WithTitle:@"购物车"];
    
    [self loadMainTableView];
    
    [self addToolBar];
}

- (void)addToolBar {
    _tabbar = [[ProductDetailTabbar2 alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 95/2.0) callBackBlock:^(ProductTabType type) {
        NSLog(@"type = %ld",type);
        
        [self bottomViewClickWithType:type];
        
    }];
    [self.view addSubview:_tabbar];
    _tabbar.collectionButton.userInteractionEnabled = NO;
    [_tabbar makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view).with.offset(0);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 95/2.0));
    }];
}


/**
 *  底部按钮点击事件
 *
 *  @param type 点击类型
 */
- (void)bottomViewClickWithType:(ProductTabType)type;
{
    if (type != kTapTelPhone && type != kTapGustclothing) {
        
        if (![[AppInformationSingleton shareAppInfomationSingleton] getLoginCode]) {
            NSString *showMsg = @"请先登录";
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"提示"
                                                            message: showMsg
                                                           delegate: self
                                                  cancelButtonTitle:@"取消"
                                                  otherButtonTitles: @"确定", nil];
            
            [alert show];
            return;
        }
        
    }
    
    switch (type) {
        case kTapGustclothing: {
            
            break;
        }
        case kTapTelPhone: {
            
            break;
        }
        case kTapCollection: {
            
            break;
        }
        case kTapShoppingCart: {
            [self addShopCarOrCollectionWithType:kGetInTypeShopCar];
            break;
        }
        case kTapBuy: {
            self.hidesBottomBarWhenPushed = YES;
            
            
            [self configureDataSource];
            
            break;
        }
    }
}

- (void)configureDataSource {
    
    
    ShoppingCarProduct *order = [ShoppingCarProduct new];
    order.productid = _productDetail.productid;
    order.outdate = self.MonthDayArr.lastObject;
    order.indate = self.MonthDayArr.firstObject;
    order.buycount = @(_count).stringValue;
    order.sellername = _productDetail.sellername;
    order.price = _productDetail.price;
    order.coinprice = _productDetail.coinprice;
    order.coinreturn = _productDetail.coinreturn;
    order.logo = _productDetail.logo;
    order.title = _productDetail.title;
    order.cityname = _productDetail.cityname;
    order.citycode = _productDetail.citycode;
    order.starlevel = _productDetail.starlevel;
    order.isneedbook = _productDetail.isneedbook;
    order.producttype = _productDetail.producttype;
    order.turnover = _productDetail.turnover;
    order.distance = _productDetail.distance;
    order.address = _productDetail.address;
    order.score = _productDetail.score;
    order.isspecial = _productDetail.isspecial;
    order.sellerid = _productDetail.sellerid;
    order.tag = @""; // 暂时赋值,因为没有这个字段
    order.normtitle = _productDetail.title;// 暂时赋值
    order.pricenow = _productDetail.price; // 暂时赋值
    
    NSString *buyNum =@(_count).stringValue;
    NSArray *products = @[order,buyNum];
    NSArray *dataSource = @[products];
    ConfirmHotelSuppliesOrderViewController2 * VC = [[ConfirmHotelSuppliesOrderViewController2 alloc] initWithDataSource:dataSource withOrderType:kOrderTypeReservation];
    VC.dataSource = dataSource;
    VC.totalMoney = order.price.floatValue/100.0 * _count * _sleepDays;
    VC.totalReturn = order.coinreturn.intValue * _count * _sleepDays;
    [self.navigationController pushViewController:VC animated:YES];
    
    
}



- (void)addShopCarOrCollectionWithType:(ProductGetInType)type
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
    [bodyDic setObject:@"addtocar" forKey:@"functionid"];
    
    if ([[AppInformationSingleton shareAppInfomationSingleton] getLoginCode]) {
        [headDic setObject:[[AppInformationSingleton shareAppInfomationSingleton] getLoginCode] forKey:@"ut"];
        [headDic setObject:[[AppInformationSingleton shareAppInfomationSingleton] getUserID] forKey:@"userid"];
    }
    
    [_postNormDic setObject:@(_count) forKey:@"buycount"];
    [_postNormDic setObject:_MonthDayArr.firstObject forKey:@"indate"];
    [_postNormDic setObject:_MonthDayArr.lastObject forKey:@"outdate"];
    [_postNormDic setObject:_productDetail.productid forKey:@"productid"];
    
    NSArray * arrM = [NSArray arrayWithObjects:_postNormDic, nil];
    
    [bodyDic setObject:arrM forKey:@"products"];
    
    [bodyDic setObject:_productDetail.productid forKey:@"scproductid"];
    
    [SVProgressHUD show];
    
    [[NetWorkSingleton sharedManager] postWithHeadParameter:headDic bodyParameter:bodyDic SuccessBlock:^(id responseBody) {
        
        NSLog(@"result = %@",responseBody);
        [SVProgressHUD dismissWithSuccess:@"已成功加入购物车" afterDelay:0.5];
    } FailureBlock:^(NSString *error) {
        [SVProgressHUD dismissWithError:nil afterDelay:0.3];
    }];
}



- (void)loadMainTableView
{
    self.mainTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    [self.view addSubview:self.mainTableView];
    [self.mainTableView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.and.bottom.mas_equalTo(self.view);
        make.top.mas_equalTo(self.customNavigationBar.bottom);
    }];
    
    self.mainTableView.delegate       = self;
    self.mainTableView.dataSource     = self;
    self.mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.mainTableView registerClass:[HotelSuppliesProductCell class] forCellReuseIdentifier:@"HotelSuppliesProductCell"];
    
    [self.mainTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.mainTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"HotelDayToDayCell"];
    [self.mainTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"HotelNumberCell"];
    
}

#pragma mark - UITableviewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        HotelSuppliesProductCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HotelSuppliesProductCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell cellForHoelSuppListVC:NO];
        [cell cellForRowWithModel:self.product];
        cell.customScoreLabel.hidden = YES;
        cell.turnOverLabel.hidden = YES;
        [cell showDetail:YES];
        return cell;
    }
    
    if (indexPath.section == 1) {
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"HotelDayToDayCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cellDemonstrationView *view = [cell.contentView  viewWithTag:1000];
        if (!view) {
            [cell.contentView addSubview:[self setupHotelNumber]];
        }
        return cell;
    }
    
    if (indexPath.section == 2) {
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"HotelNumberCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UIView *view = [cell.contentView viewWithTag:1001];
        if (!view) {
            [cell.contentView addSubview:[self createQuantityBaseView]];
        }
        return cell;
    }
    
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    UIWebView *web = [cell.contentView viewWithTag:999];
    if (!web) {
        [cell.contentView addSubview:self.webView];
        [self.webView makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(cell.contentView);
        }];
    }
    
    
    UILabel * line = [UILabel new];
    [cell.contentView addSubview:line];
    [line makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(cell.contentView.mas_bottom);
        make.centerX.mas_equalTo(cell.contentView.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 0.5));
    }];
    line.backgroundColor = UIColorFromRGB(LINECOLOR);
    
    return cell;
}

#pragma mark UITableViewDelegate


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 3) {
        return GET_SCAlE_HEIGHT(228);
    }
    if (indexPath.section == 0) {
        return GET_SCAlE_HEIGHT(101);
    }
    return GET_SCAlE_HEIGHT(50);
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.001;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 1) {
        [self chooseDateTap];
    }
}

- (void)chooseDateTap
{
    
    CalendarHomeViewController * chvc = [[CalendarHomeViewController alloc]init];
    
    [chvc setHotelToDay:60 ToDateforString:nil];
    
    chvc.calendarblock = ^(CalendarDayModel *beginDay ,CalendarDayModel * endDay){
        
        NSLog(@"\n---------------------------");
        NSLog(@"1星期 %@",[beginDay getWeek]);
        NSLog(@"2字符串 %@",[beginDay toString]);
        NSLog(@"3节日  %@",beginDay.holiday);
        
        NSLog(@"\n---------------------------");
        NSLog(@"1星期 %@",[endDay getWeek]);
        NSLog(@"2字符串 %@",[endDay toString]);
        NSLog(@"3节日  %@",endDay.holiday);
        
        _dayBeginLabel.text = [beginDay.toString stringByAppendingString:@"入住"];
        _datEndLabel.text = [endDay.toString stringByAppendingString:@"离店"];
        
        
        _monthDayArr = @[beginDay.toString, endDay.toString];
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        formatter.dateFormat = @"yyyy-MM-dd";
        NSDate *beginDate = [formatter dateFromString:beginDay.toString];
        NSDate *endDate = [formatter dateFromString:endDay.toString];
        BOOL is  = [beginDate timeIntervalSinceDate:endDate]>0 ? NO:YES;
        
        NSTimeInterval interval = [endDate timeIntervalSinceDate:beginDate];
        
        if (!is) {
            _dayBeginLabel.text = [endDay.toString stringByAppendingString:@"入住"];
            _datEndLabel.text = [beginDay.toString stringByAppendingString:@"离店"];
            _monthDayArr = @[endDay.toString, beginDay.toString];
            interval = [beginDate timeIntervalSinceDate:endDate];
        }
        
        self.MonthDayArr = _monthDayArr;
        
        NSInteger days = interval / (24 * 3600);
        (days < 0)?(days = 1):(days = days);
        _sleepDays = days;
        
        if ([endDay.toString isEqualToString:beginDay.toString]) {
            _totalDaysLabel.text = [NSString stringWithFormat:@"共%ld晚",days];
        }
        else {
            _totalDaysLabel.text = [NSString stringWithFormat:@"共%ld晚",days];
        }
        
    };
    
    
    
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:chvc animated:YES];
    
    
}



#pragma mark 自定义视图

- (UIWebView *)webView {
    if (!_webView) {
        _webView = [[UIWebView alloc]initWithFrame:CGRectZero];
        _webView.tag = 999;
        [_webView loadHTMLString:self.longIntro baseURL:nil];
    }
    return _webView;
}

- (UIView*)setupHotelNumber {
    cellDemonstrationView * view = [[cellDemonstrationView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,GET_SCAlE_HEIGHT(50))];
    view.tag = 1000;
    view.backgroundColor = UIColorFromRGB(WHITECOLOR);
    
    [view setViewWithTitle:nil SubTitle:nil RightTitle:nil SymbolImage:[UIImage imageNamed:@""]];
    
    UIImageView * calender = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"callender"]];
    [view addSubview:calender];
    [calender makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(view.centerY);
        make.left.mas_equalTo(view.left).with.offset(GET_SCAlE_LENGTH(15));
        make.size.mas_equalTo(CGSizeMake(calender.image.size.width, calender.image.size.height));
    }];
    
    
    _dayBeginLabel = [UILabel new];
    [view addSubview:_dayBeginLabel];
    [_dayBeginLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(view.centerY);
        make.left.mas_equalTo(calender.right).with.offset(GET_SCAlE_LENGTH(5));
        //                make.size.mas_equalTo(<#CGSize#>);
    }];
    _dayBeginLabel.textColor = UIColorFromRGB(GRAYFONTCOLOR);
    _dayBeginLabel.font = [UIFont systemFontOfSize:NORMALFONTSIZE];
    _dayBeginLabel.text = [NSString stringWithFormat:@"入店:%@",_MonthDayArr.firstObject];
    
    
    
    _datEndLabel  = [UILabel new];
    [view addSubview:_datEndLabel];
    [_datEndLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(view.centerY).with.offset(0);
        make.left.mas_equalTo(_dayBeginLabel.right).with.offset(GET_SCAlE_LENGTH(10));
    }];
    _datEndLabel.textColor = UIColorFromRGB(GRAYFONTCOLOR);
    _datEndLabel.font = [UIFont systemFontOfSize:NORMALFONTSIZE];
    _datEndLabel.text = [NSString stringWithFormat:@"离店:%@",_MonthDayArr.lastObject];
    _totalDaysLabel  = [UILabel new];
    [view addSubview:_totalDaysLabel];
    [_totalDaysLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(view.centerY).with.offset(0);
        make.right.mas_equalTo(view.symBolImageView.left).with.offset(GET_SCAlE_LENGTH(-5));
    }];
    _totalDaysLabel.textColor = UIColorFromRGB(LIGHTBLUECOLOR);
    _totalDaysLabel.font = [UIFont systemFontOfSize:NORMALFONTSIZE];
    
    
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = @"yyyy-MM-dd";
    NSDate *beginDate = [formatter dateFromString:self.MonthDayArr.firstObject];
    NSDate *endDate = [formatter dateFromString:self.MonthDayArr.lastObject];
    BOOL is  = [beginDate timeIntervalSinceDate:endDate]>0 ? NO:YES;
    
    NSTimeInterval interval = [endDate timeIntervalSinceDate:beginDate];
    
    if (!is) {
        _dayBeginLabel.text = [@"入住:" stringByAppendingString:self.MonthDayArr.lastObject];
        _datEndLabel.text = [@"离店:" stringByAppendingString:self.MonthDayArr.firstObject];
        interval = [beginDate timeIntervalSinceDate:endDate];
    }
    
    NSInteger days = interval / (24 * 3600);
    (days < 0)?(days = 1):(days = days);
    
    _totalDaysLabel.text = [NSString stringWithFormat:@"共%ld晚",days];
    _sleepDays = days;
    
    UILabel * line = [UILabel new];
    [view addSubview:line];
    [line makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(view.centerY);
        make.left.mas_equalTo(_dayBeginLabel.right).with.offset(2);
        make.right.mas_equalTo(_datEndLabel.left).with.offset(-2);
        make.height.mas_equalTo(@2);
    }];
    return view;
}


- (UIView*)createQuantityBaseView
{
    //数量部分
    _quantityBaseView = [UIView new];
    _quantityBaseView.tag = 1001;
    _quantityBaseView.size = CGSizeMake(SCREEN_WIDTH, 50);
    UILabel * quantityTitleLabel  = [UILabel new];
    [_quantityBaseView addSubview:quantityTitleLabel];
    [quantityTitleLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_quantityBaseView.centerY).with.offset(0);
        make.left.mas_equalTo(_quantityBaseView.left).with.offset(GET_SCAlE_LENGTH(15));
    }];
    quantityTitleLabel.textColor = UIColorFromRGB(BLACKFONTCOLOR);
    quantityTitleLabel.font = [UIFont systemFontOfSize:TITLENAMEFONTSIZE];
    quantityTitleLabel.text = @"购买数量";
    
    UIButton * rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_quantityBaseView addSubview:rightButton];
    [rightButton makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_quantityBaseView.centerY);
        make.right.mas_equalTo(_quantityBaseView.right).offset(GET_SCAlE_LENGTH(-15));
        make.size.mas_equalTo(CGSizeMake(GET_SCAlE_LENGTH(30), GET_SCAlE_LENGTH(30)));
    }];
    rightButton.backgroundColor = [UIColor clearColor];
    [self setOperationButton:rightButton WithImage:[UIImage imageNamed:@"selected_plus"]PressImage:[UIImage imageNamed:@"selected_plus_p"]];
    rightButton.tag = 12;
    [rightButton addTarget:self action:@selector(operationButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    _numberLabel  = [UILabel new];
    [_quantityBaseView addSubview:_numberLabel];
    [_quantityBaseView addSubview:_numberLabel];
    [_numberLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_quantityBaseView.centerY).with.offset(0);
        make.right.mas_equalTo(rightButton.left).with.offset(-2);
        make.width.mas_equalTo(@(GET_SCAlE_LENGTH(40)));
    }];
    _numberLabel.textColor = UIColorFromRGB(BLACKFONTCOLOR);
    _numberLabel.font = [UIFont systemFontOfSize:TITLENAMEFONTSIZE];
    _numberLabel.text = @"1";
    _numberLabel.textAlignment = NSTextAlignmentCenter;
    
    UIButton * leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_quantityBaseView addSubview:leftButton];
    [leftButton makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_quantityBaseView.centerY);
        make.right.mas_equalTo(_numberLabel.left).with.offset(-2);
        make.size.mas_equalTo(CGSizeMake(GET_SCAlE_LENGTH(30), GET_SCAlE_LENGTH(30)));
    }];
    leftButton.backgroundColor = [UIColor clearColor];
    [self setOperationButton:leftButton WithImage:[UIImage imageNamed:@"selected_div"]PressImage:[UIImage imageNamed:@"selected_div_p"]];
    leftButton.tag = 11;
    [leftButton addTarget:self action:@selector(operationButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    return _quantityBaseView;
}

- (void)setOperationButton:(UIButton *)button WithImage:(UIImage *)image PressImage:(UIImage *)pressImage
{
    [button setImage:image forState:UIControlStateNormal];
    [button setImage:pressImage forState:UIControlStateHighlighted];
}

/**
 *  数量操作按钮点击事件
 *
 *  @param sender
 */
- (void)operationButtonClicked:(UIButton *)sender
{
    switch (sender.tag % 10) {
        case 2:
            _count++;
            _numberLabel.text = [NSString stringWithFormat:@"%ld",_count];
            break;
            
        case 1:
            if (_count > 1) {
                _count--;
                _numberLabel.text = [NSString stringWithFormat:@"%ld",_count];
            }
            break;
            
        default:
            break;
    }
}



#pragma mark - 事件

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        LoginViewController * VC = [[LoginViewController alloc] init];
        UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:VC];
        [self presentViewController:nav animated:YES completion:^{
            
        }];
    }
}

-(void)leftButtonClicked
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)rightButtonClicked
{
    if ([[AppInformationSingleton shareAppInfomationSingleton] getLoginCode]) {
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:[[ShoppingCartViewController alloc]initWithProductType:kProductTypeVirtual] animated:YES];
    }else{
        NSString *showMsg = @"请先登录";
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"提示"
                                                        message: showMsg
                                                       delegate: self
                                              cancelButtonTitle:@"取消"
                                              otherButtonTitles: @"确定", nil];
        
        [alert show];

    }
}

@end
