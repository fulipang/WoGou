//
//  ShoppingCartViewController.m
//  HomeShopping
//
//  Created by sooncong on 16/1/11.
//  Copyright © 2016年 Administrator. All rights reserved.
//

#import "ShoppingCartViewController.h"
#import "ConfirmHotelSuppliesOrderViewController2.h"
#import "ShoppingCartCell.h"
#import "ShoppingCarModelParser.h"
#import "ShoppingCarProduct.h"



@implementation ShoppingCartViewController
{
    ProductType _productType;
    NSMutableArray *_dataArr;
    ShoppingCarProduct *_shoppingCardProduct;
    ShoppingCarModelParser *_modelParser;
    NSMutableArray *_selectedArr;
    
    NSMutableArray *_buyCountArr;
    
    NSMutableArray *_selectedIndexPathArr;
    
    NSMutableArray *_dataSource;
    
    float _totalMoney;
    float _totalReturn;

    
}

-(instancetype)initWithProductType:(ProductType)type
{
    self = [super init];
    
    if (self) {
        _productType = type;
    }
    
    return self;
}

#pragma mark - 生命周期

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //    _AllselectionButton.selected = YES;
    //    [self allSelectionButtonClicked:_AllselectionButton];
    //    [self removeAllDatas];
    //    [self caculateAllMoney];
    //    [self getShoppingCartData];
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    _dataArr = [NSMutableArray array];
    _selectedArr = [NSMutableArray array];
    _buyCountArr = [NSMutableArray array];
    _selectedIndexPathArr = [NSMutableArray array];
    _dataSource = [NSMutableArray array];
    
    [self loadCostomViw];
    
    [self getShoppingCartData];
    
}


//#pragma mark 网络
//
///// 获取购物车数据
//- (void)sendRequestForData {
//
//    NSMutableDictionary *headDic = [NSMutableDictionary dictionary];
//    NSMutableDictionary *bodyDic = [NSMutableDictionary dictionary];
//    [bodyDic setObject:@"getmybuycar" forKey:@"functionid"];
//    [bodyDic setObject:@"1" forKey:@"pageno"];
//    [bodyDic setObject:@"20" forKey:@"pagesize"];
//    [bodyDic setObject:@"" forKey:@"producttype"];
//    [bodyDic setObject:@"1" forKey:@"type"];
//
//    [[NetWorkSingleton sharedManager] postWithHeadParameter:headDic bodyParameter:bodyDic SuccessBlock:^(id responseBody) {
//
//    } FailureBlock:^(NSString *error) {
//
//    }];
//
//}

#pragma mark - 自定义视图

/**
 *  装载自定义视图 总览
 */
- (void)loadCostomViw
{
    [self setNavigationBarLeftButtonImage:@"NavBar_Back"];
    [self setNavigationBarRightButtonImage:@"rubish"];
    
    [self setNavigationBarTitle:@"购物车"];
    
    [self createBottomView];
    
    [self loadMainTableView];
}

