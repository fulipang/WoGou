//
//  SearchResultViewController.m
//  XMNiao_Customer
//
//  Created by huangxiong on 14/12/1.
//  Copyright (c) 2014年 Luo. All rights reserved.
//

#import "SearchResultViewController.h"
#import "AppInformationSingleton.h"
#import "HotelSuppliesProductCell.h"
#import "HSproductListModelParser.h"
#import "HotelSuppliesCommodityDetailViewController.h"
#import "RoomReserVationDetailViewController.h"
#import "HotelModelParser.h"
#import "Hotels.h"

#define SEARCHWIDTH (200)
@interface SearchResultViewController ()<UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate>
{
    UIButton * _searchButton;
    
    NSMutableArray * _dataSource;
    NSMutableArray * _hotelData;
    
    ProductType _productType;
    
    NSInteger _totalPage;
    NSInteger _currentPage;
}

@end

@implementation SearchResultViewController

-(instancetype)initWithKeyWorks:(NSString *)keyWords ProductType:(ProductType)productType
{
    self = [super init];
    
    if (self) {
        
        _keyWord     = keyWords;
        _productType = productType;
        _currentPage = 1;
        _totalPage   = 1;
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
    
    if (_dataSource.count > 0) {
        [_dataSource removeAllObjects];
    }
    if (_hotelData.count > 0) {
        [_hotelData removeAllObjects];
    }
    
    [self getSearchNetWorkHotel];
    [self getSearchNetWorkHotelSupplies];
}

#pragma mark - 自定义视图

/**
 *  装载自定义视图 总览
 */
- (void)loadCostomViw
{
    [self setNavigationBarLeftButtonImage:@"NavBar_Back"];
    
    [self initSearchBar];
    
    [self loadMainTableView];
}

/**
 *  初始化搜索栏
 */
-(void)initSearchBar
{
    _searchBar = [[UISearchBar alloc]init];
    _searchBar.barStyle = UIBarStyleDefault;
    _searchBar.clipsToBounds = YES;
    _searchBar.text = _keyWord;
    
    _searchButton = [[UIButton alloc]init];
    _searchButton.backgroundColor = [UIColor clearColor];
    [_searchButton setTitle:@"搜索" forState:UIControlStateNormal];
    [_searchButton setTitleColor:UIColorFromRGB(WHITECOLOR)forState:UIControlStateNormal];
    _searchButton.titleLabel.font = [UIFont systemFontOfSize:15];
    _searchButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    [_searchButton.layer setCornerRadius:5.0];
    [_searchButton addTarget:self action:@selector(searchProducts) forControlEvents:UIControlEventTouchUpInside];
    
    /**
     *  设置searchbar
     */
    //    _searchBar.tintColor = UIColorFromRGB(BLACKFONTCOLOR);
    _searchBar.delegate = self;
    _searchBar.placeholder = @"搜索酒店用品/酒店";
    [_searchBar setBackgroundImage:[UIImage imageNamed:@"NavBar_search"]];
    _searchBar.layer.cornerRadius = 3;
    _searchBar.clipsToBounds = YES;
    
    /**
     *  更改字体颜色
     */
    UITextField * searchField = [_searchBar valueForKey:@"_searchField"];
    searchField.textColor = UIColorFromRGB(BLACKFONTCOLOR);
    searchField.font = [UIFont systemFontOfSize:13];
    
    /**
     *  右侧按钮
     */
    _searchButton.titleLabel.textColor = [UIColor blackColor];
    _searchBar.barTintColor = [UIColor whiteColor];
    
    [self.customNavigationBar addSubview:_searchButton];
    [self.customNavigationBar addSubview: _searchBar];
    
    
    /**
     *  位置
     */
    [_searchBar setBackgroundImage:[UIImage imageNamed:@"NavBar_search"]];
    [_searchBar makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.customNavigationBar.top).offset(27);
        make.centerX.mas_equalTo(self.customNavigationBar.centerX);
        make.size.mas_equalTo(CGSizeMake(GET_SCAlE_LENGTH(SEARCHWIDTH), _searchBar.backgroundImage.size.height));
        //        make.height.equalTo(@31);
        //        make.width.equalTo(@(GET_SCAlE_LENGTH(SEARCHWIDTH)));
    }];
    
    [_searchButton makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.customNavigationBar.top).offset(27);
        make.left.equalTo(self.customNavigationBar.right).offset(- 55);
        make.width.equalTo(@50);
        make.height.equalTo(@30);
    }];
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
    
    [self addpull2RefreshWithTableView:self.mainTableView];
    [self addPush2LoadMoreWithTableView:self.mainTableView];
    
    [self.mainTableView registerClass:[HotelSuppliesProductCell class] forCellReuseIdentifier:@"cell"];
}

