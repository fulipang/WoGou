//
//  RoomReservatioinViewController.m
//  HomeShopping
//
//  Created by sooncong on 15/12/28.
//  Copyright © 2015年 Administrator. All rights reserved.
//

#import "RoomReservatioinViewController.h"
#import "ShoppingCartViewController.h"
#import "ImageScrollCell.h"
//#import "SCHomeNormalCell.h"
#import "SearchViewController.h"
#import "SCTableSlectionView.h"
#import "HSproductListModelParser.h"
#import "HotelSuppliesProductCell.h"
#import "BusinessCircleModelParser.h"
#import "SCSortView.h"
#import "ChooseCityViewController.h"
#import "ProductSortModelParser.h"
#import "RoomReserVationDetailViewController.h"
#import "SCSingleTableSelcetionView.h"
#import "SegmentTapView.h"
#import "LoginViewController.h"

#import "HotelModelParser.h"
#import "Hotels.h"

#import "BaiduMapHeader.h"
#import "CCLocationManager.h"


@implementation RoomReservatioinViewController
{
    // 百度自己定位封装
//    BMKLocationService *_locationService;
    CLLocationCoordinate2D _coordinate;
    
    
    NSString * _cityCode;           //之前选中城市的code
    NSString * _cityName;           //之前选中城市的名字
    NSString * _localCityName;      //当前定位城市名字
    NSDictionary * _cityCodeList;   //检索城市code的字典
    
    
    //数据源
    NSMutableArray * _dataSource;
    NSArray * _sortTitles;
    NSArray * _starLevels;
    NSArray * _businessCircleData;
    NSArray * _ADsData;
    NSArray * _leftTitles;          // 筛选视图最左侧排序标题
    
    NSMutableDictionary * _sortDic;
    NSMutableDictionary * _areaDic;
    NSMutableArray * _starLevelDic;
    NSMutableDictionary * _rightSortDic;
    NSString * _sortStarLevel;
    
    //表头
    SegmentTapView * _segmengt;
    
    //选择配置基视图
    UIView * _selectedBaseView;
    UIView * _singleBaseView;
    SCTableSlectionView * _seletedView;
    SCSingleTableSelcetionView * _singleSlectionView;
    
    //选择配置表视图
    UITableView *_leftTableView;
    UITableView *_rightTableView;
    
    //记录当前页
    NSInteger _currentPage;
    NSInteger _totalPage;
    NSInteger _currentSegIndex;
    
    //记录当前seg点击下标
    NSInteger _curentIndex;
    
    //显示城市标签
    UILabel * _cityLabel;
    
    ProductSortModel * _productSortModel;
}