- (void)createBottomView
{
    UIView * bottomView = [UIView new];
    [self.view addSubview:bottomView];
    [bottomView makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.view.bottom);
        make.centerX.mas_equalTo(self.view.centerX);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, GET_SCAlE_HEIGHT(50)));
    }];
    bottomView.backgroundColor = UIColorFromRGB(BLACKORDERCOLOR);
    
    UIButton * orderButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [bottomView addSubview:orderButton];
    [orderButton makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(bottomView.centerY);
        make.right.mas_equalTo(bottomView.right);
        make.size.mas_equalTo(CGSizeMake(GET_SCAlE_LENGTH(120), GET_SCAlE_HEIGHT(50)));
    }];
    [orderButton setTitle:@"提交订单" forState:UIControlStateNormal];
    [orderButton.titleLabel setFont:[UIFont systemFontOfSize:TITLENAMEFONTSIZE]];
    [orderButton setTitleColor:UIColorFromRGB(WHITECOLOR) forState:UIControlStateNormal];
    orderButton.backgroundColor = UIColorFromRGB(REDORDERCOLOR);
    
    _AllselectionButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [bottomView addSubview:_AllselectionButton];
    [_AllselectionButton makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(bottomView.left).with.offset(GET_SCAlE_LENGTH(10));
        make.centerY.mas_equalTo(bottomView.centerY);
        make.size.mas_equalTo(CGSizeMake(GET_SCAlE_LENGTH(15), GET_SCAlE_LENGTH(15)));
    }];
    [_AllselectionButton setBackgroundImage:[UIImage imageNamed:@"selected_rd"] forState:UIControlStateSelected];
    [_AllselectionButton setBackgroundImage:[UIImage imageNamed:@"selected_r"] forState:UIControlStateNormal];
    [_AllselectionButton addTarget:self action:@selector(allSelectionButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel * selectLabel  = [UILabel new];
    [bottomView addSubview:selectLabel];
    [selectLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(bottomView.centerY).with.offset(0);
        make.left.mas_equalTo(_AllselectionButton.right).with.offset(GET_SCAlE_LENGTH(10));
    }];
    selectLabel.textColor = UIColorFromRGB(WHITECOLOR);
    selectLabel.font = [UIFont systemFontOfSize:14];
    selectLabel.text = @"全选";
    
    UILabel * moneyLabel  = [UILabel new];
    [bottomView addSubview:moneyLabel];
    [moneyLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(bottomView.centerY).with.offset(GET_SCAlE_HEIGHT(-8));
        make.left.mas_equalTo(selectLabel.right).with.offset(GET_SCAlE_LENGTH(10));
    }];
    moneyLabel.textColor = UIColorFromRGB(WHITECOLOR);
    moneyLabel.font = [UIFont systemFontOfSize:14];
    moneyLabel.text = @"合计：";
    
    UILabel * coinLabel  = [UILabel new];
    [bottomView addSubview:coinLabel];
    [coinLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(bottomView.centerY).with.offset(GET_SCAlE_HEIGHT(22/2.0));
        make.left.mas_equalTo(selectLabel.right).with.offset(GET_SCAlE_LENGTH(10));
    }];
    coinLabel.textColor = UIColorFromRGB(WHITECOLOR);
    coinLabel.font = [UIFont systemFontOfSize:CELLSMALLFONTSIZE];
    coinLabel.text = @"返狗币：";
    
    _totalMoneyLabel  = [UILabel new];
    [bottomView addSubview:_totalMoneyLabel];
    [_totalMoneyLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(moneyLabel.centerY).with.offset(0);
        make.left.mas_equalTo(moneyLabel.right).with.offset(0);
    }];
    _totalMoneyLabel.textColor = UIColorFromRGB(WHITECOLOR);
    _totalMoneyLabel.font = [UIFont systemFontOfSize:14];
    _totalMoneyLabel.text = @"￥0.00";
    
    _totalCoinLabel  = [UILabel new];
    [bottomView addSubview:_totalCoinLabel];
    [_totalCoinLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(coinLabel.centerY).with.offset(0);
        make.left.mas_equalTo(coinLabel.right).with.offset(0);
    }];
    _totalCoinLabel.textColor = UIColorFromRGB(WHITECOLOR);
    _totalCoinLabel.font = [UIFont systemFontOfSize:CELLSMALLFONTSIZE];
    _totalCoinLabel.text = @"0.00";
    
    //添加事件
    [orderButton addTarget:self action:@selector(commitOrder) forControlEvents:UIControlEventTouchUpInside];
}

- (void)loadMainTableView
{
    self.mainTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.view addSubview:self.mainTableView];
    [self.mainTableView makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view.bottom).with.offset(GET_SCAlE_HEIGHT(-50));
        make.top.mas_equalTo(self.customNavigationBar.bottom);
    }];
    
    self.mainTableView.delegate       = self;
    self.mainTableView.dataSource     = self;
    self.mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.mainTableView registerClass:[ShoppingCartCell class] forCellReuseIdentifier:@"cell"];
}