#pragma mark - UITableviewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_dataSource.count > 0) {
        id  model = _dataSource[indexPath.row];
        
        if ([model isKindOfClass:[HSProduct class]]) {
            return GET_SCAlE_HEIGHT(110);
        }else{
            return GET_SCAlE_HEIGHT(135);
        }
    }
    
    return GET_SCAlE_HEIGHT(135);
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return _hotelData.count;
    }else{
        return _dataSource.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HotelSuppliesProductCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (indexPath.section == 0) {
        if (_hotelData.count > 0) {
            Hotels * model = _hotelData[indexPath.row];
            [cell cellForHoelSuppListVC:YES];
            [cell cellForRowWithModel:(HSProduct *)model];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
    }else{
        if (_dataSource.count > 0) {
            HSProduct * model = _dataSource[indexPath.row];
            [cell cellForHoelSuppListVC:NO];
            [cell cellForRowWithModel:model];
//            if ([model.producttype isEqualToString:@"1"]) {
//                [cell cellForHoelSuppListVC:YES];
//            }
        }
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 1) {
        HSProduct * model = _dataSource[indexPath.row];
        self.hidesBottomBarWhenPushed = YES;
        HotelSuppliesCommodityDetailViewController * VC = [[HotelSuppliesCommodityDetailViewController alloc] initWithProductID:model.productid];
        [self.navigationController pushViewController:VC animated:YES];
    }
    
    else if (indexPath.section == 0) {
        Hotels * model = _hotelData[indexPath.row];
        self.hidesBottomBarWhenPushed = YES;
        RoomReserVationDetailViewController * VC = [[RoomReserVationDetailViewController alloc] initWithSellerID:model.sellerid];
        [self.navigationController pushViewController:VC animated:YES];
    }
}

#pragma mark - 事件

-(void)pull2RefreshWithScrollerView:(UIScrollView *)scrollerView
{
    _currentPage = 1;
    
    [_dataSource removeAllObjects];
    [_hotelData removeAllObjects];
    
    [self getSearchNetWorkHotel];
    [self getSearchNetWorkHotelSupplies];
    
//    [self getProductsData];
}

-(void)push2LoadMoreWithScrollerView:(UIScrollView *)scrollerView
{
    if (_totalPage < 2) {
        [self performSelector:@selector(endRefreshing) withObject:nil afterDelay:1];
    }
    else
    {
        if (_currentPage < _totalPage){
            _currentPage ++;
//            [self getProductsData];
            [self getSearchNetWorkHotelSupplies];
            [self getSearchNetWorkHotel];
        }else{
            [self performSelector:@selector(endRefreshing) withObject:nil afterDelay:1];
        }
    }
}

-(void)leftButtonClicked
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)rightButtonClicked
{
    
}

/**
 *  搜索按钮点击事件
 */
- (void)searchProducts
{
    [_dataSource removeAllObjects];
    _currentPage = 1;
    
//    [self getProductsData];
    [self getSearchNetWorkHotelSupplies];
    [self getSearchNetWorkHotel];
}

#pragma mark - 网络

/**
 *  搜索列表请求
 */
