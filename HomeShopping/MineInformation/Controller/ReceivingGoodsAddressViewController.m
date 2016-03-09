//
//  ReceivingGoodsAddressViewController.m
//  HomeShopping
//
//  Created by sooncong on 16/1/8.
//  Copyright © 2016年 Administrator. All rights reserved.
//  管理收货地址

#import "ReceivingGoodsAddressViewController.h"
#import "ModifyAddrViewController.h"
#import "AddrCell.h"
#import "AddressModelParser.h"
#import "Addresse.h"

@implementation ReceivingGoodsAddressViewController
{
    NSMutableArray * _dataSource;
}

#pragma mark - 生命周期

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self getAddrList];
    
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    _dataSource = [[NSMutableArray alloc] initWithCapacity:1];
    
    [self loadCostomViw];
    
}

#pragma mark - 自定义视图

/**
 *  装载自定义视图 总览
 */
- (void)loadCostomViw
{
    [self setNavigationBarLeftButtonImage:@"NavBar_Back"];
    
    [self setNavigationBarTitle:@"管理收货地址"];
    
    [self loadMainTableView];
}

- (void)loadMainTableView
{
    
    UIView * bottomView = [UIView new];
    [self.view addSubview:bottomView];
    [bottomView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.and.bottom.mas_equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, GET_SCAlE_HEIGHT(50)));
    }];
    bottomView.backgroundColor = UIColorFromRGB(GRAYBGCOLOR);
    
    UIButton * doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [bottomView addSubview:doneButton];
    [doneButton makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(bottomView.center);
        make.size.mas_equalTo(CGSizeMake(GET_SCAlE_LENGTH(140), GET_SCAlE_HEIGHT(22)));
    }];
    [doneButton setTitle:@"添加新地址" forState:UIControlStateNormal];
    [doneButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [doneButton setTitleColor:UIColorFromRGB(WHITECOLOR) forState:UIControlStateNormal];
    [doneButton setBackgroundImage:[UIImage imageNamed:@"mine_ellipseButtonBG"] forState:UIControlStateNormal];
    [doneButton setBackgroundImage:[UIImage imageNamed:@"mine_ellipseButtonBG"] forState:UIControlStateHighlighted];
    [doneButton addTarget:self action:@selector(doneButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    
    self.mainTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.view addSubview:self.mainTableView];
    [self.mainTableView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.bottom.mas_equalTo(bottomView.top);
        make.top.mas_equalTo(self.customNavigationBar.bottom);
    }];
    
    self.mainTableView.delegate       = self;
    self.mainTableView.dataSource     = self;
    self.mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.mainTableView registerClass:[AddrCell class] forCellReuseIdentifier:@"AddrCell"];
}

#pragma mark - UITableviewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return GET_SCAlE_HEIGHT(85);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AddrCell * AddrCell = [tableView dequeueReusableCellWithIdentifier:@"AddrCell"];
    
    if (_dataSource.count > 0) {
        
        [AddrCell cellForRowWithModel:_dataSource[indexPath.row]];
    }
    
    [AddrCell callBackWithBlock:^(AddrClickType AddrClickType) {
        
        [self cellDidClickedWithAddrClickType:AddrClickType withCell:AddrCell indexPath:indexPath];
        
    }];
    
    return AddrCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    Addresse * model = _dataSource[indexPath.row];
    !self.callbackAddressID ?: self.callbackAddressID(model);
    if (self.callbackAddressID) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - 事件

-(void)leftButtonClicked
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)rightButtonClicked
{
    
}

/**
 *  完成按钮点击事件
 */
- (void)doneButtonClicked
{
    NSLog(@"%s", __func__);
    self.hidesBottomBarWhenPushed = YES;
    ModifyAddrViewController * VC = [[ModifyAddrViewController alloc] initWithWithTitle:@"添加新地址"];
    [self.navigationController pushViewController:VC animated:YES];
}

/**
 *  cell点击事件
 *
 *  @param type 点击类型
 */