#pragma mark - UITableviewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return GET_SCAlE_HEIGHT(310/2);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ShoppingCartCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (_productType == kProductTypeEntity) {
        cell.totalDaysLabel.hidden = YES;
    }
    else {
        cell.totalDaysLabel.hidden = NO;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell cellSetShopingCardProduct:_dataArr[indexPath.row]];
    
    ShoppingCarProduct *product = _dataArr[indexPath.row];
    if ([_selectedArr containsObject:product]) {
        cell.selectionButton.selected = YES;
    }
    else {
        cell.selectionButton.selected = NO;
    }
    
    __weak typeof(cell) weakCell = cell;
    
    [cell setSelectedCellCallback:^(BOOL selected) {
        [self caculate:weakCell indexPath:indexPath];
        if (selected) {
            [self caculateAllMoney];
            [self configureDataSource:_selectedArr];
        }
        NSLog(@"===count:%d",_selectedArr.count);
    }];
    

    [cell setSelectedButtonCallback:^(BOOL selected) {
        
        if (!selected) {
            if ([_selectedArr containsObject:_dataArr[indexPath.row]]) {
                [_selectedArr removeObject:_dataArr[indexPath.row]];
            }
        }
        else {
            if (![_selectedArr containsObject:_dataArr[indexPath.row]]) {
                [_selectedArr addObject:_dataArr[indexPath.row]];
            }
        }
        
        if (_dataArr.count == _selectedArr.count) {
            _AllselectionButton.selected = YES;
        }
        else {
            _AllselectionButton.selected = NO;
        }


        [self caculateAllMoney];
        [self configureDataSource:_selectedArr];

    }];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    ShoppingCartCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//    ShoppingCarProduct *selectedProduct = _dataArr[indexPath.row];
//    if ([_selectedArr containsObject:selectedProduct]) {
//        [_selectedArr removeObject:selectedProduct];
//        cell.selectionButton.selected = NO;
//    }
//    else {
//        [_selectedArr addObject:selectedProduct];
//        cell.selectionButton.selected = YES;
//    }
//    
//    if (_dataArr.count == _selectedArr.count) {
//        _AllselectionButton.selected = YES;
//    }
//    else {
//        _AllselectionButton.selected = NO;
//    }
//    
//    [self caculateAllMoney];
//    [self configureDataSource:_selectedArr];

}

- (void)caculate:(ShoppingCartCell*)cell indexPath:(NSIndexPath*)indexPath {
    
    ShoppingCarProduct *product = _dataArr[indexPath.row];
    
    product.buycount = cell.numberLabel.text;

}


#pragma mark - 事件

-(void)leftButtonClicked
{
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)rightButtonClicked
{
    if (_selectedArr.count == 0) {
        [SVProgressHUD showErrorWithStatus:@"请选择要删除的商品" duration:1.5];
        return;
    }
    
    [self removeShopCartShoppings];
    [self caculateAllMoney];
}