-(void)getSearchNetWorkHotelSupplies
{
    
    NSMutableDictionary * headDic = [[NSMutableDictionary alloc] initWithCapacity:1];
    NSMutableDictionary * bodyDic = [[NSMutableDictionary alloc] initWithCapacity:1];
    
    if (_searchBar.text.length == 0) {
        
        return;
    }
    
    [bodyDic setObject:_searchBar.text forKey:@"keyword"];
    [bodyDic setObject:@"productlist" forKey:@"functionid"];
    [bodyDic setObject:@"1" forKey:@"producttype"];
    
    [[NetWorkSingleton sharedManager] postWithHeadParameter:headDic bodyParameter:bodyDic SuccessBlock:^(id responseBody) {
        
        if (_dataSource == nil) {
            _dataSource = [NSMutableArray array];
        }
        
        //=========================================
        
        id arrM = responseBody[@"body"][@"products"];
        
        if ([arrM isKindOfClass:[NSArray class]]) {
            HSproductListModelParser * parser = [[HSproductListModelParser alloc] initWithDictionary:responseBody];
            _totalPage = [parser.productListModel.totalpage integerValue];
            [parser.productListModel.product enumerateObjectsUsingBlock:^(HSProduct *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if ([obj isKindOfClass:[HSProduct class]]) {
                    if ([obj.productid integerValue] != 0) {
                        [_dataSource addObject:obj];
                    }
                }
            }];
        }else{
            if (([arrM isKindOfClass:[NSDictionary class]])) {
                NSMutableDictionary * dic = [[NSMutableDictionary alloc] init];
                NSArray * arr = [NSArray arrayWithObjects:arrM, nil];
                [dic setObject:arr forKey:@"products"];
                HSproductListModelParser * parser = [[HSproductListModelParser alloc] initWithDictionary:dic];
                _dataSource = [NSMutableArray arrayWithArray:parser.productListModel.product];
            }
        }

        //=========================================
     
//        if (_dataSource.count > 0) {
//            [_dataSource removeAllObjects];
//        }
//        
//        id arrM = responseBody[@"body"][@"products"];
//        
//        if ([arrM isKindOfClass:[NSArray class]]) {
//            _dataSource = [NSMutableArray arrayWithArray:arrM];
//        }else{
//            if (([arrM isKindOfClass:[NSDictionary class]])) {
//                [_dataSource addObject:arrM[@"product"]];
//            }
//        }
        
        [self.mainTableView reloadData];
        [self endRefreshing];
        
    } FailureBlock:^(NSString *error) {
        [self endRefreshing];
    }];
}

- (void)getSearchNetWorkHotel
{
    
    NSMutableDictionary * headDic = [[NSMutableDictionary alloc] initWithCapacity:1];
    NSMutableDictionary * bodyDic = [[NSMutableDictionary alloc] initWithCapacity:1];
    
    if (_searchBar.text.length == 0) {
        
        return;
    }
    
    [bodyDic setObject:_searchBar.text forKey:@"keyword"];
    [bodyDic setObject:@"hotellist" forKey:@"functionid"];
    
    [[NetWorkSingleton sharedManager] postWithHeadParameter:headDic bodyParameter:bodyDic SuccessBlock:^(id responseBody) {
        
        if (_hotelData == nil) {
            _hotelData = [NSMutableArray array];
        }
        
        
        if (_hotelData.count > 0) {
            [_hotelData removeAllObjects];
        }
        
        id arrM = responseBody[@"body"][@"hotels"];
        
        if ([arrM isKindOfClass:[NSArray class]]) {
            HotelModelParser * parser = [[HotelModelParser alloc] initWithDictionary:responseBody];
            NSArray * hotels = parser.hotelModel.hotels;
            [hotels enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                if ([obj isKindOfClass:[Hotels class]]) {
                    [_hotelData addObject:obj];
                }
                
            }];
        }else{
            Hotels * model = [Hotels modelObjectWithDictionary:arrM[@"hotel"]];
            [_hotelData addObject:model];
        }

        
        
//        id arrM = responseBody[@"body"][@"hotels"];
//        
//        if ([arrM isKindOfClass:[NSArray class]]) {
//            _hotelData = [NSMutableArray arrayWithArray:arrM];
//        }else{
//            if (([arrM isKindOfClass:[NSDictionary class]])) {
//                [_hotelData addObject:arrM[@"hotel"]];
//            }
//        }
        

        [self.mainTableView reloadData];
        [self endRefreshing];
        
    } FailureBlock:^(NSString *error) {
        [self endRefreshing];
    }];
}