#pragma mark - 生命周期

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self getBusinessCircle];
    
    [self getProductBrandListData];
    
    [self getStarlevelsData];
    
    if (_dataSource.count > 0) {
        [_dataSource removeAllObjects];
    }
    [self getHotelListData];

}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    /*
     // 用户允许定位权限
     if ([[CCLocationManager sharedManager] userAllowedLocation]) {
     
     self.locationService = [[BMKLocationService alloc] init];
     [self.locationService startUserLocationService];
     }
     
     [[CCLocationManager sharedManager] currentLocationCoordinate:^(CLLocationCoordinate2D locationCorrdinate) {
     
     _coordinate = locationCorrdinate;
     
     NSString * longitude = [NSString stringWithFormat:@"%.2f",locationCorrdinate.longitude];
     NSString * latituede = [NSString stringWithFormat:@"%.2f",locationCorrdinate.latitude];
     
     [[AppInformationSingleton shareAppInfomationSingleton] setLocationInfoWithCityName:nil CityCode:nil Longitude:longitude Latitude:latituede];
     
     [self.locationService stopUserLocationService];
     
     } address:^(NSString *address) {
     //        NSLog(@"address = %@",address);
     }];
     */
    
    // 用户允许定位权限
    if ([[CCLocationManager sharedManager] userAllowedLocation]) {
        
        self.locationService = [[BMKLocationService alloc] init];
        [self.locationService startUserLocationService];
    }
    
    [[CCLocationManager sharedManager] currentLocationCoordinate:^(CLLocationCoordinate2D locationCorrdinate) {
        
        _coordinate = locationCorrdinate;
        
        NSString * longitude = [NSString stringWithFormat:@"%.2f",locationCorrdinate.longitude];
        NSString * latituede = [NSString stringWithFormat:@"%.2f",locationCorrdinate.latitude];
        
        [[AppInformationSingleton shareAppInfomationSingleton] setLocationInfoWithCityName:nil CityCode:nil Longitude:longitude Latitude:latituede];
        [self.locationService stopUserLocationService];

    } address:^(NSString *address) {
        NSLog(@"address = %@",address);
    }];
    
    [[CCLocationManager sharedManager] currentCity:^(NSString *city) {
        
        _localCityName = city;
        _cityCodeList = [[AppInformationSingleton shareAppInfomationSingleton] getCityCodeList];
        
        if (![city isEqualToString:_cityName]) {
            NSString *showMsg = [NSString stringWithFormat:@"您当前选择的城市为%@,是否切换为%@",_cityName,city];
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle: showMsg
                                                            message: nil
                                                           delegate: self
                                                  cancelButtonTitle:@"取消"
                                                  otherButtonTitles: @"确定", nil];
            alert.tag = 300;
            
            [alert show];
        }
        
    }];;
    
    
    [self initDataSource];
    
    [self loadCustomView];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.locationService stopUserLocationService];
}


#pragma mark - 自定义视图

- (void)loadCustomView
{
    
    [self customNavigationBar];
    
    [self setNavigationBarRightButtonImage:@"NavBar_shopCart" WithTitle:@"购物车"];
    
    [self SetupSearchButton];
    
    [self setUpLeftButton];
    
    //    [self loadUpImageScrollView];
    //
    //    [self setUpCustomSegView];
    
    [self setUpMainTableView];
    
}

- (void)setUpLeftButton
{
    UIView * cityBaseView = [UIView new];
    [self.customNavigationBar addSubview:cityBaseView];
    [cityBaseView makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.customNavBarRightBtn.centerY);
        make.left.mas_equalTo(self.customNavigationBar.left);
        make.size.mas_equalTo(CGSizeMake(GET_SCAlE_LENGTH(70), 30));
    }];
    
    UIImageView * arrow = [UIImageView new];
    arrow.image = [UIImage imageNamed:@"RR_arrow_done"];
    [self.customNavigationBar addSubview:arrow];
    [arrow makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(cityBaseView.right).with.offset(GET_SCAlE_LENGTH(-8));
        make.centerY.mas_equalTo(cityBaseView.centerY);
        make.size.mas_equalTo(CGSizeMake(arrow.image.size.width, arrow.image.size.height));
    }];
    
    _cityLabel  = [UILabel new];
    [cityBaseView addSubview:_cityLabel];
    [_cityLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(cityBaseView.mas_centerY).with.offset(0);
        make.right.mas_equalTo(arrow.left).with.offset(GET_SCAlE_LENGTH(-2));
        make.left.mas_equalTo(cityBaseView.left);
    }];
    _cityLabel.textColor = UIColorFromRGB(WHITECOLOR);
    _cityLabel.font = [UIFont systemFontOfSize:NORMALFONTSIZE];
    
    NSDictionary * selectedInfo = [[AppInformationSingleton shareAppInfomationSingleton] getSelectedCityNameAndCityCode];
    _cityName = selectedInfo[@"cityname"];
    _cityCode = selectedInfo[@"citycode"];
    
    if (_cityName) {
        _cityLabel.text = _cityName;
    }else{
        _cityName = @"广州市";
        _cityLabel.text = _cityName;
    }
    
    _cityLabel.textAlignment = NSTextAlignmentRight;
    [_cityLabel adjustsFontSizeToFitWidth];
    
    //添加收拾
    UITapGestureRecognizer * cityTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cityTap)];
    [cityBaseView addGestureRecognizer:cityTap];
}

