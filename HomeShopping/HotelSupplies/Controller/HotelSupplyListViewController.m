//
//  HotelSupplyListView.m
//  HomeShopping
//
//  Created by sooncong on 15/12/23.
//  Copyright © 2015年 Administrator. All rights reserved.
//

#import "HotelSupplyListViewController.h"
#import "HotelSuppliesCommodityDetailViewController.h"
#import "SearchViewController.h"
#import "ShoppingCartViewController.h"
#import "LoginViewController.h"

//cell
#import "HotelSuppliesProductCell.h"

//模型
#import "ProductSortModelParser.h"
#import "HSproductListModelParser.h"
#import "PossibleLikeModelParser.h"
#import "HotelModelParser.h"



@implementation HotelSupplyListViewController
{
    UITableView * _mainTableView;
    
    //数据源
    NSMutableArray * _dataSource;
    ProductSortModel * _productSortModel;
    
    //筛选标题数组
    NSArray * _screeningTitles;
    //    NSArray * _sortTitles;
    
    //筛选tableview
    UITableView * _screeningTableView;
    
    //蒙版
    CALayer * _maskLayer;
    
    //筛选字典
    NSMutableDictionary * _sortDic;
    NSMutableDictionary * _SCSottDic;
    
    //记录当前页数
    NSInteger _currentPage;
    NSInteger _totalPage;
    
    //筛选视图
    SCSortView * _sortView;
    
    HPCategorysModel * _category;
    
    NSString * _categoryID;
    NSString * _starLevel;
    
}

-(instancetype)initWithCategoryID:(NSString *)categoryId
{
    self = [super init];
    
    if (self) {
        
        _categoryID = categoryId;
    }
    
    return self;
}

-(instancetype)initWithCategoryModel:(HPCategorysModel *)category
{
    self = [super init];
    
    if (self) {
        _category = category;
    }
    
    return self;
}

-(instancetype)initWithStarLevels:(NSString *)starLevel
{
    self = [super init];
    
    if (self) {
        
        _starLevel = starLevel;
        _isHotel = YES;
    }
    
    return self;
}

#pragma mark - 生命周期

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    [self loadCustomView];
    
    if (_isHotel) {
        [self getHotelListData];
    }else{
        [self getProductListData];
    }
    
    [self getProductBrandListData];
}

#pragma mark - 自定义视图

/**
 *  总控
 */
- (void)loadCustomView
{
    [self setUpCustomNavigationBar];
    
    [self setUpCustomView];
    
    [self initDataSource];
    
    [self setUpSreeningView];
    
}

/**
 *  创建筛选表视图
 */
- (void)setUpSreeningView
{
    _screeningTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.view addSubview:_screeningTableView];
    [_screeningTableView makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.mas_equalTo(self.view);
        make.top.mas_equalTo(_mainTableView.mas_top);
        make.height.mas_equalTo(CGSizeMake(SCREEN_WIDTH, GET_SCAlE_LENGTH(150)));
    }];
    _screeningTableView.backgroundColor = UIColorFromRGB(LIGHTBLUECOLOR);
    _screeningTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _screeningTableView.scrollEnabled = NO;
    
    _screeningTableView.delegate = self;
    _screeningTableView.dataSource = self;
    
    //CALayer
    _maskLayer = [[CALayer alloc] init];
    _maskLayer.backgroundColor = [UIColor blackColor].CGColor;
    _maskLayer.frame = CGRectMake(0, 99 + GET_SCAlE_HEIGHT(150), SCREEN_WIDTH, SCREEN_HEIGHT - 99 - GET_SCAlE_HEIGHT(150));
    _maskLayer.opacity = 0.2;
    [self.view.layer addSublayer: _maskLayer];
    
    _screeningTableView.hidden = YES;
    _maskLayer.hidden = YES;
}

- (void)setUpCustomView
{
    [self setUpMainTableView];
    
    [self setUpFliterView];
}

