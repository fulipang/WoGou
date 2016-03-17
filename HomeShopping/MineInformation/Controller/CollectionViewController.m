
//
//  CollectionViewController.m
//  HomeShopping
//
//  Created by sooncong on 16/1/9.
//  Copyright © 2016年 Administrator. All rights reserved.
//

#import "CollectionViewController.h"
#import "SCSegmentControl.h"
#import "PublicCollectionCell.h"
#import "CollectionModelParser.h"
#import "CollectionProduct.h"
#import "HotelSuppliesCommodityDetailViewController.h"
#import "RoomReserVationDetailViewController.h"
#import "CollectionHotelListModelParser.h"

@implementation CollectionViewController
{
    //标题栏分段控制器
    SCSegmentControl * _segmentControl;
    
    NSMutableArray * _dataSource;
    
    ProductType _productType;
    
    NSInteger _totalPage;
    NSInteger _currentPage;
}

#pragma mark - 生命周期

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (_dataSource.count > 0) {
        [_dataSource removeAllObjects];
    }
    [self getCollectionData];
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initDataSource];
    
    [self loadCostomViw];
}

#pragma mark - 自定义视图

- (void)initDataSource
{
    _productType = kProductTypeVirtual;

    _dataSource = [NSMutableArray array];
}

/**
 *  装载自定义视图 总览
 */
- (void)loadCostomViw
{
    
    [self setNavigationBarLeftButtonImage:@"NavBar_Back"];
    
//    [self setUpSegmentView];
    [self setNavigationBarTitle:@"我的收藏"];
    [self loadMainTableView];
}

- (void)setUpSegmentView
{
    _segmentControl = [[SCSegmentControl alloc] initWithFrame:CGRectMake(0, 0, GET_SCAlE_LENGTH(205),30)];
    [self.customNavigationBar addSubview:_segmentControl];
    [_segmentControl makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.customNavigationBar.centerX);
        make.centerY.mas_equalTo(self.customNavBarLeftBtn.centerY);
        make.size.mas_equalTo(CGSizeMake(GET_SCAlE_LENGTH(205), 30));
    }];
    
    _segmentControl.layer.cornerRadius = 5;
    _segmentControl.clipsToBounds = YES;
    [_segmentControl callBackWithBlock:^(SCSegmentControlClickType clickType) {
        
        [self segmentClickedWithType:clickType];
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
    
    [self.mainTableView registerClass:[PublicCollectionCell class] forCellReuseIdentifier:@"cell"];
    
    [self addPush2LoadMoreWithTableView:self.mainTableView];
    [self addpull2RefreshWithTableView:self.mainTableView];
}

#pragma mark - UITableviewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return GET_SCAlE_HEIGHT(127);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PublicCollectionCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    [cell callBackWithBlock:^(PublicCollectionViewClickType type) {
        
        [self cellClickWithOperationType:type IndexPath:indexPath];
        
    }];

    if (_dataSource.count > 0) {
        
        switch (_productType) {
            case kProductTypeEntity: {
                //                            CollectionProduct * model = _dataSource[indexPath.row];
                [cell setCellWithCollectionModel:_dataSource[indexPath.row]];
                //                            self.hidesBottomBarWhenPushed = YES;
                //                            HotelSuppliesCommodityDetailViewController * VC = [[HotelSuppliesCommodityDetailViewController alloc] initWithProduct:model];
                //                            [self.navigationController pushViewController:VC animated:YES];
                break;
            }
            case kProductTypeVirtual: {
//                [cell setCellWithCollectionModel:_dataSource[indexPath.row]];
                [cell setCellWithSellerModel:_dataSource[indexPath.row]];
                break;
            }
        }
    }
    
//    if (_dataSource.count > 0) {
//        [cell setCellWithCollectionModel:_dataSource[indexPath.row]];
//    }
    
//    //回调cell点击事件
//    [cell callBackWithBlock:^(PublicCollectionViewClickType type) {
//        
//    }];
    
    return cell;
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
        
        [self getCollectionData];
    }
    else
    {
        [self performSelector:@selector(endRefreshing) withObject:nil afterDelay:0.5];
    }
}

- (void)pull2RefreshWithScrollerView:(UIScrollView *)scrollerView
{
    _currentPage = 1;
    [_dataSource removeAllObjects];
    [self getCollectionData];
}

#pragma mark - 网络