#pragma mark 删除购物车商品
/// 删除购物车商品
- (void)removeShopCartShoppings {
    
    NSMutableDictionary *headDic = [NSMutableDictionary dictionary];
    NSMutableDictionary *bodyDic = [NSMutableDictionary dictionary];
    
    [bodyDic setObject:@"removefromcar" forKey:@"functionid"];
    NSMutableArray *productIDs = [NSMutableArray array];
    NSMutableArray *tags = [NSMutableArray array];
    NSMutableArray *sellerids = [NSMutableArray array];
    
    for (ShoppingCarProduct *product in _selectedArr) {
        [productIDs addObject:product.productid];
        [tags addObject:product.tag];
        [sellerids addObject:product.sellerid];
    }
    NSString *productid = [productIDs componentsJoinedByString:@","];
    NSString *tag = [tags componentsJoinedByString:@","];
    NSString *sellerid = [sellerids componentsJoinedByString:@","];
    [bodyDic setObject:productid?:@"" forKey:@"productid"];
    [bodyDic setObject:tag?:@"" forKey:@"tag"];
    [bodyDic setObject:sellerid?:@"" forKey:@"sellerids"];
    [bodyDic setObject:@"1" forKey:@"type"];
    
    if ([[AppInformationSingleton shareAppInfomationSingleton] getLoginCode]) {
        [headDic setObject:[[AppInformationSingleton shareAppInfomationSingleton] getLoginCode] forKey:@"ut"];
        [headDic setObject:[[AppInformationSingleton shareAppInfomationSingleton] getUserID] forKey:@"userid"];
    }
    
    [[NetWorkSingleton sharedManager] postWithHeadParameter:headDic bodyParameter:bodyDic SuccessBlock:^(id responseBody) {
        NSLog(@"responseBody:%@",responseBody);
        
        if (responseBody) {
            if ([responseBody isKindOfClass:[NSDictionary class]]) {
                
                NSDictionary *dic = (NSDictionary*)responseBody;
                NSString *resultcode = [[dic objectForKey:@"head"] objectForKey:@"resultcode"];
                NSString *resultdesc = [[dic objectForKey:@"head"] objectForKey:@"resultdesc"];
                if ([resultcode isEqualToString:@"0000"]) {
                    [self removeAllDatas];
                    [self getShoppingCartData];
                    [SVProgressHUD showSuccessWithStatus:@"操作成功" duration:3.0];
                    
                }
                else {
                    [SVProgressHUD showErrorWithStatus:resultdesc?:@"操作失败" duration:1.5];
                }
            }
        }
        
        
    } FailureBlock:^(NSString *error) {
        
    }];
    
    
}

/**
 *  提交订单按钮点击事件
 */
- (void)commitOrder
{
    
    if (_selectedArr.count == 0) {
        [SVProgressHUD showErrorWithStatus:@"请选择订单"];
        return;
    }
    
    NSLog(@"%s", __func__);
    self.hidesBottomBarWhenPushed = YES;
    OrderType orderType;
    if (_productType == kProductTypeEntity) {
        orderType = kOrderTypeHotelSupplies;
    }
    else {
        orderType = kOrderTypeReservation;
    }
    ConfirmHotelSuppliesOrderViewController2 * VC = [[ConfirmHotelSuppliesOrderViewController2 alloc]initWithDataSource:_dataSource withOrderType:orderType];
    VC.totalReturn = _totalReturn;
    VC.totalMoney = _totalMoney;
    [self.navigationController pushViewController:VC animated:YES];
    
}

/// 清除所有数据
- (void)removeAllDatas {
    [_selectedArr removeAllObjects];
    [_buyCountArr removeAllObjects];
    [_dataSource removeAllObjects];
    
}

/**
 *  全选按钮点击事件
 */
- (void)allSelectionButtonClicked:(UIButton*)btn
{
    NSLog(@"%s", __func__);
    
    BOOL isSelected = _AllselectionButton.selected;
    _AllselectionButton.selected = !isSelected;
    [_selectedArr removeAllObjects];
    
    if (_AllselectionButton.selected) {
        [_selectedArr addObjectsFromArray:_dataArr];
    }
    else {
        [self removeAllDatas];
    }
    
    [self caculateAllMoney];
    [self configureDataSource:_selectedArr];
    [self.mainTableView reloadData];

}

#pragma mark 装配数据
/// 装配数据
- (void)configureDataSource:(NSArray*)dataSource {
    
    if (_selectedArr.count == 0) {return;}
    [_dataSource removeAllObjects];
    for (int i = 0; i < dataSource.count; i++) {
        ShoppingCarProduct *product = dataSource[i]?:[ShoppingCarProduct new];
        NSString *buycount = _buyCountArr[i]?:@"1";
        NSArray *arr = @[product, buycount];
        [_dataSource addObject:arr];
    }
}


