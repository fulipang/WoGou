//
//  MyOrderHotelSuppliesViewController.m
//  HomeShopping
//
//  Created by sooncong on 16/1/10.
//  Copyright © 2016年 Administrator. All rights reserved.
//

#import "MyOrderHotelSuppliesViewController.h"
#import "OrderDetailHotelSuppliesViewController.h"
#import "GiveCommentViewController.h"
#import "OrderProductCell.h"
//#import "OrderDetailViewController.h"
#import "OrderListModelParser.h"
#import "Orders.h"
#import "Products.h"


#define HEADVIEWHEGHT GET_SCAlE_HEIGHT(115/2.0)

@interface MyOrderHotelSuppliesViewController ()

@end

@implementation MyOrderHotelSuppliesViewController
{
    NSMutableArray * _dataSource;

    NSInteger _currentPage;
    NSInteger _totalPage;
    
    OrderStatusType _OrderStatusType;

    NSIndexPath * _currentIndexPath;
}


#pragma mark - 生命周期

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (_OrderStatusType == 0) {
        _OrderStatusType = kOrderStatusAll;
    }
    
    if (_dataSource.count > 0) {
        [_dataSource removeAllObjects];
    }
    [self getOrderData];

}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    _dataSource = [NSMutableArray array];
    
    [self loadCostomViw];
}

#pragma mark - 自定义视图

/**
 *  装载自定义视图 总览
 */
- (void)loadCostomViw
{
    [self setNavigationBarLeftButtonImage:@"NavBar_Back"];
    
    [self setNavigationBarTitle:@"我的商品订单"];
    
    [self setUpSegmentView];
    
    [self loadMainTableView];
    
    _dataSource = [NSMutableArray array];
    
}

- (void)setUpSegmentView
{
    _segHeadView = [[SegmentTapView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, GET_SCAlE_HEIGHT(40)) withDataArray:[NSArray arrayWithObjects:@"全部",@"已付款",@"待付款", nil] withFont:TITLENAMEFONTSIZE];
    [self.view addSubview:_segHeadView];
    [_segHeadView makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.customNavigationBar.bottom);
        make.centerX.mas_equalTo(self.view.centerX);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, GET_SCAlE_HEIGHT(40)));
    }];
    [_segHeadView setTextColor:UIColorFromRGB(BLACKFONTCOLOR) SelectedColor:UIColorFromRGB(LIGHTBLUECOLOR) NoticeViewColor:UIColorFromRGB(LIGHTBLUECOLOR)];
    [_segHeadView callBackWithBlock:^(NSInteger index) {

        [self segMentTapWithIndex:index];
        
    }];
    
//    UILabel * line = [UILabel new];
//    [_segHeadView addSubview:line];
//    [line makeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.mas_equalTo(_segHeadView.mas_bottom);
//        make.centerX.mas_equalTo(_segHeadView.centerX);
//        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 0.5));
//    }];
//    line.backgroundColor = UIColorFromRGB(LINECOLOR);
}

- (void)loadMainTableView
{
    self.mainTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.view addSubview:self.mainTableView];
    [self.mainTableView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.and.bottom.mas_equalTo(self.view);
        make.top.mas_equalTo(self.segHeadView.bottom);
    }];
    
    self.mainTableView.delegate       = self;
    self.mainTableView.dataSource     = self;
    self.mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.mainTableView registerClass:[OrderProductCell class] forCellReuseIdentifier:@"cell"];
    
    [self addpull2RefreshWithTableView:self.mainTableView];
    [self addPush2LoadMoreWithTableView:self.mainTableView];
}