- (void)getCollectionData
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
    [bodyDic setObject:@"getmybuycar" forKey:@"functionid"];
    [bodyDic setObject:[NSString stringWithFormat:@"%ld",_currentPage] forKey:@"pageno"];
    
    if ([[AppInformationSingleton shareAppInfomationSingleton] getLoginCode]) {
        [headDic setObject:[[AppInformationSingleton shareAppInfomationSingleton] getLoginCode] forKey:@"ut"];
        [headDic setObject:[[AppInformationSingleton shareAppInfomationSingleton] getUserID] forKey:@"userid"];
    }
    
    switch (_productType) {
        case kProductTypeEntity: {
            [bodyDic setObject:[NSString stringWithFormat:@"1"] forKey:@"producttype"];
            break;
        }
        case kProductTypeVirtual: {
            [bodyDic setObject:[NSString stringWithFormat:@"3"] forKey:@"producttype"];
            break;
        }
    }
    [bodyDic setObject:@"2" forKey:@"type"];
    
    
    [[NetWorkSingleton sharedManager] postWithHeadParameter:headDic bodyParameter:bodyDic SuccessBlock:^(id responseBody) {
        
        [SVProgressHUD dismiss];
        NSLog(@"result = %@",responseBody);
        
        
        if (_productType == kProductTypeEntity) {
            CollectionModelParser * parser = [[CollectionModelParser alloc] initWithDictionary:responseBody];
        
            id arrM = responseBody[@"body"][@"products"];
            
            if ([arrM isKindOfClass:[NSDictionary class]]) {
                CollectionProduct * model = [CollectionProduct modelObjectWithDictionary:arrM[@"product"]];
                [_dataSource addObject:model];
            }else{
                [_dataSource addObjectsFromArray:parser.collectionModel.collectionProduct];
            }
            

        }else{
            CollectionHotelListModelParser * parser = [[CollectionHotelListModelParser alloc] initWithDictionary:responseBody];
//            [_dataSource addObjectsFromArray:parser.collectionHotelListModel.sellers];
            
            id arrM = responseBody[@"body"][@"sellers"];
            
            if ([arrM isKindOfClass:[NSDictionary class]]) {
                Sellers * model = [Sellers modelObjectWithDictionary:arrM[@"seller"]];
                [_dataSource addObject:model];
            }else{
                [_dataSource addObjectsFromArray:parser.collectionHotelListModel.sellers];
            }
            
        }
        
        [self endRefreshing];
        
        if (_dataSource.count == 0) {
            [self showEmptyViewWithTableView:self.mainTableView];
        }else{
            [self removeEmptyViewWithTableView:self.mainTableView];
        }

        [self.mainTableView reloadData];
        
    } FailureBlock:^(NSString *error) {
        
        [self endRefreshing];
        
        [SVProgressHUD dismiss];
        
    }];
}

- (void)deleteCollectionWithIndexPath:(NSIndexPath *)indexPath
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
    [bodyDic setObject:@"removefromcar" forKey:@"functionid"];
    [bodyDic setObject:@"2" forKey:@"type"];
    
    switch (_productType) {
        case kProductTypeEntity: {
            CollectionProduct * model = _dataSource[indexPath.row];
            [bodyDic setObject:model.tag forKey:@"tag"];
            [bodyDic setObject:model.productid forKey:@"productid"];
            break;
        }
        case kProductTypeVirtual: {
            Sellers * model = _dataSource[indexPath.row];
            [bodyDic setObject:model.sellerid forKey:@"sellerid"];
            break;
        }
    }
    
    NSString * userid = [[AppInformationSingleton shareAppInfomationSingleton] getUserID];
    NSString * ut = [[AppInformationSingleton shareAppInfomationSingleton] getLoginCode];
    
    if (userid) {
        [headDic setObject:userid forKey:@"userid"];
        [headDic setObject:ut forKey:@"ut"];
    }
    
    [[NetWorkSingleton sharedManager] postWithHeadParameter:headDic bodyParameter:bodyDic SuccessBlock:^(id responseBody) {
        
        BOOL isSuccess = [self isRequestSuccess:responseBody];
        
        if (isSuccess) {
            [_dataSource removeAllObjects];
            [self getCollectionData];
        }
        
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

- (void)cellClickWithOperationType:(PublicCollectionViewClickType)type IndexPath:(NSIndexPath *)indexPath
{
    switch (type) {
        case kPublicColletionClickTypeCheck: {
            
            if (_productType == kProductTypeEntity) {
                
                CollectionProduct * model = _dataSource[indexPath.row];
                self.hidesBottomBarWhenPushed = YES;
                HotelSuppliesCommodityDetailViewController * VC = [[HotelSuppliesCommodityDetailViewController alloc] initWithProduct:model];
                [self.navigationController pushViewController:VC animated:YES];
                
            }
            
            else
            {
                Sellers * model = _dataSource[indexPath.row];
                self.hidesBottomBarWhenPushed = YES;
                RoomReserVationDetailViewController *VC = [[RoomReserVationDetailViewController alloc] initWithHotelModel:(Hotels *)model];
                [self.navigationController pushViewController:VC animated:YES];
            }
            
            break;
        }
        case kPublicColletionClickTypedelete: {
            
            [self deleteCollectionWithIndexPath:indexPath];
            
            break;
        }
    }
}

- (void)segmentClickedWithType:(SCSegmentControlClickType)type
{
    switch (type) {
        case kSCSegClickLeft: {
            _productType = kProductTypeEntity;
            break;
        }
        case kSCSegClickRight: {
            _productType = kProductTypeVirtual;
            break;
        }
    }

    _currentPage = 1;
    [_dataSource removeAllObjects];
    [self getCollectionData];
}

@end