- (void)setUpMainTableView
{
    _mainTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.view addSubview:_mainTableView];
    [_mainTableView makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.customNavigationBar.mas_bottom).with.offset(GET_SCAlE_HEIGHT(30));
        make.left.right.and.bottom.mas_equalTo(self.view);
    }];
    
    _mainTableView.delegate = self;
    _mainTableView.dataSource = self;
    _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //    _mainTableView.backgroundColor = [UIColor orangeColor];
    
    //添加上提加载和下拉刷新
    [self addpull2RefreshWithTableView:_mainTableView];
    [self addPush2LoadMoreWithTableView:_mainTableView];
    
    [_mainTableView registerClass:[HotelSuppliesProductCell class] forCellReuseIdentifier:@"productCell"];
}

- (void)setUpCustomNavigationBar
{
    [self setNavigationBarLeftButtonImage:@"NavBar_Back"];
    
    [self setNavigationBarRightButtonImage:@"NavBar_shopCart" WithTitle:@"购物车"];
    
    [self createSearchButton];
}

-(void)setUpFliterView
{
    //筛选
    UIView *filterView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, GET_SCAlE_HEIGHT(30))];
    filterView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:filterView];
    
    NSArray *filterName = @[@"默认排序",@"筛选"];
    //筛选
    for (int i = 0; i < 2; i++) {
        //文字
        UIButton *filterBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        filterBtn.frame = CGRectMake(i*SCREEN_WIDTH/2, 0, SCREEN_WIDTH/2-15, 30);
        filterBtn.tag = 100+i;
        filterBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        [filterBtn setTitle:filterName[i] forState:UIControlStateNormal];
        [filterBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [filterBtn setTitleColor:UIColorFromRGB(LIGHTBLUECOLOR) forState:UIControlStateSelected];
        [filterBtn addTarget:self action:@selector(filterButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [filterView addSubview:filterBtn];
    }
    
    UILabel * bottom_line = [UILabel new];
    [filterView addSubview:bottom_line];
    [bottom_line makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(filterView.mas_bottom);
        make.centerX.mas_equalTo(filterView.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 1));
    }];
    bottom_line.backgroundColor = UIColorFromRGB(GRAYBGCOLOR);
    
    UILabel * line = [UILabel new];
    [filterView addSubview:line];
    [line makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(filterView.mas_centerY);
        make.centerX.mas_equalTo(filterView.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(1, 30));
    }];
    line.backgroundColor = UIColorFromRGB(GRAYBGCOLOR);
}