#pragma mark - UITableviewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (_dataSource.count == 2) {
        for (id model in _dataSource) {
            if ([model isKindOfClass:[Orders class]]) {
                Orders * tmpOrder = (Orders *)model;
                if ([tmpOrder.orderid integerValue] == 0) {
                    return 1;
                }
            }
        }
    }
    
    return _dataSource.count;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, HEADVIEWHEGHT)];
    contentView.backgroundColor = UIColorFromRGB(WHITECOLOR);
    
    if (_dataSource.count > 0) {
        Orders * model = _dataSource[section];
        
        //画线
        UILabel * line = [UILabel new];
        [contentView addSubview:line];
        [line makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(contentView.top);
            make.centerX.mas_equalTo(contentView.mas_centerX);
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 0.5));
        }];
        line.backgroundColor = UIColorFromRGB(LINECOLOR);
        
        UILabel * line_middle = [UILabel new];
        [contentView addSubview:line_middle];
        [line_middle makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(contentView.top).with.offset(GET_SCAlE_HEIGHT(25));
            make.right.mas_equalTo(contentView.right);
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - GET_SCAlE_LENGTH(15), 0.5));
        }];
        line_middle.backgroundColor = UIColorFromRGB(LINECOLOR);
        
        UILabel * line_bottom = [UILabel new];
        [contentView addSubview:line_bottom];
        [line_bottom makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(contentView.mas_bottom);
            make.right.mas_equalTo(contentView.right);
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - GET_SCAlE_LENGTH(15), 0.5));
        }];
        line_bottom.backgroundColor = UIColorFromRGB(LINECOLOR);
        
        //订单相关
        UILabel * orderNumberLabel  = [UILabel new];
        [contentView addSubview:orderNumberLabel];
        [orderNumberLabel makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(line_middle).with.offset(GET_SCAlE_HEIGHT(-25/2.0));
            make.left.mas_equalTo(contentView.left).with.offset(GET_SCAlE_LENGTH(15));
        }];
        orderNumberLabel.textColor = UIColorFromRGB(GRAYFONTCOLOR);
        orderNumberLabel.font = [UIFont systemFontOfSize:SMALLFONTSIZE];
        orderNumberLabel.text = @"订单号:";
        NSString * orderNumber = [NSString stringWithFormat:@"订单号:%@",model.ordernum];
        orderNumberLabel.text = orderNumber;
        
        UILabel * orderTimeLabel  = [UILabel new];
        [contentView addSubview:orderTimeLabel];
        [orderTimeLabel makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(orderNumberLabel.centerY).with.offset(0);
            make.right.mas_equalTo(contentView.right).with.offset(GET_SCAlE_LENGTH(-15));
        }];
        orderTimeLabel.textColor = UIColorFromRGB(GRAYFONTCOLOR);
        orderTimeLabel.font = [UIFont systemFontOfSize:SMALLFONTSIZE];
        orderTimeLabel.text = model.borndate;
        
        
        UILabel * companyLabel  = [UILabel new];
        [contentView addSubview:companyLabel];
        [companyLabel makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(line_middle).with.offset(GET_SCAlE_HEIGHT(65/4.0));
            make.left.mas_equalTo(contentView.left).with.offset(GET_SCAlE_LENGTH(15));
        }];
        companyLabel.textColor = UIColorFromRGB(BLACKFONTCOLOR);
        companyLabel.font = [UIFont systemFontOfSize:14];
        companyLabel.text = model.sellername;
        
        UIImageView * arrow = [[UIImageView alloc] init];
        arrow.image = [UIImage imageNamed:@"arrow_right"];
        [contentView addSubview:arrow];
        [arrow makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(companyLabel.centerY);
            make.right.mas_equalTo(contentView.right).with.offset(GET_SCAlE_LENGTH(-15));
            make.size.mas_equalTo(CGSizeMake(arrow.image.size.width, arrow.image.size.height));
        }];
    }
    //    arrow.backgroundColor = [UIColor orangeColor];
    
    return contentView;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return HEADVIEWHEGHT;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return GET_SCAlE_HEIGHT(230/2.0);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    Orders * model = _dataSource[section];
    NSArray * arrM = model.products;
    
    return ([self isRowOne:arrM Section:section])?1:arrM.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OrderProductCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    [cell setCellTypeWithOrderType:kOrderTypeHotelSupplies];
    
    if (_dataSource.count > 0) {
        Orders * order = _dataSource[indexPath.section];
        NSArray * arrM = order.products;
        
        if ([self isRowOne:arrM Section:indexPath.section]) {
            [arrM enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                if ([obj isKindOfClass:[Products class]]) {
                    Products * model = (Products *)obj;
                    if ([model.productid integerValue] != 0) {
                        [cell setCellWithModel:model OrderModel:order];
                        [cell callBackWithBlock:^{
                            
                            [self buttonClickWithIndexPath:indexPath];
                            
                        }];
                    }
                }
                
            }];
        }else{
            [cell setCellWithModel:arrM[indexPath.row] OrderModel:order];
        }
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_dataSource.count > 0) {
        self.hidesBottomBarWhenPushed = YES;
        OrderDetailHotelSuppliesViewController * VC = [[OrderDetailHotelSuppliesViewController alloc] initWithOrderModel:_dataSource[indexPath.section]];
        [self.navigationController pushViewController:VC animated:YES];
    }
}

-(void)pull2RefreshWithScrollerView:(UIScrollView *)scrollerView
{
    _currentPage = 1;
    [_dataSource removeAllObjects];
    [self getOrderData];
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
        [self getOrderData];
    }
    else
    {
        [self performSelector:@selector(endRefreshing) withObject:nil afterDelay:0.5];
    }
}

#pragma mark - 网络