/**
 *  设置搜索栏
 */
-(void)SetupSearchButton
{
    //初始化
    UIButton * searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.customNavigationBar addSubview:searchButton];
    
    //位置
    [searchButton makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.customNavigationBar.mas_centerX).with.offset(5);
        make.centerY.mas_equalTo(self.customNavBarRightBtn.centerY);
        make.size.mas_equalTo(CGSizeMake(GET_SCAlE_LENGTH(190), 30));
    }];
    
    //参数配置
    [searchButton setTitle:@"搜索酒店" forState:UIControlStateNormal];
    [searchButton setTitle:@"搜索酒店" forState:UIControlStateHighlighted];
    [searchButton setTitleColor:UIColorFromRGB(GRAYFONTCOLOR) forState:UIControlStateNormal];
    [searchButton setTitleColor:UIColorFromRGB(GRAYFONTCOLOR) forState:UIControlStateHighlighted];
    [searchButton setBackgroundImage:[UIImage imageNamed:@"NavBar_search"] forState:UIControlStateNormal];
    [searchButton setBackgroundImage:[UIImage imageNamed:@"NavBar_search"] forState:UIControlStateHighlighted]
    ;
    searchButton.titleLabel.font = [UIFont systemFontOfSize:NORMALFONTSIZE];
    [searchButton addTarget:self action:@selector(searchButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    
}

/**
 *  初始化数据
 */

- (void)initDataSource
{
    _dataSource   = [NSMutableArray array];
    _starLevelDic = [NSMutableArray array];
    
    _sortDic      = [[NSMutableDictionary alloc] initWithCapacity:1];
    _areaDic      = [[NSMutableDictionary alloc] initWithCapacity:1];
    _rightSortDic = [[NSMutableDictionary alloc] initWithCapacity:1];

    _sortTitles      = [self createSegTitles];
    _leftTitles      = [self createLeftTitles];
    _currentPage     = 1;
    _currentSegIndex = 1;

}

- (NSArray *)createSegTitles
{
    return [NSArray arrayWithObjects:@"默认排序",@"商圈",@"全部",@"筛选", nil];
}

- (NSArray *)createLeftTitles
{
    return [NSArray arrayWithObjects:@"默认排序",@"评分最高",@"价格最低",@"价格最高",@"销量最高", nil];
}

- (void)setUpMainTableView
{
    self.mainTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.view addSubview:self.mainTableView];
    
    [self.mainTableView makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.customNavigationBar.mas_bottom);
        make.left.right.and.bottom.mas_equalTo(self.view);
    }];
    
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    
    [self.mainTableView registerClass:[ImageScrollCell class] forCellReuseIdentifier:@"ImageScrollCell"];
    [self.mainTableView registerClass:[HotelSuppliesProductCell class] forCellReuseIdentifier:@"HotelSuppliesProductCell"];
    
    [self addPush2LoadMoreWithTableView:self.mainTableView];
    [self addpull2RefreshWithTableView:self.mainTableView];
    self.mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}

- (void)loadUpImageScrollView
{
    self.topImageScrollView = [[ImageScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200)];
    [self.view addSubview:self.topImageScrollView];
    
    [self.topImageScrollView setImageArray:_ADsData];
    [self.topImageScrollView callBackWithBlock:^(NSInteger index) {
        
        if (_ADsData.count > 0) {
            HSAdsLists * ads = _ADsData[index];
            [self JumpToadvertisementWithModel:ads];
        }
    }];
    
    [self.view bringSubviewToFront:self.customNavigationBar];
}

