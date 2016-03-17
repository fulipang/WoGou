//
//  HotelSuppliesViewController.m
//  HomeShopping
//
//  Created by sooncong on 15/12/11.
//  Copyright © 2015年 Administrator. All rights reserved.
//

#import "HotelSuppliesViewController.h"
#import "HotelSuppliesCommodityDetailViewController.h"
#import "ImageScrollView.h"
//#import "otherLayout.h"
#import "HotelSuppliesShowCell.h"
#import "HShotelSuppliesModelParser.h"
#import "HSProducts.h"
#import "HSSubcategory.h"
#import "HotelSupplyListViewController.h"
#import "ShoppingCartViewController.h"
#import "SearchViewController.h"
#import "LoginViewController.h"

//头视图高
const NSInteger KTopHeight = 40;
//左侧宽
const NSInteger KLeftWidth = 80;

NSInteger _tag = 0;

@implementation HotelSuppliesViewController{
    
    
    UICollectionView * _collectionView;
    
    // collectionview 数据源
    NSMutableArray * _collectionDataSource;
    NSArray * _adsData;
    
    //  tableview 数据源
    NSMutableArray * _tableViewDataSource;
    
    //记录点击的父标题
    NSInteger _currentLine;
}

#pragma mark - 生命周期

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self getHotelSuppliesData];
    self.tabBarController.tabBar.hidden = NO;
    
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    [self loadUpCustomView];
    
    [self initDataSource];
}

- (void)initDataSource
{
    _collectionDataSource = [NSMutableArray array];
    _tableViewDataSource = [NSMutableArray array];
    
    _currentLine = 0;
}

- (void)loadUpCustomView
{
    [self loadUpCustomNavigationBar];
    
    [self loadCustomView];
}

#pragma mark - 自定义视图

- (void)loadUpCustomNavigationBar
{
    [self loadUpSearchBar];
    [self setNavigationBarRightButtonImage:@"NavBar_shopCart" WithTitle:@"购物车"];
    [self.navBackGroundView setImage:[UIImage imageNamed:@"NavBG_top"]];
    
    //    self.navBackGroundView.alpha = 0;
    self.navBackGroundView.backgroundColor = [UIColor clearColor];
}

- (void)loadCustomView
{
    [self loadUpImageScrollView];
    [self loadLeftView];
    [self loadCollectionView];
}

- (void)loadCollectionView
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    [self.view addSubview:_collectionView];
    [_collectionView makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.leftTableView.mas_right);
        make.top.mas_equalTo(self.leftTableView);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - GET_SCAlE_LENGTH(94), SCREEN_HEIGHT - 200));
    }];
    
    UIButton * moreButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_collectionView addSubview:moreButton];
    [moreButton makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(_collectionView.mas_centerX);
        make.top.mas_equalTo(_collectionView.mas_top).with.offset(GET_SCAlE_HEIGHT(10));
        make.size.mas_equalTo(CGSizeMake(GET_SCAlE_LENGTH(204), GET_SCAlE_HEIGHT(24)));
    }];
    
    moreButton.backgroundColor      = UIColorFromRGB(TABLEVIEWGRAYBGCOLOR);
    moreButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [moreButton setTitle:@"查看全部" forState:UIControlStateNormal];
    [moreButton setTitle:@"查看全部" forState:UIControlStateHighlighted];
    [moreButton setTitleColor:UIColorFromRGB(BLACKFONTCOLOR) forState:UIControlStateNormal];
    [moreButton setTitleColor:UIColorFromRGB(BLACKFONTCOLOR) forState:UIControlStateHighlighted];
    moreButton.layer.cornerRadius = 3;
    moreButton.clipsToBounds = YES;
    moreButton.layer.borderWidth = 1;
    moreButton.layer.borderColor = UIColorFromRGB(GRAYLINECOLOR).CGColor;
    [moreButton addTarget:self action:@selector(loadAllButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    
    //配置参数
    _collectionView.backgroundColor = UIColorFromRGB(WHITECOLOR);
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    
    //注册cell
    [_collectionView registerClass:[HotelSuppliesShowCell class] forCellWithReuseIdentifier:@"HotelSuppliesShowCell"];
}

/**
 *  初始化搜索栏
 */
-(void)loadUpSearchBar
{
    
    
    UIButton * searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.customNavigationBar addSubview:searchButton];
    [searchButton makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.customNavBarRightBtn.centerY);
        make.left.mas_equalTo(self.customNavBarLeftBtn.mas_left).with.offset(GET_SCAlE_LENGTH(5));
        make.height.equalTo(@30);
        make.width.equalTo(@(GET_SCAlE_LENGTH(253)));
    }];
    [searchButton setBackgroundImage:[UIImage imageNamed:@"NavBar_search"] forState:UIControlStateNormal];
    [searchButton setBackgroundImage:[UIImage imageNamed:@"NavBar_search"] forState:UIControlStateHighlighted];
    [searchButton addTarget:self action:@selector(searchButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    
    [searchButton setTitle:@"搜索酒店" forState:UIControlStateNormal];
    [searchButton setTitle:@"搜索酒店" forState:UIControlStateHighlighted];
    
    searchButton.titleLabel.font = [UIFont systemFontOfSize:NORMALFONTSIZE];
    [searchButton setTitleColor:UIColorFromRGB(GRAYFONTCOLOR) forState:UIControlStateNormal];
    [searchButton setTitleColor:UIColorFromRGB(GRAYFONTCOLOR) forState:UIControlStateHighlighted];
    
    
}

- (void)loadUpImageScrollView
{
    self.topImageScrollView = [[ImageScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200)];
    [self.view addSubview:self.topImageScrollView];
    [self.topImageScrollView callBackWithBlock:^(NSInteger index) {
        if (_adsData.count > 0) {
            HSAdsLists * ads = [_adsData objectAtIndex:index];
            
            [self JumpToadvertisementWithModel:ads];
        }
    }];
    [self.view bringSubviewToFront:self.customNavigationBar];
}


//加载左侧视图
-(void)loadLeftView{
    
    self.leftTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.view addSubview:self.leftTableView];
    
    [self.leftTableView makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.topImageScrollView.mas_bottom);
        make.left.and.bottom.mas_equalTo(self.view);
        make.width.mas_equalTo(@(GET_SCAlE_LENGTH(94)));
    }];
    
    self.leftTableView.dataSource = self;
    self.leftTableView.delegate = self;
    self.leftTableView.separatorStyle = UITableViewCellSelectionStyleNone;
    self.leftTableView.rowHeight = GET_SCAlE_LENGTH(60);
    self.leftTableView.backgroundColor = UIColorFromRGB(TABLEVIEWGRAYBGCOLOR);
    
    
}

