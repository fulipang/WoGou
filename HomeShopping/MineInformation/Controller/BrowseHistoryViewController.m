//
//  BrowseHistoryViewController.m
//  HomeShopping
//
//  Created by sooncong on 16/1/9.
//  Copyright © 2016年 Administrator. All rights reserved.
//

#import "BrowseHistoryViewController.h"
#import "PublicCollectionCell.h"
#import "ProductDetail.h"
#import "HotelDetailModel.h"
#import "HotelSuppliesCommodityDetailViewController.h"
#import "RoomReserVationDetailViewController.h"

@implementation BrowseHistoryViewController
{
    NSMutableArray * _dataSource;
}

#pragma mark - 生命周期

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    _dataSource = [NSMutableArray array];
    
    NSArray * history = [[AppInformationSingleton shareAppInfomationSingleton] getBrowseHistory];
    [_dataSource addObjectsFromArray:history];
    
    [self loadCostomViw];
}

#pragma mark - 自定义视图

/**
 *  装载自定义视图 总览
 */
- (void)loadCostomViw
{
    [self setNavigationBarLeftButtonImage:@"NavBar_Back"];
    
    [self createCustomRightButtonWithTitle:@"一键清除"];
    
    [self setNavigationBarTitle:@"浏览历史"];
    
    [self loadMainTableView];
}

- (void)createCustomRightButtonWithTitle:(NSString *)title
{
    UIButton * rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.customNavigationBar addSubview:rightBtn];
    [rightBtn makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.customNavBarLeftBtn.centerY);
        make.height.mas_equalTo(self.customNavBarLeftBtn.mas_height);
        make.width.mas_equalTo(@100);
        make.right.mas_equalTo(self.view.right);
    }];
    [rightBtn setTitle:title forState:UIControlStateNormal];
    [rightBtn.titleLabel setFont:[UIFont systemFontOfSize:TITLENAMEFONTSIZE]];
    [rightBtn setTitleColor:UIColorFromRGB(WHITECOLOR) forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(rightButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)loadMainTableView
{
    self.mainTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.view addSubview:self.mainTableView];
    [self.mainTableView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.and.bottom.mas_equalTo(self.view);
        make.top.mas_equalTo(self.customNavBarLeftBtn.bottom);
    }];
    
    self.mainTableView.delegate       = self;
    self.mainTableView.dataSource     = self;
    self.mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
//    if (_dataSource.count == 0) {
//        [self showEmptyViewWithTableView:self.mainTableView];
//    }else{
//        [self removeEmptyViewWithTableView:self.mainTableView];
//    }
    
    [self.mainTableView registerClass:[PublicCollectionCell class] forCellReuseIdentifier:@"cell"];
}

#pragma mark - UITableviewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return GET_SCAlE_LENGTH(127);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_dataSource.count == 0) {
        [self showEmptyViewWithTableView:self.mainTableView];
    }else{
        [self removeEmptyViewWithTableView:self.mainTableView];
    }
    
    return _dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PublicCollectionCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (_dataSource.count > 0) {
        id temModel = _dataSource[indexPath.row];
        
        if ([temModel isKindOfClass:[ProductDetail class]]) {
            ProductDetail * model = (ProductDetail *)temModel;
            [cell setCellWithCollectionModel:(CollectionProduct *)model];
        }
        else
        {
            HotelDetailModel * model = (HotelDetailModel *)temModel;
            [cell setCellWithHotelDetailModel:model];
        }
    }
    
    [cell callBackWithBlock:^(PublicCollectionViewClickType type) {
        
        [self cellClickedWithType:type Index:indexPath.row];
        
    }];
    
    return cell;
}

#pragma mark - 事件

- (void)cellClickedWithType:(PublicCollectionViewClickType)type Index:(NSInteger)index
{
    switch (type) {
        case kPublicColletionClickTypeCheck: {
            
            id temModel = _dataSource[index];
            
            if ([temModel isKindOfClass:[ProductDetail class]]) {
                ProductDetail * model = (ProductDetail *)temModel;
                self.hidesBottomBarWhenPushed = YES;
                HotelSuppliesCommodityDetailViewController * VC = [[HotelSuppliesCommodityDetailViewController alloc] initWithProductID:model.productid];
                [self.navigationController pushViewController:VC animated:YES];
            }else{
                HotelDetailModel * model = (HotelDetailModel *)temModel;
                self.hidesBottomBarWhenPushed = YES;
                RoomReserVationDetailViewController * VC = [[RoomReserVationDetailViewController alloc] initWithSellerID:model.sellerid];
                [self.navigationController pushViewController:VC animated:YES];
            }
            
            break;
        }
        case kPublicColletionClickTypedelete: {
            [[AppInformationSingleton shareAppInfomationSingleton] deleteBrowseHistoryAtIndex:index];
            [_dataSource removeAllObjects];
            NSArray * arrM = [[AppInformationSingleton shareAppInfomationSingleton] getBrowseHistory];
            [_dataSource addObjectsFromArray:arrM];
            
            [self.mainTableView reloadData];
            
            break;
        }
    }
    
}

-(void)leftButtonClicked
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)rightButtonClicked
{
    NSString *showMsg = @"确定清楚所有浏览历史记录？";
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @""
                                                    message: showMsg
                                                   delegate: self
                                          cancelButtonTitle:@"取消"
                                          otherButtonTitles: @"确定", nil];
    
    [alert show];

}

#pragma mark - UIAlertViewDelegate

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
//        NSLog(@"%s", __func__);
        [[AppInformationSingleton shareAppInfomationSingleton] deleteAllBrowseHistory];
        [_dataSource removeAllObjects];
        [self.mainTableView reloadData];
    }
}

@end