#pragma mark - UITableViewDelagate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return (section == 0)?0:GET_SCAlE_HEIGHT(35);
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return nil;
    }else{
        
        if (_segmengt == nil) {
            _segmengt = [[SegmentTapView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, GET_SCAlE_HEIGHT(35)) withDataArray:_sortTitles withFont:NORMALFONTSIZE];
            [_segmengt setTextColor:UIColorFromRGB(GRAYFONTCOLOR) SelectedColor:UIColorFromRGB(LIGHTBLUECOLOR) NoticeViewColor:UIColorFromRGB(LIGHTBLUECOLOR)];
            _segmengt.delegate = self;
            
            UILabel * line = [UILabel new];
            [_segmengt addSubview:line];
            [line makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.mas_equalTo(_segmengt.mas_bottom);
                make.centerX.mas_equalTo(_segmengt.mas_centerX);
                make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 0.5));
            }];
            line.backgroundColor = UIColorFromRGB(LINECOLOR);
        }
        
        return _segmengt;
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return (section == 0)?1:_dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        ImageScrollCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ImageScrollCell"];
        [cell setCellHeight:GET_SCAlE_HEIGHT(140)];
        [cell callBackMethod:^(NSInteger index) {
            
            if (_ADsData.count > 0) {
                HPAddsModel * ads = _ADsData[index];
                [self JumpToadvertisementWithModel:ads];
            }
        }];
        [cell setImageArray:_ADsData];
        
        return cell;
    }else{
        
        HotelSuppliesProductCell * cell = [tableView dequeueReusableCellWithIdentifier:@"HotelSuppliesProductCell"];
        if (_dataSource.count > 0) {
            [cell cellForRowWithHotelModel:_dataSource[indexPath.row]];
            [cell cellShowSpecialSymbol:NO];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            Hotels * model = _dataSource[indexPath.row];
            
            NSString * distance = [self LantitudeLongitudeDist:[model.coordinatex doubleValue] other_Lat:[model.coordinatey doubleValue] self_Lon:_coordinate.longitude self_Lat:_coordinate.latitude];
            cell.customDistanceLabel.text = [NSString stringWithFormat:@"距离：%.2fkm",[distance doubleValue]/1000];
        }
        return cell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return (indexPath.section == 0)?GET_SCAlE_HEIGHT(140):GET_SCAlE_HEIGHT(135);
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Hotels * hotel = _dataSource[indexPath.row];
    self.hidesBottomBarWhenPushed = YES;
    RoomReserVationDetailViewController * VC = [[RoomReserVationDetailViewController alloc] initWithHotelModel:hotel];
    [self.navigationController pushViewController:VC animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}

/**
 *  下拉刷新
 *
 *  @param scrollerView
 */
-(void)pull2RefreshWithScrollerView:(UIScrollView *)scrollerView
{
    [self resetParameter];
    
    [self getHotelListData];
}

/**
 *  上提加载
 *
 *  @param scrollerView
 */
- (void)push2LoadMoreWithScrollerView:(UIScrollView *)scrollerView
{
    if (_totalPage <= 1) {
        [self performSelector:@selector(endRefreshing) withObject:nil afterDelay:1];
    }
    
    else if (_currentPage < _totalPage) {
        _currentPage ++;
        [self getHotelListData];
    }
}

- (void)resetParameter
{
    _sortStarLevel = nil;
    _currentPage = 1;
    [_sortDic removeAllObjects];
    [_areaDic removeAllObjects];
    [_rightSortDic removeAllObjects];
    [_dataSource removeAllObjects];
}

#pragma mark - 事件

- (void)rightButtonClicked
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
        ShoppingCartViewController * VC = [[ShoppingCartViewController alloc] initWithProductType:kProductTypeVirtual];
        [self.navigationController pushViewController:VC animated:YES];
        self.hidesBottomBarWhenPushed = NO;
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{

    if (buttonIndex == 1) {
        
        if (alertView.tag == 300) {
            
            _cityLabel.text = _localCityName;
            
            if (_cityCode) {
                _cityCode = _cityCodeList[_localCityName];
            }else{
                [self cityTap];
            }
            
            [[AppInformationSingleton shareAppInfomationSingleton] setSelctedCityName:_cityName CityCode:_cityCode];
            
            [self getBusinessCircle];
            
            [_dataSource removeAllObjects];
            [self getHotelListData];
            
        }else{
            LoginViewController * VC = [[LoginViewController alloc] init];
            UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:VC];
            [self presentViewController:nav animated:YES completion:^{
                
            }];
        }
    }
}

