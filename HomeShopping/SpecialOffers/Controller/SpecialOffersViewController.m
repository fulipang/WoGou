//
//  SpecialOffersViewController.m
//  HomeShopping
//
//  Created by sooncong on 16/1/7.
//  Copyright © 2016年 Administrator. All rights reserved.
//

#import "SpecialOffersViewController.h"
#import "HSproductListModelParser.h"
#import "HotelModelParser.h"
#import "HotelSuppliesProductCell.h"
#import "HSProduct.h"
#import "Hotels.h"
#import "ChooseCityViewController.h"
#import "cellDemonstrationView.h"
#import "ImageScrollView.h"
#import "HSAdsLists.h"
#import "HotelSuppliesCommodityDetailViewController.h"
#import "RoomReserVationDetailViewController.h"
#import "SearchViewController.h"
#import "ShoppingCartViewController.h"
#import "LoginViewController.h"

@implementation SpecialOffersViewController
{
    //记录当前请求页
    NSInteger _currentPage;
    
    cellDemonstrationView * _cityHeadView;
    
    //记录总页数
    NSInteger _totalPage;
    
    //记录当前商品类型
    ProductType _currentProductType;
    
    //数据源
    NSMutableArray * _dataSource;
    NSMutableArray * _adsList;
    
    //标题seg基视图
    UIView * _segBackView;
    
    //顶部广告滚动视图
    ImageScrollView * _scrollHeaderView;
}

#pragma mark - 生命周期

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    [self.mainTableView reloadData];
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    [self resetParameters];
    
    _currentProductType = kProductTypeEntity;
    
    [self getProductListData];
    
    [self loadCostomViw];
    
}

- (void)setUpTableHeaderView
{
    _scrollHeaderView = [[ImageScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, GET_SCAlE_HEIGHT(145))];
//    [_scrollHeaderView setImageArray:_adsList];
    [_scrollHeaderView callBackWithBlock:^(NSInteger index) {
        
        if (_adsList.count > 0) {
            HPAddsModel * ads = _adsList[index];
            [self JumpToadvertisementWithModel:ads];
        }
        
    }];
    
    self.mainTableView.tableHeaderView = _scrollHeaderView;
}

/**
 *  初始化/重置参数
 */
- (void)resetParameters
{
    if (_dataSource == nil) {
        _dataSource = [NSMutableArray array];
    }
    [_dataSource removeAllObjects];
    _currentPage = 1;
    _totalPage = 1;
}

#pragma mark - 自定义视图

/**
 *  装载自定义视图 总览
 */
- (void)loadCostomViw
{
    [self setNavigationBarLeftButtonImage:@"search" WithTitle:@"搜索"];
    
    [self setNavigationBarRightButtonImage:@"NavBar_shopCart" WithTitle:@"购物车"];
    
    [self setUpTitleSegmentView];
    
    [self loadMainTableView];
}

/**
 *  装载主表视图
 */
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
    
    [self.mainTableView registerClass:[HotelSuppliesProductCell class] forCellReuseIdentifier:@"HotelSuppliesProductCell"];
    
    [self addpull2RefreshWithTableView:self.mainTableView];
    [self addPush2LoadMoreWithTableView:self.mainTableView];
    
    [self setUpTableHeaderView];
}

/**
 *  建立标题seg控件
 */