- (void)getOrderData
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
    [bodyDic setObject:@"sj_orderlist" forKey:@"functionid"];
    [bodyDic setObject:@"1" forKey:@"producttype"];
    [bodyDic setObject:[NSString stringWithFormat:@"%ld",_currentPage] forKey:@"pageno"];
    [bodyDic setObject:[NSString stringWithFormat:@"%ld",_OrderStatusType] forKey:@"status"];
    
    NSString * userid = [[AppInformationSingleton shareAppInfomationSingleton] getUserID];
    NSString * ut = [[AppInformationSingleton shareAppInfomationSingleton] getLoginCode];
    
    if (userid) {
        [headDic setObject:userid forKey:@"userid"];
        [headDic setObject:ut forKey:@"ut"];
    }
    
    [[NetWorkSingleton sharedManager] postWithHeadParameter:headDic bodyParameter:bodyDic SuccessBlock:^(id responseBody) {
        
        if ([self isRequestSuccess:responseBody]) {
            [SVProgressHUD dismissWithSuccess:@"加载成功" afterDelay:1];
        }else{
            [SVProgressHUD dismiss];
        }
        
        OrderListModelParser * parser = [[OrderListModelParser alloc] initWithDictionary:responseBody];
        
        [_dataSource addObjectsFromArray:parser.orderListModel.orders];
        
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

#pragma mark - 事件

/**
 *  收货
 */
- (void)receiveAndCommentButtonClickedWithIndexPath:(NSIndexPath *)indexPath
{
    Orders * model = _dataSource[indexPath.section];
    
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
    [bodyDic setObject:@"qrreceived" forKey:@"functionid"];
    [bodyDic setObject:model.orderid forKey:@"orderid"];
    
    NSString * ut = [[AppInformationSingleton shareAppInfomationSingleton] getLoginCode];
    NSString * userid = [[AppInformationSingleton shareAppInfomationSingleton] getUserID];
    
    if (ut) {
        [headDic setObject:ut forKey:@"ut"];
        [headDic setObject:userid forKey:@"userid"];
    }
    
    [[NetWorkSingleton sharedManager] postWithHeadParameter:headDic bodyParameter:bodyDic SuccessBlock:^(id responseBody) {
        
        if ([self isRequestSuccess:responseBody]) {
            [SVProgressHUD dismissWithSuccess:@"收货成功"];
            
            [self toCommentButtonClickedWithIndexPath:indexPath];
            
        }else{
            [SVProgressHUD dismiss];
        }
        
    } FailureBlock:^(NSString *error) {
        
        [SVProgressHUD dismiss];
    }];
}

/**
 *  评价
 */
- (void)toCommentButtonClickedWithIndexPath:(NSIndexPath *)indexPath
{
    
    //    NSLog(@"%s", __func__);
    self.hidesBottomBarWhenPushed = YES;
    GiveCommentViewController * VC = [[GiveCommentViewController alloc] init];
    Orders * model = _dataSource[indexPath.section];
    VC.orderid = model.orderid;
    [self.navigationController pushViewController:VC animated:YES];
}


- (void)buttonClickWithIndexPath:(NSIndexPath *)indexPath
{
    if (_dataSource.count > 0) {
        Orders * model = _dataSource[indexPath.section];
        
        OrderStatusType type = [model.status integerValue];
        
        switch (type) {
            case kOrderStatusAll: {
                
                break;
            }
            case kOrderStatusWaitForPay: {
                [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(unSuccessedPay) name:kOrderPaymentViewControllerDidPayUnsuccessedNotification object:nil];
                self.hidesBottomBarWhenPushed = YES;
                OrderPaymentViewController * VC = [[OrderPaymentViewController alloc] initPrepayID:model.prepayid orderNumber:model.ordernum payType:kWeixinPayType];
                [self.navigationController pushViewController:VC animated:YES];
                break;
            }
            case kOrderStatusWaitForSendConsignment: {

                break;
            }
            case kOrderStatusWaitForReceiveProduct: {
                
                NSString *showMsg = @"确认收到货品？";
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @""
                                                                message: showMsg
                                                               delegate: self
                                                      cancelButtonTitle:@"取消"
                                                      otherButtonTitles: @"确定", nil];
                
                [alert show];
                
                _currentIndexPath = indexPath;
                break;
            }
            case kOrderStatusWaitForGiveComment: {
                [self toCommentButtonClickedWithIndexPath:indexPath];
                break;
            }
            case kOrderStatusAlreadyComment: {
                
                break;
            }
            case kOrderStatusAlreadyPayed: {
                
                break;
            }
        }
    }
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        [self receiveAndCommentButtonClickedWithIndexPath:_currentIndexPath];
    }
}

#pragma mark 支付未成功
- (void)unSuccessedPay {
    [self segMentTapWithIndex:2];
    [_segHeadView selectIndex:3];
}

- (void)segMentTapWithIndex:(NSInteger)index
{
    _currentPage = 1;
    
    switch (index) {
        case 0:
            _OrderStatusType = kOrderStatusAll;
            [_dataSource removeAllObjects];
            [self getOrderData];
            break;
            
        case 1:
            _OrderStatusType = kOrderStatusAlreadyPayed;
            [_dataSource removeAllObjects];
            [self getOrderData];
            break;
            
        case 2:
            _OrderStatusType = kOrderStatusWaitForPay;
            [_dataSource removeAllObjects];
            [self getOrderData];
            break;
            
        default:
            break;
    }
}


-(void)leftButtonClicked
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)rightButtonClicked
{
    
}

#pragma mark - 判断方法

- (BOOL)isRowOne:(NSArray *)dictionary Section:(NSInteger)section
{
    
    __block BOOL isOne = NO;
    
    if (dictionary.count == 2) {
        [dictionary enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if ([obj isKindOfClass:[Products class]]) {
                
                Products * model = (Products *)obj;
                
                if ([model.productid isEqualToString:@"0"]) {
                    isOne = YES;
                }
            }
        }];
    }
    
    return isOne;
}

@end