- (void)cellDidClickedWithAddrClickType:(AddrClickType)type withCell:(AddrCell *)cell indexPath:(NSIndexPath *)indexPath
{
    switch (type) {
        case kAddrClickTypeSelection: {
            BOOL isSlected = cell.selectionButton.selected;
            cell.selectionButton.selected = !isSlected;
            [self sendRequestForUpdateAddress:_dataSource[indexPath.row] selected:cell.selectionButton.selected];
            break;
        }
        case kAddrClickTypeEdit: {
            self.hidesBottomBarWhenPushed = YES;
            ModifyAddrViewController * VC = [[ModifyAddrViewController alloc] initForUpdateAddress:_dataSource[indexPath.row] selected:cell.selectionButton.selected];
            VC.defaultAddress = cell.selectionButton.selected;
            [self.navigationController pushViewController:VC animated:YES];
            break;
        }
        case kAddrClickTypeDelete: {
            if (_dataSource.count > 0) {
                Addresse * model = _dataSource[indexPath.row];
                [self deleteAddrWithAdddressid:model.addressid];
            }
            break;
        }
    }
}

#pragma mark - 获取收货地址列表

/**
 *  获取收货地址
 */
- (void)getAddrList
{
    [[NetWorkSingleton sharedManager] getReceivingGoodsAddressWhetherGetDefaultAddress:YES GetReight:YES GetPayType:YES SuccessBlock:^(id responseBody) {
        
        AddressModelParser * parser = [[AddressModelParser alloc] initWithDictionary:responseBody];
        NSArray * arr = parser.addressModel.addresse;
        
        id arrM = responseBody[@"body"][@"addresses"];
        [_dataSource removeAllObjects];
        
        if ([arrM isKindOfClass:[NSDictionary class]]) {
            Addresse * model = [Addresse modelObjectWithDictionary:arrM[@"address"]];
            [_dataSource addObject:model];
        }else{
            [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if ([obj isKindOfClass:[Addresse class]]) {
                    [_dataSource addObject:obj];
                }
            }];
        }
        
        [self.mainTableView reloadData];
        
        
    } FailureBlock:^(NSString *error) {
        
    }];
}

- (void)deleteAddrWithAdddressid:(NSString * )addressid
{
    [[NetWorkSingleton sharedManager] deleteReceivingGoodsAddressWithID:addressid SuccessBlock:^(id responseBody) {
        
        NSLog(@"result = %@",responseBody);
        
        [self getAddrList];
        
    } FailureBlock:^(NSString *error) {
        
    }];
}


#pragma mark 更默认状态

- (void)sendRequestForUpdateAddress:(Addresse*)address selected:(BOOL)selected {
    
    NSMutableDictionary *bodyDic = [NSMutableDictionary dictionaryWithObject:@"updateshaddress" forKey:@"functionid"];
    NSMutableDictionary *addressDic = [NSMutableDictionary dictionaryWithObject:address.consignee forKey:@"consignee"];
    [addressDic setObject:address.consigneeaddress?:@"" forKey:@"consigneeaddress"];
    [addressDic setObject:address.consigneephone?:@"" forKey:@"consigneephone"];
    [addressDic setObject:address.postcode?:@""forKey:@"postcode"];
    [addressDic setObject:address.pca forKey:@"pca"];
    
    [addressDic setObject:address.addressid?:@"" forKey:@"addressid"];
    
    NSMutableDictionary *headDic = [NSMutableDictionary dictionary];
    if ([[AppInformationSingleton shareAppInfomationSingleton] getLoginCode]) {
        [headDic setObject:[[AppInformationSingleton shareAppInfomationSingleton] getLoginCode] forKey:@"ut"];
        [headDic setObject:[[AppInformationSingleton shareAppInfomationSingleton] getUserID] forKey:@"userid"];
    }
    
    
    
    [addressDic setObject:address.city?:@"" forKey:@"city"];
    [addressDic setObject:address.area?:@"" forKey:@"area"];
    [addressDic setObject:selected?@"1":@"0" forKey:@"isdefault"];
    [addressDic setObject:address.province?:@"" forKey:@"province"];
    
    [bodyDic setObject:addressDic forKey:@"address"];
    
    [[NetWorkSingleton sharedManager] postWithHeadParameter:headDic bodyParameter:bodyDic SuccessBlock:^(id responseBody) {
        NSLog(@"responseBody:%@",responseBody);
        NSDictionary *dic = (NSDictionary*)responseBody;
        NSString *resultcode = [[dic objectForKey:@"head"] objectForKey:@"resultcode"];
        if ([resultcode isEqualToString:@"0000"]) {
            [SVProgressHUD showSuccessWithStatus:@"操作成功"];
            [self getAddrList];
        }
    } FailureBlock:^(NSString *error) {
        [SVProgressHUD showSuccessWithStatus:error];
        
    }];
    
}



@end










