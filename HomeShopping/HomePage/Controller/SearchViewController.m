//
//  SearchViewController.m
//  XMNiao_Customer
//
//  Created by huangxiong on 15/2/5.
//  Copyright (c) 2015年 Luo. All rights reserved.
//

#import "SearchViewController.h"
#import "AppInformationSingleton.h"
#import "SearchResultViewController.h"
#import "HomePageViewController.h"
#import "SearchResultViewController.h"
#import "Hotels.h"


#define FENGEXIANG_HEIGHT (25)
#define FENGEXIANG_WIDTH (300)
#define HOTSearch_HEIGHT (45)
#define HOSTCLASS_WIDTH ((SCREEN_WIDTH -10) / 3)
#define SEARCHWIDTH (200)
@interface SearchViewController ()<UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate , UIAlertViewDelegate>
{
    //收索
    UISearchBar * _searchBar;
    UITableView * _mainTableView;
    //取消Button
    UIButton * _searchButton;
    
    ProductType _productType;
    
    //蒙版
    CALayer * _maskLayer;
    
    //搜索关键字
    NSString * _keyWords;
    
    //数据源（热门搜索）
    NSMutableArray * _hotSearchDataSource;
    NSMutableArray * _dataSource;
    NSMutableArray * _hotelData;
}

@end

@implementation SearchViewController

-(instancetype)initWithProductType:(ProductType)productType
{
    self = [super init];
    
    if (self) {
        
        _productType = productType;
        
    }
    
    return self;
}

#pragma mark - 生命周期

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //请求热门数据
    [self getNetWorkHostData];
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    //创建SearchBar
    [self initSearchBar];
    
    [self setNavigationBarLeftButtonImage:@"NavBar_Back"];
    
    self.view.backgroundColor = UIColorFromRGB(GRAYBGCOLOR);
    
    [self initTableView];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 装载视图

/**
 *  初始化主表视图
 */
-(void)initTableView
{
    _mainTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _mainTableView.autoresizingMask = (UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight);
    _mainTableView.backgroundColor = [UIColor whiteColor];
    _mainTableView.delegate = self;
    _mainTableView.dataSource = self;
    [self.view addSubview:_mainTableView];
    _mainTableView.hidden = YES;
    _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [_mainTableView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_searchBar.bottom).with.offset(2);
        make.centerX.mas_equalTo(self.view.centerX);
        make.size.mas_equalTo(CGSizeMake(GET_SCAlE_LENGTH(SEARCHWIDTH), GET_SCAlE_HEIGHT(1)));
    }];
}

- (void)showMask
{
    //CALayer
    _maskLayer = [[CALayer alloc] init];
    _maskLayer.backgroundColor = [UIColor blackColor].CGColor;
    _maskLayer.frame = self.view.bounds;
    _maskLayer.opacity = 0.3;
    [self.view.layer addSublayer: _maskLayer];
    
    [self.view bringSubviewToFront:_mainTableView];
    [self.view bringSubviewToFront:self.customNavigationBar];
}

- (void)deleteMask
{
    [_maskLayer removeFromSuperlayer];
}

/**
 *  初始化搜索栏
 */
-(void)initSearchBar
{
    _searchBar = [[UISearchBar alloc]init];
    _searchBar.barStyle = UIBarStyleDefault;
    _searchBar.clipsToBounds = YES;
    
    _searchButton = [[UIButton alloc]init];
    _searchButton.backgroundColor = [UIColor clearColor];
    [_searchButton setTitle:@"搜索" forState:UIControlStateNormal];
    [_searchButton setTitleColor:UIColorFromRGB(WHITECOLOR)forState:UIControlStateNormal];
    _searchButton.titleLabel.font = [UIFont systemFontOfSize:15];
    _searchButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    [_searchButton.layer setCornerRadius:5.0];
    [_searchButton addTarget:self action:@selector(searchButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    
    /**
     *  设置searchbar
     */
    //    _searchBar.tintColor = UIColorFromRGB(BLACKFONTCOLOR);
    _searchBar.delegate = self;
    _searchBar.placeholder = @"搜索酒店";
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
    [_searchBar makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.customNavigationBar.top).offset(27);
        make.centerX.mas_equalTo(self.customNavigationBar.centerX);
        make.height.equalTo(@31);
        make.width.equalTo(@(GET_SCAlE_LENGTH(SEARCHWIDTH)));
    }];
    
    [_searchButton makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.customNavigationBar.top).offset(27);
        make.left.equalTo(self.customNavigationBar.right).offset(- 55);
        make.width.equalTo(@50);
        make.height.equalTo(@30);
    }];
}