#pragma mark - UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _tableViewDataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    for (id subView in cell.contentView.subviews) {
        
        if ([subView isKindOfClass:[UIView class]]) {
            
            UIView *vie = (UIView *)subView;
            [vie removeFromSuperview];
        }
    }
    
    [cell.contentView addSubview:[self viewWithCellIndexPath:indexPath]];
    
    for (id subView in cell.selectedBackgroundView.subviews) {
        
        if ([subView isKindOfClass:[UIView class]]) {
            
            UIView *vie = (UIView *)subView;
            [vie removeFromSuperview];
        }
    }
    
    [cell.selectedBackgroundView addSubview:[self createSeletedtView]];
    
    return cell;
}

- (UIView *)createSeletedtView
{
    UIView * selectedView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, GET_SCAlE_LENGTH(94), GET_SCAlE_LENGTH(60))];
    selectedView.backgroundColor = UIColorFromRGB(WHITECOLOR);
    
    UIView * line = [UIView new];
    [selectedView addSubview:line];
    [line makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(selectedView.mas_left);
        make.centerY.mas_equalTo(selectedView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(GET_SCAlE_LENGTH(3), GET_SCAlE_HEIGHT(40)));
    }];
    line.backgroundColor = UIColorFromRGB(LIGHTBLUECOLOR);
    
    return selectedView;
}


- (UIView *)viewWithCellIndexPath:(NSIndexPath *)indexPath
{
    
    HSProducts * productModel = _tableViewDataSource[indexPath.row];
    
    UIView * contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, GET_SCAlE_LENGTH(94), GET_SCAlE_LENGTH(60))];
    contentView.backgroundColor = UIColorFromRGB(TABLEVIEWGRAYBGCOLOR);
    
    UILabel * titleLabel = [UILabel new];
    [contentView addSubview:titleLabel];
    [titleLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.mas_equalTo(contentView);
        make.centerY.mas_equalTo(contentView.centerY);
    }];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = productModel.title;
    titleLabel.font = [UIFont systemFontOfSize:15];
    titleLabel.textColor = UIColorFromRGB(LIGHTGRAYFONTCOLOR);
    titleLabel.tag = indexPath.row + 10;
    
    return contentView;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self changeLeftViewTextColorWithTableView:tableView IndexPath:indexPath Color:UIColorFromRGB(LIGHTBLUECOLOR)];
    
    _currentLine = indexPath.row;
    [_collectionView reloadData];
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self changeLeftViewTextColorWithTableView:tableView IndexPath:indexPath Color:UIColorFromRGB(LIGHTGRAYFONTCOLOR)];
}

/**
 *  点击左侧表视图时 修改字体颜色
 *
 *  @param tableView 当前表视图
 *  @param indexPath
 *  @param color     颜色
 */
- (void)changeLeftViewTextColorWithTableView:(UITableView *)tableView IndexPath:(NSIndexPath *)indexPath Color:(UIColor *)color
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    UILabel * label = [cell.contentView viewWithTag:indexPath.row + 10];
    label.textColor = color;
}

#pragma mark - 网络