- (void)searchButtonClicked
{

    self.hidesBottomBarWhenPushed = YES;
    SearchViewController * VC = [[SearchViewController alloc] initWithProductType:kProductTypeVirtual];
    [self.navigationController pushViewController:VC animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}

- (void)cityTap
{
    ChooseCityViewController * VC = [[ChooseCityViewController alloc] init];
    VC.selectedCityCallBack = ^(NSString *city, NSString *cityCode) {
        _cityLabel.text = city;
        _cityCode = cityCode;
    };
    [self presentViewController:VC animated:YES completion:^{
        
    }];

}

- (void)maskViewTaped
{
    [self hideSingleSelectionView];
    [self hideSelectedView];
    [self removeMask];
}

#pragma mark - 网络

/**
 *  获取星级商家数据
 */
- (void)getStarlevelsData
{
    if(![[Reachability reachabilityForInternetConnection]isReachable])
    {
        return;
    }
    
    NSMutableDictionary * headDic = [[NSMutableDictionary alloc] initWithCapacity:1];
    NSMutableDictionary * bodyDic = [[NSMutableDictionary alloc] initWithCapacity:1];
    [bodyDic setObject:@"getstarlevel" forKey:@"functionid"];
    
    [[NetWorkSingleton sharedManager] postWithHeadParameter:headDic bodyParameter:bodyDic SuccessBlock:^(id responseBody) {
        
        _starLevelDic = [responseBody objectForKey:@"body"][@"starlevels"][@"starlevel"];
        [_starLevelDic insertObject:@"全部" atIndex:0];
        
    } FailureBlock:^(NSString *error) {
        [self getStarlevelsData];
    }];
}

/**
 *  获取商品列表数据
 */
- (void)getHotelListData
{
    
    if(![[Reachability reachabilityForInternetConnection]isReachable])
    {
        return;
    }
    
    NSMutableDictionary * headDic = [[NSMutableDictionary alloc] initWithCapacity:1];
    
    NSMutableDictionary * bodyDic = [[NSMutableDictionary alloc] initWithCapacity:1];
    [bodyDic setObject:@"hotellist" forKey:@"functionid"];
    if (_cityCode) {
        [bodyDic setObject:_cityCode forKey:@"citycode"];
    }
    [bodyDic setObject:[NSString stringWithFormat:@"%ld",_currentPage] forKey:@"pageno"];
    [bodyDic setObject:@"10" forKey:@"pagesize"];
    [bodyDic setObject:@"2" forKey:@"producttype"];
    
    if (_sortDic.count > 0) {
        [bodyDic setObject:_sortDic[@"sortfield"] forKey:@"sortfield"];
        [bodyDic setObject:_sortDic[@"sorttype"] forKey:@"sorttype"];
    }
    
    if (_rightSortDic.count > 0) {
        for (NSString * key in _rightSortDic.allKeys) {
            [bodyDic setObject:_rightSortDic[key] forKey:key];
        }
    }
    
    if (_sortStarLevel) {
        [bodyDic setObject:_sortStarLevel forKey:@"starlevel"];
    }
    
    if (_areaDic.count > 0) {
        for (NSString * key in _areaDic.allKeys) {
            [bodyDic setObject:_areaDic[key] forKey:key];
        }
    }
    
    
    [SVProgressHUD show];
    
    [[NetWorkSingleton sharedManager] postWithHeadParameter:headDic bodyParameter:bodyDic SuccessBlock:^(id responseBody) {
        
        [SVProgressHUD dismiss];
        

        HotelModelParser * Parser = [[HotelModelParser alloc] initWithDictionary:responseBody];
        
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
        
        _totalPage = [Parser.hotelModel.totalpage integerValue];
        _ADsData = [NSArray arrayWithArray:Parser.hotelModel.topadvs];
        
        if (_dataSource.count == 0) {
            [self showEmptyViewWithTableView:self.mainTableView];
        }else{
            [self removeEmptyViewWithTableView:self.mainTableView];
        }
        
        [self.mainTableView reloadData];
        [self endRefreshing];
        
    } FailureBlock:^(NSString *error) {
        
        [SVProgressHUD dismiss];
        [self endRefreshing];
        
    }];
}

-(void)getBusinessCircle
{
    NSMutableDictionary * headDic = [[NSMutableDictionary alloc] initWithCapacity:1];
    NSMutableDictionary * bodyDic = [[NSMutableDictionary alloc] initWithCapacity:1];
    
    [bodyDic setObject:@"getbussinessarea" forKey:@"functionid"];
    if (_cityCode) {
        [bodyDic setObject:_cityCode forKey:@"citycode"];
    }
    
    [[NetWorkSingleton sharedManager] postWithHeadParameter:headDic bodyParameter:bodyDic SuccessBlock:^(id responseBody) {
        
        BusinessCircleModelParser * parser = [[BusinessCircleModelParser alloc] initWithDictionary:responseBody];
        _businessCircleData = [NSArray arrayWithArray:parser.businessCircleModel.areas];
        
    } FailureBlock:^(NSString *error) {
        
    }];
}

/**
 *  获取品牌列表
 */
-(void)getProductBrandListData
{
    if(![[Reachability reachabilityForInternetConnection]isReachable])
    {
        return;
    }
    
    NSMutableDictionary * headDic = [[NSMutableDictionary alloc] initWithCapacity:1];
    
    NSMutableDictionary * bodyDic = [[NSMutableDictionary alloc] initWithCapacity:1];
    [bodyDic setObject:@"productbrandlist" forKey:@"functionid"];
    
    [[NetWorkSingleton sharedManager] postWithHeadParameter:headDic bodyParameter:bodyDic SuccessBlock:^(id responseBody) {
        
        ProductSortModelParser * parser = [[ProductSortModelParser alloc] initWithDictionary:responseBody];
        _productSortModel = parser.productSortModel;
        
    } FailureBlock:^(NSString *error) {
        
    }];
}

#pragma  mark - SegmentTapViewDelegate

-(void)selectedIndex:(NSInteger)index
{
    RoomReservationTapType type = index;
    _curentIndex = type;
    
    switch (type) {
        case kTapDefaultSort: {
            [self showSingleSelctionViewWithTitles:_leftTitles];
            
            break;
        }
        case kTapBusinessCircle: {
            [self showSeletedView];
            break;
        }
        case kTapAll: {
            [self showSingleSelctionViewWithTitles:_starLevelDic];
            break;
        }
        case kTapSort: {
            
            [self hideSelectedView];
            [self hideSingleSelectionView];
            
            SCSortView * sortView = [[SCSortView alloc] initWithFrame:CGRectMake(GET_SCAlE_LENGTH(50), 0, SCREEN_WIDTH - GET_SCAlE_LENGTH(50), SCREEN_HEIGHT)];
            [self.view addSubview:sortView];
            [self addMaskViewWithShowView:sortView];
            [sortView setParameterWithModle:_productSortModel NeedBook:YES];
            [sortView callBackWithBlock:^(NSDictionary *diliverDictionary) {
                
                if (diliverDictionary) {
                    [_rightSortDic setDictionary:diliverDictionary];
                    [_dataSource removeAllObjects];
                    [self getHotelListData];
                }
                
                [sortView removeFromSuperview];
                [self removeMask];
            }];
            break;
        }
    }
}

#pragma mark - 商圈筛选视图


/**
 *  显示筛选表视图
 */
- (void)showSeletedView
{
    [self hideSingleSelectionView];
    
    self.mainTableView.scrollEnabled = NO;
    
    if (_selectedBaseView != nil) {
        [_selectedBaseView updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_segmengt.bottom);
        }];
        
        
        return;
    }
    
    //基视图
    _selectedBaseView = [UIView new];
    [self.mainTableView addSubview:_selectedBaseView];
    [_selectedBaseView makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_segmengt.bottom);
        make.centerX.mas_equalTo(_segmengt.centerX);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, GET_SCAlE_HEIGHT(1000)));
    }];
    _selectedBaseView.backgroundColor = [UIColor clearColor];
    
    //自定义筛选用复合表视图
    _seletedView = [[SCTableSlectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, GET_SCAlE_HEIGHT(160))];
    [_selectedBaseView addSubview:_seletedView];
    //    [_selectedBaseView addSubview:_seletedView];
    [_seletedView makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_segmengt.bottom);
        make.centerX.mas_equalTo(_segmengt.centerX);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, GET_SCAlE_HEIGHT(160)));
    }];
    [_seletedView setParameterWithDataSource:_businessCircleData];
    _seletedView.delegate = self;
    
    //蒙版
    UIView * maskView = [UIView new];
    [_selectedBaseView addSubview:maskView];
    [maskView makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_seletedView.bottom);
        make.centerX.mas_equalTo(_segmengt.centerX);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, GET_SCAlE_HEIGHT(1000 - 160)));
    }];
    maskView.backgroundColor = UIColorFromRGB(BLACKCOLOR);
    maskView.alpha = 0.2;
    
    UITapGestureRecognizer * maskSlectedTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(maskViewTaped)];
    [maskView addGestureRecognizer:maskSlectedTap];
    
}