- (void)createSearchButton
{
    UIButton * searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.customNavigationBar addSubview:searchBtn];
    [searchBtn makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.customNavigationBar.mas_centerX);
        make.bottom.mas_equalTo(self.customNavigationBar.mas_bottom).with.offset(-5);
        make.size.mas_equalTo(CGSizeMake(GET_SCAlE_LENGTH(220), 31));
    }];
    [searchBtn setTitle:@"搜索酒店用品/酒店" forState:UIControlStateNormal];
    [searchBtn setTitle:@"搜索酒店用品/酒店" forState:UIControlStateHighlighted];
    [searchBtn setTitleColor:UIColorFromRGB(GRAYFONTCOLOR) forState:UIControlStateNormal];
    [searchBtn setTitleColor:UIColorFromRGB(GRAYFONTCOLOR) forState:UIControlStateHighlighted];
    [searchBtn setBackgroundImage:[UIImage imageNamed:@"NavBar_search"] forState:UIControlStateNormal];
    [searchBtn setBackgroundImage:[UIImage imageNamed:@"NavBar_search"] forState:UIControlStateHighlighted]
    ;
    searchBtn.titleLabel.font = [UIFont systemFontOfSize:NORMALFONTSIZE];
    [searchBtn addTarget:self action:@selector(searchButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    
}

#pragma mark - 初始化数据

- (void)initDataSource
{
    _dataSource = [NSMutableArray array];
    
    [self resetParameter];
    
    _screeningTitles = [self createSelectedArray];
    
    _sortDic = [NSMutableDictionary dictionary];
    _SCSottDic = [[NSMutableDictionary alloc] init];
}

- (NSArray *)createSelectedArray
{
    return [NSArray arrayWithObjects:@"默认排序",@"评分最高",@"价格最低",@"价格最高",@"销量最高", nil];
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView == _mainTableView) {
        return (_isHotel)?GET_SCAlE_HEIGHT(135):GET_SCAlE_HEIGHT(115);
    }
    else{
        return GET_SCAlE_HEIGHT(30);
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return (tableView == _mainTableView)?(_dataSource.count):5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView == _mainTableView) {
        
        HotelSuppliesProductCell * cell = [tableView dequeueReusableCellWithIdentifier:@"productCell"];
        if (_dataSource.count > 0 ) {
            [cell showDetail:YES];
            [cell cellForHoelSuppListVC:_isHotel];
            [cell cellForRowWithModel:_dataSource[indexPath.row]];

            if (_isHotel) {
                NSDictionary * locationInfo = [[AppInformationSingleton shareAppInfomationSingleton] getLocationInfo];
                NSString * longitude = locationInfo[@"LONGITUDE"];
                NSString * latitude = locationInfo[@"LATITUDE"];
                Hotels * model = _dataSource[indexPath.row];
                
                NSString * distance = [self LantitudeLongitudeDist:[model.coordinatex doubleValue] other_Lat:[model.coordinatey doubleValue] self_Lon:[longitude doubleValue] self_Lat:[latitude doubleValue]];
                
                cell.customDistanceLabel.text = [NSString stringWithFormat:@"距离：%.2fkm",[distance doubleValue]/1000];
                
            }
            
//            [cell cellForHoelSuppListVC:YES];
        }
        
        return cell;
    }
    //    else if (tableView == _screeningTableView)
    else
    {
        
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
            UILabel * line = [UILabel new];
            [cell.contentView addSubview:line];
            [line makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.mas_equalTo(cell.contentView.mas_bottom);
                make.centerX.mas_equalTo(cell.contentView.mas_centerX);
                make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 1));
            }];
            line.backgroundColor = UIColorFromRGB(GRAYBGCOLOR);
            
            UILabel * titleLabel = [UILabel new];
            [cell.contentView addSubview:titleLabel];
            [titleLabel makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(cell.contentView.centerY);
                make.left.mas_equalTo(cell.contentView.mas_left).with.offset(GET_SCAlE_LENGTH(45));
            }];
            titleLabel.text = _screeningTitles[indexPath.row];
            titleLabel.font = [UIFont systemFontOfSize:NORMALFONTSIZE];
        }
        
        return cell;
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _screeningTableView) {
        
        switch (indexPath.row) {
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
        
        [self HiddenScreeningView:YES];
        
        if (_isHotel) {
            [self getHotelListData];
        }else{
            [self getProductListData];
        }
    }
    
    if (tableView == _mainTableView){
        if (_dataSource.count > 0) {
            HSProduct * product = _dataSource[indexPath.row];
            self.hidesBottomBarWhenPushed = YES;
            if (_isHotel) {
                RoomReserVationDetailViewController * VC = [[RoomReserVationDetailViewController alloc] initWithSellerID:product.sellerid];
                [self.navigationController pushViewController:VC animated:YES];
            }else{
                HotelSuppliesCommodityDetailViewController * VC = [[HotelSuppliesCommodityDetailViewController alloc] initWithProduct:product];
                [self.navigationController pushViewController:VC animated:YES];
            }
            //        self.hidesBottomBarWhenPushed = NO;
        }
        
    }
}


#pragma mark - 事件

-(void)leftButtonClicked
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)rightButtonClicked
{
    if (![[AppInformationSingleton shareAppInfomationSingleton] getLoginCode]) {
        NSString *showMsg = @"请先登录";
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"提示"
                                                        message: showMsg
                                                       delegate: self
                                              cancelButtonTitle:@"取消"
                                              otherButtonTitles: @"确定", nil];
        
        [alert show];
        
    }else{
        
        self.hidesBottomBarWhenPushed = YES;
        ShoppingCartViewController * VC = [[ShoppingCartViewController alloc] initWithProductType:kProductTypeEntity];
        [self.navigationController pushViewController:VC animated:YES];
        self.hidesBottomBarWhenPushed = NO;
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        LoginViewController * VC = [[LoginViewController alloc] init];
        UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:VC];
        [self presentViewController:nav animated:YES completion:^{
            
        }];
    }
}