#pragma mark 计算总金额
/// 计算总金额
- (void)caculateAllMoney {
    float allMoney = 0;
    int allReturn = 0;
    [_buyCountArr removeAllObjects];
    for (ShoppingCarProduct *product in _selectedArr) {
        NSInteger days = [self getDaysIndate:product.indate?:@"2015-12-12" outDate:product.outdate?:@"215-12-13"];
        allMoney += product.price.floatValue * product.buycount.intValue * days;
        allReturn += product.coinreturn.intValue * product.buycount.intValue * days;
        [_buyCountArr addObject:product.buycount?:@"1"];
        _totalReturn = allReturn;
        _totalMoney = allMoney/100.0;

    }
    self.totalMoneyLabel.text = [NSString stringWithFormat:@"￥%0.2f",allMoney/100.0];
    self.totalCoinLabel.text = [NSString stringWithFormat:@"%d",allReturn];
}



#pragma mark - 网络

- (void)getShoppingCartData
{
    if(![[Reachability reachabilityForInternetConnection]isReachable])
    {
        NSString *showMsg = @"请检查网络";
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"提示"
                                                        message: showMsg
                                                       delegate: self
                                              cancelButtonTitle: @"确定"
                                              otherButtonTitles: nil, nil];
        
        [alert show];
        
        return;
    }
    
    [SVProgressHUD show];
    
    NSMutableDictionary * headDic = [[NSMutableDictionary alloc] initWithCapacity:1];
    
    NSMutableDictionary * bodyDic = [[NSMutableDictionary alloc] initWithCapacity:1];
    [bodyDic setObject:@"getmybuycar" forKey:@"functionid"];
    
    if ([[AppInformationSingleton shareAppInfomationSingleton] getLoginCode]) {
        [headDic setObject:[[AppInformationSingleton shareAppInfomationSingleton] getLoginCode] forKey:@"ut"];
        [headDic setObject:[[AppInformationSingleton shareAppInfomationSingleton] getUserID] forKey:@"userid"];
    }
    
    [bodyDic setObject:[NSString stringWithFormat:@"%ld",_productType] forKey:@"producttype"];
    [bodyDic setObject:@"1" forKey:@"type"];
    [bodyDic setObject:@"1" forKey:@"pageno"];
    [bodyDic setObject:@"100" forKey:@"pagesize"];
    
    
    [[NetWorkSingleton sharedManager] postWithHeadParameter:headDic bodyParameter:bodyDic SuccessBlock:^(id responseBody) {
        
        if (responseBody) {
            if ([responseBody isKindOfClass:[NSDictionary class]]) {
                
                
                id products = responseBody[@"body"][@"products"];
                
                if ([products isKindOfClass:[NSDictionary class]]) {
                    ShoppingCarProduct * model = [ShoppingCarProduct modelObjectWithDictionary:products[@"product"]];
                    [_dataArr removeAllObjects];
                    [_dataArr addObject:model];
                    [self.mainTableView reloadData];
                    
                }else{
                    _modelParser = [[ShoppingCarModelParser alloc]initWithDictionary:responseBody];
                    [_dataArr removeAllObjects];
                    [_dataArr addObjectsFromArray:_modelParser.shoppingCarModel.shoppingCarProduct];
                    [self.mainTableView reloadData];
                }
                
            }
        }
        
        [SVProgressHUD dismiss];
        NSLog(@"result = %@",responseBody);
        
    } FailureBlock:^(NSString *error) {
        
        [SVProgressHUD dismiss];
        
    }];
}

- (NSInteger)getDaysIndate:(NSString*)inDate outDate:(NSString*)outDate {
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = @"yyyy-MM-dd";
    NSDate *beginDate = [formatter dateFromString:inDate];
    NSDate *endDate = [formatter dateFromString:outDate];
    NSTimeInterval interval = [endDate timeIntervalSinceDate:beginDate];
    NSInteger days = interval / (24 * 3600);
    (days <= 0)?(days = 1):(days = days);
    return days;
}


@end