- (void)getProductsData
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
    
    if (_keyWord == nil) {
        
        return;
    }
    [bodyDic setObject:_searchBar.text forKey:@"keyword"];
    [bodyDic setObject:@"productlist" forKey:@"functionid"];

    //    [bodyDic setObject:@"10" forKey:@"pageno"];
    [bodyDic setObject:[NSString stringWithFormat:@"%ld",_currentPage] forKey:@"pageno"];
    
    if (_productType == kProductTypeEntity) {
        [bodyDic setObject:_searchBar.text forKey:@"keyword"];
        [bodyDic setObject:@"productlist" forKey:@"functionid"];
        [bodyDic setObject:[NSString stringWithFormat:@"%ld",_productType] forKey:@"producttype"];
    }else{
        [bodyDic setObject:_searchBar.text forKey:@"keyword"];
        [bodyDic setObject:@"hotellist" forKey:@"functionid"];
    }
    
    [SVProgressHUD show];
    
    [[NetWorkSingleton sharedManager] postWithHeadParameter:headDic bodyParameter:bodyDic SuccessBlock:^(id responseBody) {
        
        NSLog(@"result = %@",responseBody);
        
        /*
         
         if (_dataSource == nil) {
         _dataSource = [NSMutableArray array];
         }
         
         
         if (_dataSource.count > 0) {
         [_dataSource removeAllObjects];
         }
         
         //酒店用品
         if (_productType == kProductTypeEntity) {
         
         id arrM = responseBody[@"body"][@"products"];
         
         if ([arrM isKindOfClass:[NSArray class]]) {
         _dataSource = [NSMutableArray arrayWithArray:arrM];
         }else{
         if (([arrM isKindOfClass:[NSDictionary class]])) {
         [_dataSource addObject:arrM[@"product"]];
         }
         }
         }
         //酒店
         else
         {
         id arrM = responseBody[@"body"][@"hotels"];
         
         if ([arrM isKindOfClass:[NSArray class]]) {
         _dataSource = [NSMutableArray arrayWithArray:arrM];
         }else{
         if (([arrM isKindOfClass:[NSDictionary class]])) {
         //                    Hotels * model = [Hotels modelObjectWithDictionary:arrM[@"hotel"]];
         [_dataSource addObject:arrM[@"hotel"]];
         }
         }
         }
         
         */
        
        if (_dataSource == nil) {
            _dataSource = [NSMutableArray array];
        }
        
        
        //酒店用品
        if (_productType == kProductTypeEntity) {
            
            id arrM = responseBody[@"body"][@"products"];
            
            if ([arrM isKindOfClass:[NSArray class]]) {
                HSproductListModelParser * parser = [[HSproductListModelParser alloc] initWithDictionary:responseBody];
                _totalPage = [parser.productListModel.totalpage integerValue];
                [parser.productListModel.product enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    if ([obj isKindOfClass:[HSProduct class]]) {
                        [_dataSource addObject:obj];
                    }
                }];
            }else{
                if (([arrM isKindOfClass:[NSDictionary class]])) {
                    NSMutableDictionary * dic = [[NSMutableDictionary alloc] init];
                    NSArray * arr = [NSArray arrayWithObjects:arrM, nil];
                    [dic setObject:arr forKey:@"products"];
                    HSproductListModelParser * parser = [[HSproductListModelParser alloc] initWithDictionary:dic];
                    _dataSource = [NSMutableArray arrayWithArray:parser.productListModel.product];
                }
            }
        }
        
        //酒店
        else
        {
            id arrM = responseBody[@"body"][@"hotels"];
            
            if ([arrM isKindOfClass:[NSArray class]]) {
                HotelModelParser * parser = [[HotelModelParser alloc] initWithDictionary:responseBody];
                NSArray * hotels = parser.hotelModel.hotels;
                [hotels enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    
                    if ([obj isKindOfClass:[Hotels class]]) {
                        [_dataSource addObject:obj];
                    }
                    
                }];
            }else{
                Hotels * model = [Hotels modelObjectWithDictionary:arrM[@"hotel"]];
                [_dataSource addObject:model];
            }
        }
        
        [self.mainTableView reloadData];
        [SVProgressHUD dismiss];
        [self endRefreshing];
    } FailureBlock:^(NSString *error) {
        [SVProgressHUD dismiss];
    }];
}

@end