- (void)searchButtonClicked
{
    NSLog(@"%s", __func__);
    self.hidesBottomBarWhenPushed = YES;
    SearchViewController * VC = [[SearchViewController alloc] initWithProductType:kProductTypeEntity];
    [self.navigationController pushViewController:VC animated:YES];
}

/**
 *  头部筛选是视图点击事件
 *
 *  @param sender 当前按钮
 */
- (void)filterButtonClicked:(UIButton *)sender
{
    NSLog(@"tag = %ld",sender.tag);
    
    UIButton * left = [sender.superview viewWithTag:100];
    UIButton * right = [sender.superview viewWithTag:101];
    
    switch (sender.tag) {
        case 100:
            [left setTitleColor:UIColorFromRGB(LIGHTBLUECOLOR) forState:UIControlStateNormal];
            [right setTitleColor:UIColorFromRGB(GRAYFONTCOLOR) forState:UIControlStateNormal];
            [self HiddenScreeningView:NO];
            [_sortView removeFromSuperview];
            _sortView = nil;
            
            break;
            
        case 101:
        {
            [left setTitleColor:UIColorFromRGB(GRAYFONTCOLOR) forState:UIControlStateNormal];
            [right setTitleColor:UIColorFromRGB(LIGHTBLUECOLOR) forState:UIControlStateNormal];
            SCSortView * view = [[SCSortView alloc] initWithFrame:CGRectMake(GET_SCAlE_LENGTH(50), 0, SCREEN_WIDTH - GET_SCAlE_LENGTH(50), SCREEN_HEIGHT)];
            [self.view addSubview:view];
            view.delegate = self;
            [view setParameterWithModle:_productSortModel NeedBook:NO];
            [self addMaskViewWithShowView:view];
            [view callBackWithBlock:^(NSDictionary *diliverDictionary) {
                
                [view removeFromSuperview];
                
                if (diliverDictionary == nil) {
                    [self removeMask];
                    return;
                }
                
                for (NSString * key in diliverDictionary.allKeys) {
                    [_SCSottDic setObject:[diliverDictionary objectForKey:key] forKey:key];
                }
                
                [self removeMask];
                if (_isHotel) {
                    [self getHotelListData];
                }else{
                    [self getProductListData];
                }
            }];
            break;
        }
        default:
            break;
    }
    
    [self resetParameter];
}

- (void)resetParameter
{
    [_dataSource removeAllObjects];
    [_sortDic removeAllObjects];
    [_SCSottDic removeAllObjects];
    _currentPage = 1;
}

-(void)HiddenScreeningView:(BOOL)flag
{
    if (flag) {
        _screeningTableView.hidden = YES;
        _maskLayer.hidden = YES;
    }else{
        _screeningTableView.hidden = NO;
        _maskLayer.hidden = NO;
    }
}

-(void)pull2RefreshWithScrollerView:(UIScrollView *)scrollerView
{
    //    [self performSelector:@selector(endRefreshing) withObject:nil afterDelay:1];
    
    [self resetParameter];
    if (_isHotel) {
        [self getHotelListData];
    }else{
        [self getProductListData];
    }
}

-(void)push2LoadMoreWithScrollerView:(UIScrollView *)scrollerView
{
    if (_totalPage == 1)
    {
        [self performSelector:@selector(endRefreshing) withObject:nil afterDelay:1];
    }
    else if (_currentPage <_totalPage)
    {
        _currentPage ++;
        if (_isHotel) {
            [self getHotelListData];
        }else{
            [self getProductListData];
        }
    }
    else
    {
        [self performSelector:@selector(endRefreshing) withObject:nil afterDelay:0.5];
    }
}


#pragma mark - 网络