- (void)loadUpHotSearchView
{
    NSInteger row = (_hotSearchDataSource.count + 1) / 4;
    CGFloat rowHeight = 25 + (row * 50);
    
    UIView * searchView = [UIView new];
    [self.view addSubview:searchView];
    [searchView makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.customNavigationBar.mas_bottom);
        make.centerX.mas_equalTo(self.view.centerX);
        make.left.and.right.mas_equalTo(self.view);
        make.height.mas_equalTo(@(GET_SCAlE_HEIGHT(rowHeight)));
    }];
    searchView.backgroundColor = UIColorFromRGB(GRAYBGCOLOR);
    
    UILabel * hotTitleLabel = [UILabel new];
    [searchView addSubview:hotTitleLabel];
    [hotTitleLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(searchView.mas_top).with.offset(GET_SCAlE_HEIGHT(25/2.0));
        //        make.left.and.right.mas_equalTo(searchView);
        make.left.mas_equalTo(searchView.mas_left).with.offset(GET_SCAlE_LENGTH(10));
        make.height.mas_equalTo(GET_SCAlE_HEIGHT(25));
    }];
    hotTitleLabel.text = @"热门搜索";
    hotTitleLabel.textColor = UIColorFromRGB(LIGHTGRAYFONTCOLOR);
    hotTitleLabel.font = [UIFont systemFontOfSize:12];
    //    hotTitleLabel.backgroundColor = UIColorFromRGB();
    
    
    for (NSInteger i = 0; i<_hotSearchDataSource.count; i++) {
        
        NSInteger currentRow = (i)/4;
        
        CGFloat position_y = currentRow * GET_SCAlE_HEIGHT(50);
        CGFloat position_x = (i % 4) * SCREEN_WIDTH/4.0;
        
        UIButton * hotButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [searchView addSubview:hotButton];
        [hotButton makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(hotTitleLabel.mas_bottom).with.offset(position_y);
            make.left.mas_equalTo(searchView.mas_left).with.offset(position_x);
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH/4.0, GET_SCAlE_HEIGHT(50)));
        }];
        [hotButton setTitle:_hotSearchDataSource[i] forState:UIControlStateNormal];
        [hotButton.titleLabel setFont:[UIFont systemFontOfSize:13]];
        [hotButton setTitleColor:UIColorFromRGB(LIGHTGRAYFONTCOLOR) forState:UIControlStateNormal];
        hotButton.layer.borderColor = UIColorFromRGB(GRAYBGCOLOR).CGColor;
        hotButton.layer.borderWidth = 0.3;
        hotButton.backgroundColor = UIColorFromRGB(WHITECOLOR);
        hotButton.tag = i + 1000;
        [hotButton addTarget:self action:@selector(hotButtonCilcked:) forControlEvents:UIControlEventTouchUpInside];
        
    }
}

#pragma mark - 网络
/**
 *  热门数据请求
 */
-(void)getNetWorkHostData
{
    
    //检查网络
    if (![[Reachability reachabilityForInternetConnection] isReachable]) {
        
        return;
    }
    
    NSMutableDictionary *headDic = [[NSMutableDictionary alloc] initWithCapacity:1];
    NSMutableDictionary *bodyDic = [[NSMutableDictionary alloc] initWithCapacity:1];
    [bodyDic setObject:@"hotsearch" forKey:@"functionid"];
    
    [[NetWorkSingleton sharedManager] postWithHeadParameter:headDic bodyParameter:bodyDic SuccessBlock:^(id responseBody) {
        
        if (responseBody) {
            _hotSearchDataSource = [responseBody objectForKey:@"body"][@"keywords"];
            
            if (_hotSearchDataSource.count > 0) {
                [self loadUpHotSearchView];
            }
        }
        
    } FailureBlock:^(NSString *error) {
        
    }];
}

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
        
        NSLog(@"result = %@",responseBody);
        
        if (_dataSource == nil) {
            _dataSource = [NSMutableArray array];
        }
        
        
        if (_dataSource.count > 0) {
            [_dataSource removeAllObjects];
        }
        
        id arrM = responseBody[@"body"][@"products"];
        
        if ([arrM isKindOfClass:[NSArray class]]) {
            _dataSource = [NSMutableArray arrayWithArray:arrM];
        }else{
            if (([arrM isKindOfClass:[NSDictionary class]])) {
                [_dataSource addObject:arrM[@"product"]];
            }
        }
        
        [_mainTableView updateConstraints:^(MASConstraintMaker *make) {
            
            make.size.mas_equalTo(CGSizeMake(GET_SCAlE_LENGTH(SEARCHWIDTH), GET_SCAlE_HEIGHT((_dataSource.count + _hotelData.count) * 40)));
            
        }];
        _mainTableView.hidden = NO;
        [_mainTableView reloadData];
        
    } FailureBlock:^(NSString *error) {
        
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
            _hotelData = [NSMutableArray arrayWithArray:arrM];
        }else{
            if (([arrM isKindOfClass:[NSDictionary class]])) {
                [_hotelData addObject:arrM[@"hotel"]];
            }
        }
        
        [_mainTableView updateConstraints:^(MASConstraintMaker *make) {
            
            make.size.mas_equalTo(CGSizeMake(GET_SCAlE_LENGTH(SEARCHWIDTH), GET_SCAlE_HEIGHT((_dataSource.count + _hotelData.count) * 40)));
            
        }];
        _mainTableView.hidden = NO;
        [_mainTableView reloadData];
        
    } FailureBlock:^(NSString *error) {
        
    }];
}