-(void)seletedArea:(Areas *)area subArea:(Subareas *)subArea
{
//    NSLog(@"area = %@  subarea = %@",area.title,subArea.subtitle);
    
    if (subArea) {
        [_areaDic setObject:subArea.subareaid forKey:@"areacode"];
    }else{
        [_areaDic setObject:area.areaid forKey:@"areacode"];
    }
    
//    [_areaDic setObject:subArea.subareaid forKey:@"subareaid"];
//    [_areaDic setObject:area.areaid forKey:@"areaid"];
    [_dataSource removeAllObjects];
    [self getHotelListData];
    [self hideSelectedView];
}

/**
 *  隐藏筛选表视图
 */
- (void)hideSelectedView;
{
    self.mainTableView.scrollEnabled = YES;
    
    [_selectedBaseView removeFromSuperview];
    _selectedBaseView = nil;
}

#pragma mark - 单表视图筛选界面


- (void)showSingleSelctionViewWithTitles:(NSArray *)titles
{
    [self hideSelectedView];
    [self hideSingleSelectionView];
    
    self.mainTableView.scrollEnabled = NO;
    
    if (_selectedBaseView) {
        
        [_singleSlectionView updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_segmengt.bottom);
        }];
        return;
    }
    
    //基视图
    _singleBaseView = [UIView new];
    [self.mainTableView addSubview:_singleBaseView];
    [_singleBaseView makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_segmengt.bottom);
        make.centerX.mas_equalTo(_segmengt.centerX);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, GET_SCAlE_HEIGHT(1000)));
    }];
    _selectedBaseView.backgroundColor = [UIColor clearColor];
    
    _singleSlectionView = [[SCSingleTableSelcetionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, GET_SCAlE_HEIGHT(160))];
    [_singleBaseView addSubview:_singleSlectionView];

    //设置标题
    [_singleSlectionView setParameterWithDataSource:titles];
    [_singleSlectionView makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.centerX);
        make.top.mas_equalTo(_segmengt.bottom);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, GET_SCAlE_HEIGHT(160)));
    }];
    _singleSlectionView.delegate = self;
    
    UIView * maskView = [UIView new];
    [_singleBaseView addSubview:maskView];
    [maskView makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_singleSlectionView.bottom);
        make.centerX.mas_equalTo(_segmengt.centerX);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, GET_SCAlE_HEIGHT(1000 - 160)));
    }];
    maskView.backgroundColor = UIColorFromRGB(BLACKCOLOR);
    maskView.alpha = 0.2;
    
    UITapGestureRecognizer * singleMaskTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(maskViewTaped)];
    [maskView addGestureRecognizer:singleMaskTap];
}