- (void)getHotelListData
{
    NSMutableDictionary * headDic = [[NSMutableDictionary alloc] initWithCapacity:1];
    
    NSMutableDictionary * bodyDic = [[NSMutableDictionary alloc] initWithCapacity:1];
    [bodyDic setObject:@"hotellist" forKey:@"functionid"];
    //    [bodyDic setObject:@"1" forKey:@"producttype"];
    [bodyDic setObject:[NSString stringWithFormat:@"%ld",_currentPage] forKey:@"pageno"];
    [bodyDic setObject:@"10" forKey:@"pagesize"];
    
    if (_starLevel) {
//        [bodyDic setObject:@"五星级" forKey:@"starlevel"];
    }
    
    if (_categoryID) {
        [bodyDic setObject:_categoryID forKey:@"categoryid"];
    }
    
    if (_sortDic.count > 0) {
        [bodyDic setObject:_sortDic[@"sortfield"] forKey:@"sortfield"];
        [bodyDic setObject:_sortDic[@"sorttype"] forKey:@"sorttype"];
    }
    
    if (_SCSottDic.count > 0) {
        for (NSString * key in _SCSottDic.allKeys) {
            [bodyDic setObject:_SCSottDic[key] forKey:key];
        }
    }
    
    if(![[Reachability reachabilityForInternetConnection]isReachable])
    {
        return;
    }
    
    [SVProgressHUD show];
    
    [[NetWorkSingleton sharedManager] postWithHeadParameter:headDic bodyParameter:bodyDic SuccessBlock:^(id responseBody) {
        
        [SVProgressHUD dismiss];
        
        id products = responseBody[@"body"][@"products"];
        
        if ([products isKindOfClass:[NSDictionary class]]) {
            [_dataSource addObject:[HSProduct modelObjectWithDictionary:products[@"product"]]];
        }else{
            
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

            
//            HSproductListModelParser * parser = [[HSproductListModelParser alloc] initWithDictionary:responseBody];
//            _totalPage = [parser.productListModel.totalpage integerValue];
//            
//            for (HSProduct * product in parser.productListModel.product) {
//                [_dataSource addObject:product];
//            }
        }
        
        if (_dataSource.count == 0) {
            [self showEmptyViewWithTableView:_mainTableView];
        }else{
            [self removeEmptyViewWithTableView:_mainTableView];
        }
        
        [_mainTableView reloadData];
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
//    [bodyDic setObject:@"1" forKey:@"producttype"];
    [bodyDic setObject:[NSString stringWithFormat:@"%ld",_currentPage] forKey:@"pageno"];
    [bodyDic setObject:@"10" forKey:@"pagesize"];
    
    if (_category) {
        [bodyDic setObject:_category.categoryid forKey:@"categoryid"];
    }
    
    if (_categoryID) {
        [bodyDic setObject:_categoryID forKey:@"categoryid"];
    }
    
    if (_sortDic.count > 0) {
        [bodyDic setObject:_sortDic[@"sortfield"] forKey:@"sortfield"];
        [bodyDic setObject:_sortDic[@"sorttype"] forKey:@"sorttype"];
    }
    
    if (_SCSottDic.count > 0) {
        for (NSString * key in _SCSottDic.allKeys) {
            [bodyDic setObject:_SCSottDic[key] forKey:key];
        }
    }
    
    if(![[Reachability reachabilityForInternetConnection]isReachable])
    {
        return;
    }
    
    [SVProgressHUD show];
    
    [[NetWorkSingleton sharedManager] postWithHeadParameter:headDic bodyParameter:bodyDic SuccessBlock:^(id responseBody) {
        
        [SVProgressHUD dismiss];
        
        id products = responseBody[@"body"][@"products"];
        
        if ([products isKindOfClass:[NSDictionary class]]) {
            [_dataSource addObject:[HSProduct modelObjectWithDictionary:products[@"product"]]];
             }else{
                 
                 HSproductListModelParser * parser = [[HSproductListModelParser alloc] initWithDictionary:responseBody];
                 _totalPage = [parser.productListModel.totalpage integerValue];
                 
                 for (HSProduct * product in parser.productListModel.product) {
                     [_dataSource addObject:product];
                 }
             }
        
        if (_dataSource.count == 0) {
            [self showEmptyViewWithTableView:_mainTableView];
        }else{
            [self removeEmptyViewWithTableView:_mainTableView];
        }
        
        [_mainTableView reloadData];
        [self endRefreshing];
        
    } FailureBlock:^(NSString *error) {
        
        [SVProgressHUD dismiss];
        [self endRefreshing];
        
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

@end