- (void)setUpTitleSegmentView
{
    UIView * titleBaseView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, GET_SCAlE_LENGTH(202),30)];
    [self.customNavigationBar addSubview:titleBaseView];
    [titleBaseView makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.customNavBarLeftBtn.centerY);
        make.centerX.mas_equalTo(self.customNavigationBar.centerX);
        make.size.mas_equalTo(CGSizeMake(GET_SCAlE_LENGTH(202),30));
    }];
    titleBaseView.backgroundColor = [UIColor clearColor];
    titleBaseView.layer.cornerRadius = 5;
    titleBaseView.clipsToBounds = YES;
    titleBaseView.layer.borderWidth = 1;
    titleBaseView.layer.borderColor = UIColorFromRGB(WHITECOLOR).CGColor;
    
    _segBackView = [UIView new];
    [titleBaseView addSubview:_segBackView];
    [_segBackView makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.top.mas_equalTo(titleBaseView);
        make.size.mas_equalTo(CGSizeMake((titleBaseView.frame.size.width/2.0), titleBaseView.frame.size.height));
    }];
    _segBackView.backgroundColor = UIColorFromRGB(WHITECOLOR);
    
    UIButton * leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [titleBaseView addSubview:leftButton];
    [leftButton makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.and.bottom.mas_equalTo(titleBaseView);
        make.size.mas_equalTo(CGSizeMake(titleBaseView.frame.size.width/2, titleBaseView.frame.size.height));
    }];
    [leftButton setTitle:@"酒店用品" forState:UIControlStateNormal];
    [leftButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [leftButton setTitleColor:UIColorFromRGB(LIGHTBLUECOLOR) forState:UIControlStateNormal];
    leftButton.tag = 151;
    [leftButton addTarget:self action:@selector(titleSegmentClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton * rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [titleBaseView addSubview:rightButton];
    [rightButton makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.and.bottom.mas_equalTo(titleBaseView);
        make.size.mas_equalTo(CGSizeMake(titleBaseView.frame.size.width/2, titleBaseView.frame.size.height));
    }];
    [rightButton setTitle:@"订房" forState:UIControlStateNormal];
    [rightButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [rightButton setTitleColor:UIColorFromRGB(WHITECOLOR) forState:UIControlStateNormal];
    rightButton.tag = 152;
    [rightButton addTarget:self action:@selector(titleSegmentClicked:) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - UITableviewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return (_currentProductType == kProductTypeEntity)?0:GET_SCAlE_HEIGHT(30);
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (_currentProductType == kProductTypeVirtual) {
        _cityHeadView = [[cellDemonstrationView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, GET_SCAlE_HEIGHT(30))];
        _cityHeadView.backgroundColor = UIColorFromRGB(GRAYBGCOLOR);
        
        NSDictionary * selectedCityInfo = [[AppInformationSingleton shareAppInfomationSingleton] getSelectedCityNameAndCityCode];
        NSString * cityName = selectedCityInfo[@"cityname"];
        
        [_cityHeadView setViewWithTitle:@"选择城市" SubTitle:nil RightTitle:cityName SymbolImage:[UIImage imageNamed:@"arrow_right"]];
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cityTap)];
        [_cityHeadView addGestureRecognizer:tap];
        
        return _cityHeadView;
    }else{
        UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];

        return view;
    }

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (_currentProductType) {
        case kProductTypeEntity: {
            return GET_SCAlE_HEIGHT(110);
            break;
        }
        case kProductTypeVirtual: {
            return GET_SCAlE_HEIGHT(135);
            break;
        }
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HotelSuppliesProductCell * cell = [tableView dequeueReusableCellWithIdentifier:@"HotelSuppliesProductCell"];
    
    if (_dataSource.count > 0) {
        
        switch (_currentProductType) {
            case kProductTypeEntity: {
                [cell cellForHoelSuppListVC:NO];
                [cell showDetail:YES];
                break;
            }
            case kProductTypeVirtual: {
//                cell.customStarLevelLabel.hidden = NO;
                [cell showDetail:NO];
                [cell cellForHoelSuppListVC:YES];
                
                Hotels * model = [_dataSource objectAtIndex:indexPath.row];
                
                NSDictionary * locationInfo = [[AppInformationSingleton shareAppInfomationSingleton] getLocationInfo];
                NSString * longitude = locationInfo[@"LONGITUDE"];
                NSString * latitude = locationInfo[@"LATITUDE"];
                
                NSString * distance = [self LantitudeLongitudeDist:[model.coordinatex doubleValue] other_Lat:[model.coordinatey doubleValue] self_Lon:[longitude doubleValue] self_Lat:[latitude doubleValue]];
                cell.customDistanceLabel.text = [NSString stringWithFormat:@"距离：%.2fkm",[distance doubleValue]/1000];
                break;
            }
        }
        [cell cellForRowWithModel:_dataSource[indexPath.row]];
        [cell cellShowSpecialSymbol:YES];
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (_dataSource.count > 0) {
        
        id product = _dataSource[indexPath.row];
        
        if ([product isKindOfClass:[HSProduct class]]) {
            self.hidesBottomBarWhenPushed = YES;
            HotelSuppliesCommodityDetailViewController * VC = [[HotelSuppliesCommodityDetailViewController alloc] initWithProduct:_dataSource[indexPath.row]];
            [self.navigationController pushViewController:VC animated:YES];
            self.hidesBottomBarWhenPushed = NO;
        }else{
            self.hidesBottomBarWhenPushed = YES;
            Hotels * hotel = (Hotels *)product;
            RoomReserVationDetailViewController * VC = [[RoomReserVationDetailViewController alloc] initWithHotelModel:hotel];
            [self.navigationController pushViewController:VC animated:YES];
            self.hidesBottomBarWhenPushed = NO;
        }
    }
}

#pragma mark - 事件

/**
 *  选择城市视图点击事件
 */
- (void)cityTap
{
    ChooseCityViewController * VC = [[ChooseCityViewController alloc] init];
    VC.selectedCityCallBack = ^(NSString *city, NSString *cityCode) {
//        _cityLabel.text = city;
//        _cityCode = cityCode;
        [_cityHeadView setViewWithTitle:@"选择城市" SubTitle:nil RightTitle:city SymbolImage:[UIImage imageNamed:@"arrow_right"]];
        
        [[AppInformationSingleton shareAppInfomationSingleton] setSelctedCityName:city CityCode:cityCode];
        
    };    [self presentViewController:VC animated:YES completion:^{
        
    }];
}

-(void)leftButtonClicked
{
    self.hidesBottomBarWhenPushed = YES;
    SearchViewController * VC     = [[SearchViewController alloc] initWithProductType:_currentProductType];
    [self.navigationController pushViewController:VC animated:YES];
    self.hidesBottomBarWhenPushed  = NO;
}

-(void)rightButtonClicked
{
    if (![[AppInformationSingleton shareAppInfomationSingleton] getLoginCode]) {
        NSString *showMsg = @"请先登录";
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"提示"
                                                        message: showMsg
                                                       delegate: self
                                              cancelButtonTitle:@"取消"
                                              otherButtonTitles: @"确定", nil];
        
        alert.tag = 100;
        [alert show];
        
    }else{
        
        self.hidesBottomBarWhenPushed = YES;
        ShoppingCartViewController * VC = [[ShoppingCartViewController alloc] initWithProductType:_currentProductType];
        [self.navigationController pushViewController:VC animated:YES];
        self.hidesBottomBarWhenPushed = NO;
    }
}

/**
 *  标题seg控件点击事件
 *
 *  @param sender 所点击的按钮
 */
- (void)titleSegmentClicked:(UIButton *)sender
{
    titleSortType type = sender.tag % 15;
    
    CGRect frame = _segBackView.frame;
    
    switch (type) {
        case kSortLeft: {
            
            frame.origin.x = 0;
            
            [UIView animateWithDuration:0.3 animations:^{
                _segBackView.frame = frame;
                
                [sender setTitleColor:UIColorFromRGB(LIGHTBLUECOLOR) forState:UIControlStateNormal];
                UIButton * rightBtn   = [[sender superview] viewWithTag:152];
                [rightBtn setTitleColor:UIColorFromRGB(WHITECOLOR) forState:UIControlStateNormal];
            }];
            
            [self resetParameters];
            _currentProductType = kProductTypeEntity;
            [self getProductListData];
            break;
        }
        case kSortRight: {
            
            frame.origin.x   = [sender superview].frame.size.width/2;
            
            [UIView animateWithDuration:0.3 animations:^{
                _segBackView.frame = frame;

                [sender setTitleColor:UIColorFromRGB(LIGHTBLUECOLOR) forState:UIControlStateNormal];
                UIButton * rightBtn   = [[sender superview] viewWithTag:151];
                [rightBtn setTitleColor:UIColorFromRGB(WHITECOLOR) forState:UIControlStateNormal];
            }];
            
            [self resetParameters];
            _currentProductType = kProductTypeVirtual;
//            [self getProductListData];
            [self getHotelData];
            break;
        }
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    LoginViewController * VC = [[LoginViewController alloc] init];
    UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:VC];
    [self presentViewController:nav animated:YES completion:^{
        
    }];
}


#pragma mark - 下拉刷新 & 上提加载

-(void)pull2RefreshWithScrollerView:(UIScrollView *)scrollerView
{
    [self resetParameters];
    
    switch (_currentProductType) {
        case kProductTypeEntity: {
            [self getProductListData];
            break;
        }
        case kProductTypeVirtual: {
            [self getHotelData];
            break;
        }
    }
    
}

-(void)push2LoadMoreWithScrollerView:(UIScrollView *)scrollerView
{
    
    if (_totalPage <= 1)
    {
        [self performSelector:@selector(endRefreshing) withObject:nil afterDelay:0.5];
    }
    else if (_currentPage <_totalPage)
    {
        _currentPage ++;
        [self getProductListData];
    }
    else
    {
        [self performSelector:@selector(endRefreshing) withObject:nil afterDelay:0.5];
    }
    
//    if (_currentPage < _totalPage) {
//        _currentPage ++;
//        
//        [self getProductListData];
//    }
}

#pragma mark - 网络

- (void)getHotelData
{
    
    if(![[Reachability reachabilityForInternetConnection]isReachable])
    {
        return;
    }
    
    NSMutableDictionary * headDic = [[NSMutableDictionary alloc] initWithCapacity:1];
    
    NSMutableDictionary * bodyDic = [[NSMutableDictionary alloc] initWithCapacity:1];
    [bodyDic setObject:@"hotellist" forKey:@"functionid"];
    [bodyDic setObject:@"是" forKey:@"isspecial"];
    [bodyDic setObject:[NSString stringWithFormat:@"%ld",_currentPage] forKey:@"pageno"];
    [bodyDic setObject:@"10" forKey:@"pagesize"];
    [bodyDic setObject:@"2" forKey:@"producttype"];
    
    [SVProgressHUD show];
    
    [[NetWorkSingleton sharedManager] postWithHeadParameter:headDic bodyParameter:bodyDic SuccessBlock:^(id responseBody) {
        
        [SVProgressHUD dismiss];
        
        //        HSproductListModelParser * parser = [[HSproductListModelParser alloc] initWithDictionary:responseBody];
        
        HotelModelParser * Parser = [[HotelModelParser alloc] initWithDictionary:responseBody];
        _totalPage = [Parser.hotelModel.totalpage integerValue];
        
        id arrM = responseBody[@"body"][@"hotels"];
        
        if ([arrM isKindOfClass:[NSDictionary class]]) {
            NSDictionary * dic = (NSDictionary *)arrM;
            Hotels * hotel = [Hotels modelObjectWithDictionary:dic[@"hotel"]];
            [_dataSource addObject:hotel];
        }else{
            
            for (HotelModel * product in Parser.hotelModel.hotels) {
                [_dataSource addObject:product];
            }
        }
        
        [self.mainTableView reloadData];
        [self endRefreshing];
        
    } FailureBlock:^(NSString *error) {
        
        [SVProgressHUD dismiss];
        [self endRefreshing];
        
    }];
}

- (void)getProductListData
{
    NSMutableDictionary * headDic = [[NSMutableDictionary alloc] initWithCapacity:1];
    
    NSMutableDictionary * bodyDic = [[NSMutableDictionary alloc] initWithCapacity:1];
    [bodyDic setObject:@"productlist" forKey:@"functionid"];
    [bodyDic setObject:[NSString stringWithFormat:@"%ld",_currentProductType] forKey:@"producttype"];
    [bodyDic setObject:@"是" forKey:@"isspecial"];
    [bodyDic setObject:[NSString stringWithFormat:@"%ld",_currentPage] forKey:@"pageno"];
    [bodyDic setObject:@"10" forKey:@"pagesize"];

    
    if(![[Reachability reachabilityForInternetConnection]isReachable])
    {
        return;
    }
    
    [SVProgressHUD show];
    
    [[NetWorkSingleton sharedManager] postWithHeadParameter:headDic bodyParameter:bodyDic SuccessBlock:^(id responseBody) {
        
        [SVProgressHUD dismiss];
        
//        NSLog(@"result = %@",responseBody);
        
        HSproductListModelParser * parser = [[HSproductListModelParser alloc] initWithDictionary:responseBody];
        _totalPage = [parser.productListModel.totalpage integerValue];
        
        for (HSProduct * product in parser.productListModel.product) {
            [_dataSource addObject:product];
        }
        
        _adsList = [NSMutableArray arrayWithArray:parser.productListModel.topadvs];
        [_scrollHeaderView setImageArray:_adsList];
        
        [self.mainTableView reloadData];
        [self endRefreshing];
        
    } FailureBlock:^(NSString *error) {
        
        [SVProgressHUD dismiss];
        [self endRefreshing];
        
    }];
    
}


@end