- (void)seletedAtIndex:(NSInteger)index Title:(NSString *)title
{
    if (_curentIndex == kTapDefaultSort) {
        switch (index) {
            case 0:
                [_sortDic setObject:@"4" forKey:@"sortfield"];
                [_sortDic setObject:@"2" forKey:@"sorttype"];
                break;
                
            case 1:
                [_sortDic setObject:@"3" forKey:@"sortfield"];
                [_sortDic setObject:@"2" forKey:@"sorttype"];
                break;
                
            case 2:
                [_sortDic setObject:@"1" forKey:@"sortfield"];
                [_sortDic setObject:@"1" forKey:@"sorttype"];
                break;
                
            case 3:
                [_sortDic setObject:@"1" forKey:@"sortfield"];
                [_sortDic setObject:@"2" forKey:@"sorttype"];
                break;
                
            case 4:
                [_sortDic setObject:@"2" forKey:@"sortfield"];
                [_sortDic setObject:@"2" forKey:@"sorttype"];
                break;
                
            default:
                break;
        }
    }
    
    if (_curentIndex == kTapAll) {
        //        [_sortDic setObject:_starLevelDic[index] forKey:@"starlevel"];
        NSString * star = _starLevelDic[index];
        _sortStarLevel = star;
    }
    
    [_dataSource removeAllObjects];
    [self getHotelListData];
    
    [self hideSingleSelectionView];
}