- (void)getHotelSuppliesData
{
    
    if(![[Reachability reachabilityForInternetConnection]isReachable])
    {
        //        [self showMyMessage:@"该功能需要连接网络才能使用，请检查您的网络连接状态"];
        return;
    }
    
    [SVProgressHUD show];
    
    NSMutableDictionary * headDic = [[NSMutableDictionary alloc] initWithCapacity:1];
    NSMutableDictionary * bodyDic = [[NSMutableDictionary alloc] initWithCapacity:1];
    
    [bodyDic setObject:@"categorylist" forKey:@"functionid"];
    [bodyDic setObject:@"1" forKey:@"isall"];
    //    [bodyDic setObject:@"1" forKey:@"parentid"];
    
    [[NetWorkSingleton sharedManager] postWithHeadParameter:headDic bodyParameter:bodyDic SuccessBlock:^(id responseBody) {
        
        [SVProgressHUD dismiss];
        
        HShotelSuppliesModelParser * parser = [[HShotelSuppliesModelParser alloc] initWithDictionary:responseBody];
        _adsData = [NSArray arrayWithArray:parser.hotelSuppliesModel.adsLists];
        _tableViewDataSource = [NSMutableArray arrayWithArray:parser.hotelSuppliesModel.products];
        [_leftTableView reloadData];
        [self TableViewdefaultSeletedWithSection:0 Row:0];
        [_collectionView reloadData];
        [self.topImageScrollView setImageArray:_adsData];
        
    } FailureBlock:^(NSString *error) {
        
        [SVProgressHUD dismiss];
        
        NSLog(@"error : %@",error);
        
    }];
}

#pragma mark - 事件

- (void)loadAllButtonClicked
{
    self.hidesBottomBarWhenPushed = YES;
    HotelSupplyListViewController * VC = [[HotelSupplyListViewController alloc] init];
    [self.navigationController pushViewController:VC animated:YES];
    self.hidesBottomBarWhenPushed = NO;
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

//去下一个界面
- (void)jumpToDetail
{
    HotelSuppliesCommodityDetailViewController * VC = [[HotelSuppliesCommodityDetailViewController alloc] init];
    [self.navigationController pushViewController:VC animated:YES];
}

/**
 *  代码设置选中tableview 位置
 *
 *  @param section 段
 *  @param row     行
 */
- (void)TableViewdefaultSeletedWithSection:(NSInteger)section Row:(NSInteger)row
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:section];
    [self.leftTableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionMiddle];
    [self changeLeftViewTextColorWithTableView:self.leftTableView IndexPath:indexPath Color:UIColorFromRGB(LIGHTBLUECOLOR)];
}

- (void)searchButtonClicked
{
    self.hidesBottomBarWhenPushed = YES;
    SearchViewController * VC = [[SearchViewController alloc] initWithProductType:kProductTypeEntity];
    [self.navigationController pushViewController:VC animated:YES];
    self.hidesBottomBarWhenPushed = NO;
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

#pragma mark - 待处理

//获取左侧视图数据
-(NSArray*)leftDataArray{
    
    if (_leftDataArray == nil) {
        
        NSString* path = [[NSBundle mainBundle] pathForResource:@"categorys_name.plist" ofType:nil];
        self.leftDataArray = [NSArray arrayWithContentsOfFile:path];
    }
    return _leftDataArray;
}


//改变点击状态
-(void)changeChoice:(NSInteger)tag{
    
    //    LeftViewCell *leftView = [_leftViewCellArray objectAtIndex:_tag];
    //    [leftView setSelected:NO tag:_tag];
    //
    //    LeftViewCell *leftView2 = [_leftViewCellArray objectAtIndex:tag];
    //    [leftView2 setSelected:YES tag:tag];
    
    _tag = tag;
    _choice = tag;
    
    //    [self initCollectionView];
}

#pragma mark - UICollectionViewDelegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (_tableViewDataSource.count > 0) {
        HSProducts * product = _tableViewDataSource[_currentLine];
        return product.subcategorys.count;
    }else{
        return 0;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    HSProducts * product = _tableViewDataSource[_currentLine];
    //    NSArray * arrM = product.subcategorys;
    HSSubcategory * goodModel = product.subcategorys[indexPath.row];
    
    HotelSuppliesShowCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HotelSuppliesShowCell" forIndexPath:indexPath];
    [cell setCellWithModel:nil];
    [cell setCellWithModel:goodModel];
    
    //    cell.contentView.backgroundColor = [UIColor greenColor];
    //    cell.titleLabel.backgroundColor  = [UIColor redColor];
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%@",@(indexPath.row).description);
    HSProducts * product = _tableViewDataSource[_currentLine];
    //    NSArray * arrM = product.subcategorys;
    HSSubcategory * goodModel = product.subcategorys[indexPath.row];
    self.hidesBottomBarWhenPushed = YES;
    HotelSupplyListViewController * VC = [[HotelSupplyListViewController alloc] initWithCategoryID:goodModel.subcategoryid];
    [self.navigationController pushViewController:VC animated:YES];
    self.hidesBottomBarWhenPushed = NO;
    
}


//定义每个UICollectionView 的间距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(GET_SCAlE_HEIGHT(40), 8, 0, 8);
}

//定义每个UICollectionView 的纵向间距
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 5;
}

//设置元素大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(GET_SCAlE_LENGTH(102), GET_SCAlE_HEIGHT(124));
}

-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return YES;
    
}


-(void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