#pragma mark - UITableViewDelegate

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
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    
    if (indexPath.section == 0) {
        if (_hotelData.count > 0) {
            NSDictionary * dic = _hotelData[indexPath.row];
            cell.textLabel.text = dic[@"title"];
        }
    }else{
        if (_dataSource.count > 0) {
            NSDictionary * dic = _dataSource[indexPath.row];
            cell.textLabel.text = dic[@"title"];
        }
    }
    
    
    return cell;
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return GET_SCAlE_HEIGHT(40);
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        _searchBar.text = _hotelData[indexPath.row][@"title"];
    }else{
        _searchBar.text = _dataSource[indexPath.row][@"title"];
    }
    
    _mainTableView.hidden = YES;
    
    [self deleteMask];
    
}

/**
 *  修改热门搜索显示列表(修改后显示)
 *
 *  @param indexPath 下标
 *
 *  @return 自定义视图
 */
-(UIView*)changeTableViewCellIndexPathsection:(NSIndexPath*)indexPath
{
    
    return nil;
}

#pragma mark - UISearchBarDelegate

/**
 *  点击搜索栏
 *
 *  @param searchBar 当前搜索栏
 *
 *  @return 是否开始编辑
 */
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    _mainTableView.hidden = NO;
    
    [self showMask];
    
    
    _mainTableView.backgroundColor = [UIColor whiteColor];
    [_mainTableView reloadData];
    
    return YES;
}

- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar
{
    return YES;
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    [self deleteMask];
}

- (BOOL)searchBar:(UISearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    //设置search值,显示搜索界面。
    //    search = 103;
    
    //    if ([text isEqualToString:@""]) {
    //        _keyWords = [searchBar.text substringToIndex:searchBar.text.length - 1];
    //    }else{
    //        _keyWords = [NSString stringWithFormat:@"%@%@",_searchBar.text,text];
    //    }
    
    [self performSelector:@selector(getSearchNetWorkHotelSupplies) withObject: nil afterDelay: 0.2];
    [self performSelector:@selector(getSearchNetWorkHotel) withObject: nil afterDelay: 0.2];
    
    return YES;
}

/**
 *  清空搜索记录
 */

#pragma mark - 事件

/**
 *  热门关键词点击事件
 *
 *  @param button
 */
- (void)hotButtonCilcked:(UIButton *)button
{
    NSInteger position = button.tag % 100;
    
    NSString * hotKeyWord = _hotSearchDataSource[position];
    
    self.hidesBottomBarWhenPushed   = YES;
    SearchResultViewController * VC = [[SearchResultViewController alloc] initWithKeyWorks:hotKeyWord ProductType:_productType];
    [self.navigationController pushViewController:VC animated:NO];
}

/**
 *  搜索按钮点击事件
 */
- (void)searchButtonClicked
{
    [_searchBar resignFirstResponder];
    
    self.hidesBottomBarWhenPushed = YES;
    
    NSString * keyWord = _searchBar.text;
    
    SearchResultViewController * VC = [[SearchResultViewController alloc] initWithKeyWorks:keyWord ProductType:_productType];
    [self.navigationController pushViewController:VC animated:NO];
    
}

-(void)leftButtonClicked
{
    [self.navigationController popViewControllerAnimated:NO];
}


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