/**
 *  隐藏单表格筛选视图
 */
- (void)hideSingleSelectionView
{
    self.mainTableView.scrollEnabled = YES;
    
    [_singleBaseView removeFromSuperview];
    _singleBaseView = nil;
}

- (void)showEmptyViewWithTableView:(UITableView *)tableView
{
    if (self.emptyImageView != nil) {
        return;
    }
    
    UIImage * emptyImage = [UIImage imageNamed:@"noneImage"];
    
    self.emptyImageView = [UIView new];
    [tableView addSubview:self.emptyImageView];
    [self.emptyImageView makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(tableView.centerX);
        make.centerY.mas_equalTo(tableView.centerY).with.offset(GET_SCAlE_HEIGHT(70));
        make.size.mas_equalTo(CGSizeMake(emptyImage.size.width, emptyImage.size.height + GET_SCAlE_HEIGHT(60)));
    }];
    
    UIImageView * emptyImageView = [UIImageView new];
    [self.emptyImageView addSubview:emptyImageView];
    emptyImageView.image = emptyImage;
    [emptyImageView makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(tableView.centerX);
        make.centerY.mas_equalTo(tableView.centerY).with.offset(GET_SCAlE_HEIGHT(70));
        make.size.mas_equalTo(CGSizeMake(emptyImageView.image.size.width, emptyImageView.image.size.height));
    }];
    
    UILabel * titleLabel  = [UILabel new];
    [self.emptyImageView addSubview:titleLabel];
    [titleLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(emptyImageView.centerX).with.offset(0);
        make.bottom.mas_equalTo(self.emptyImageView.bottom);
    }];
    titleLabel.textColor = UIColorFromRGB(BLACKFONTCOLOR);
    titleLabel.font = [UIFont systemFontOfSize:TITLENAMEFONTSIZE];
    titleLabel.text = @"暂时没发现更多内容";
    
}

-(void)removeEmptyViewWithTableView:(UITableView *)tableView
{
    [self.emptyImageView removeFromSuperview];
    self.emptyImageView = nil;
}

#pragma mark - utilityMethod

-(void)maskTap
{
    
}


-(void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
