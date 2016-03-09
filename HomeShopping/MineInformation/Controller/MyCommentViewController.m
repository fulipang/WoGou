//
//  MyCommentViewController.m
//  HomeShopping
//
//  Created by sooncong on 16/1/10.
//  Copyright © 2016年 Administrator. All rights reserved.
//

#import "MyCommentViewController.h"
#import "WaitCommentCell.h"
#import "CommentCell.h"
#import "GiveCommentViewController.h"
#import "OrderDetailHotelSuppliesViewController.h"
#import "CommentsModelParser.h"
#import "OrderListModelParser.h"
#import "Orders.h"
#import "Products.h"
#import "CommentsModelParser.h"
#import "OrderHotelCell.h"

@implementation MyCommentViewController
{
    CommentStatus _currentCommentType;
    
    NSMutableArray * _dataSource;
    
    //记录当前页
    NSInteger _currentPage;
    
    //记录当前类型
    NSInteger _currentType;
    
    //记录一共有多少页
    NSInteger  _totalPageCount;
    
    NSInteger  _requestType;
}

#pragma mark - 生命周期

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (_dataSource.count > 0) {
        [_dataSource removeAllObjects];
    }
    
    switch (_currentCommentType) {
        case kCommentStatusAll: {
            [self getOrderData];
            break;
        }
        case kCommentStatusWait: {
            [self getOrderData];
            break;
        }
        case kCommentStatusDone: {
            [self getMyCommentList];
            break;
        }
    }
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initDataSource];
    
    [self loadCostomViw];
    
//    [self getOrderData];
}

- (void)initDataSource
{
    _dataSource = [NSMutableArray array];
    _requestType = 8;
    _currentPage = 1;
    _currentCommentType = kCommentStatusAll;
//    _currentType = kCommentTypeAll;
}

#pragma mark - 自定义视图

/**
 *  装载自定义视图 总览
 */
- (void)loadCostomViw
{
    [self setNavigationBarLeftButtonImage:@"NavBar_Back"];
    
    [self setNavigationBarTitle:@"我的评价"];
    
    [self createHeaderView];
    
    [self loadMainTableView];
}

-(void)createHeaderView
{
    _segmentHeaderView = [[SegmentTapView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, GET_SCAlE_HEIGHT(40)) withDataArray:[NSArray arrayWithObjects:@"全部",@"待评价",@"已评价", nil] withFont:TITLENAMEFONTSIZE];
    [self.view addSubview:_segmentHeaderView];
    [_segmentHeaderView makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.customNavigationBar.bottom);
        make.left.and.right.mas_equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, GET_SCAlE_HEIGHT(40)));
    }];
    
    [_segmentHeaderView setTextColor:UIColorFromRGB(BLACKFONTCOLOR) SelectedColor:UIColorFromRGB(LIGHTBLUECOLOR) NoticeViewColor:UIColorFromRGB(LIGHTBLUECOLOR)];
    _segmentHeaderView.delegate = self;
    [_segmentHeaderView callBackWithBlock:^(NSInteger index) {
        
        _currentCommentType = index;
        _currentPage = 1;
        [_dataSource removeAllObjects];
        
        switch (_currentCommentType) {
            case kCommentStatusAll: {
                [self getOrderData];
                break;
            }
            case kCommentStatusWait: {
                [self getOrderData];
                break;
            }
            case kCommentStatusDone: {
                [self getMyCommentList];
                break;
            }
        }
        

        
//        [self.mainTableView reloadData];
        
    }];
    
    UILabel * line = [UILabel new];
    [_segmentHeaderView addSubview:line];
    [line makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(_segmentHeaderView.mas_bottom);
        make.centerX.mas_equalTo(_segmentHeaderView.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 0.5));
    }];
    line.backgroundColor = UIColorFromRGB(LINECOLOR);
}

- (void)loadMainTableView
{
    self.mainTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.view addSubview:self.mainTableView];
    [self.mainTableView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.and.bottom.mas_equalTo(self.view);
        make.top.mas_equalTo(self.segmentHeaderView.bottom);
    }];
    
    self.mainTableView.delegate       = self;
    self.mainTableView.dataSource     = self;
    self.mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    [self.mainTableView registerClass:[OrderProductCell class] forCellReuseIdentifier:@"cell"];
    [self.mainTableView registerClass:[OrderHotelCell class] forCellReuseIdentifier:@"OrderHotelCell"];
    [self.mainTableView registerClass:[CommentCell class] forCellReuseIdentifier:@"CommentCell"];
    
    [self addpull2RefreshWithTableView:self.mainTableView];
    [self addPush2LoadMoreWithTableView:self.mainTableView];
}

#pragma mark - UITableviewDelegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_currentCommentType == kCommentStatusDone) {
        
    }else{
        
        Orders * model = _dataSource[indexPath.section];
        self.hidesBottomBarWhenPushed = YES;
        OrderDetailHotelSuppliesViewController * VC = [[OrderDetailHotelSuppliesViewController alloc] initWithOrderModel:model];
        VC.isHotel = ([model.producttype integerValue] == 2)?YES:NO;
        [self.navigationController pushViewController:VC animated:YES];
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (_currentCommentType == kCommentStatusDone) {
        return _dataSource.count;
    }else{
    
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
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return GET_SCAlE_HEIGHT(65/2.0);
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, GET_SCAlE_HEIGHT(65/2.0))];

    
    if (_dataSource.count > 0) {
        
        Comments * model = _dataSource[section];
        
        if (_currentCommentType == kCommentStatusDone) {
            
            contentView.backgroundColor = [UIColor whiteColor];
            
            UILabel * companyNameLabel  = [UILabel new];
            [contentView addSubview:companyNameLabel];
            [companyNameLabel makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(contentView.centerY).with.offset(0);
                make.left.mas_equalTo(contentView.left).with.offset(GET_SCAlE_LENGTH(15));
            }];
            companyNameLabel.textColor = UIColorFromRGB(BLACKFONTCOLOR);
            companyNameLabel.font = [UIFont systemFontOfSize:TITLENAMEFONTSIZE];
            companyNameLabel.text = model.sellername;
            
            UILabel * line_bottom = [UILabel new];
            [contentView addSubview:line_bottom];
            [line_bottom makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.mas_equalTo(contentView.mas_bottom);
                make.right.mas_equalTo(contentView.right);
                make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - GET_SCAlE_LENGTH(15), 0.5));
            }];
            line_bottom.backgroundColor = UIColorFromRGB(LINECOLOR);
            
            if (section != 0) {
                
                UILabel * line = [UILabel new];
                [contentView addSubview:line];
                [line makeConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(contentView.top);
                    make.centerX.mas_equalTo(contentView.mas_centerX);
                    make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 0.5));
                }];
                line.backgroundColor = UIColorFromRGB(LINECOLOR);
            }
            
            UIImageView * arrow = [UIImageView new];
            arrow.image = [UIImage imageNamed:@"arrow_right"];
            [contentView addSubview:arrow];
            [arrow makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(contentView.centerY);
                make.right.mas_equalTo(contentView.right).with.offset(GET_SCAlE_LENGTH(-15));
                make.size.mas_equalTo(CGSizeMake(arrow.image.size.width, arrow.image.size.height));
            }];

        }else{
        
        Orders * order = _dataSource[section];
        
        contentView.backgroundColor = UIColorFromRGB(WHITECOLOR);
        
        UILabel * companyNameLabel  = [UILabel new];
        [contentView addSubview:companyNameLabel];
        [companyNameLabel makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(contentView.centerY).with.offset(0);
            make.left.mas_equalTo(contentView.left).with.offset(GET_SCAlE_LENGTH(15));
        }];
        companyNameLabel.textColor = UIColorFromRGB(BLACKFONTCOLOR);
        companyNameLabel.font = [UIFont systemFontOfSize:TITLENAMEFONTSIZE];
        companyNameLabel.text = order.sellername;
        
        UILabel * line_bottom = [UILabel new];
        [contentView addSubview:line_bottom];
        [line_bottom makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(contentView.mas_bottom);
            make.right.mas_equalTo(contentView.right);
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - GET_SCAlE_LENGTH(15), 0.5));
        }];
        line_bottom.backgroundColor = UIColorFromRGB(LINECOLOR);
        
        if (section != 0) {
            
            UILabel * line = [UILabel new];
            [contentView addSubview:line];
            [line makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(contentView.top);
                make.centerX.mas_equalTo(contentView.mas_centerX);
                make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 0.5));
            }];
            line.backgroundColor = UIColorFromRGB(LINECOLOR);
        }
        
        UIImageView * arrow = [UIImageView new];
        arrow.image = [UIImage imageNamed:@"arrow_right"];
        [contentView addSubview:arrow];
        [arrow makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(contentView.centerY);
            make.right.mas_equalTo(contentView.right).with.offset(GET_SCAlE_LENGTH(-15));
            make.size.mas_equalTo(CGSizeMake(arrow.image.size.width, arrow.image.size.height));
        }];
        }
    }
    
    return contentView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_currentCommentType == kCommentStatusDone) {
        
        if (_dataSource.count > 0) {
            return [self countCommentCellHeightWithModel:_dataSource[indexPath.section]];
        }
    }
    return GET_SCAlE_HEIGHT(115);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_currentCommentType == kCommentStatusDone) {
        return 1;
    }else{
        Orders * model = _dataSource[section];
        NSArray * arrM = model.products;
        return ([self isRowOne:arrM Section:section])?1:arrM.count;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (_currentCommentType == kCommentStatusDone) {
        
        CommentCell * cell = [tableView dequeueReusableCellWithIdentifier:@"CommentCell"];
        
        if (_dataSource.count > 0) {
            [cell setCellWithModel:_dataSource[indexPath.section]];
            
            [cell imageTaped:^(Comments *model) {
                [self CommentImageTapWithComment:model];

            }];
            
        }
        
        return cell;
        
    }else{
    
    if (_dataSource.count > 0) {
        Orders * order = _dataSource[indexPath.section];
        NSArray * arrM = order.products;
        
        if ([self isRowOne:arrM Section:indexPath.section]) {
            
            for (Products * model in arrM) {
                if ([model.productid integerValue] != 0) {
                    if ([model.producttype integerValue] == 1) {
                        OrderProductCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
                        [cell setCellTypeWithOrderType:kOrderTypeHotelSupplies];
                        [cell setCellWithModel:arrM[indexPath.row] OrderModel:order];
                        
                        [cell callBackWithBlock:^{
                            [self buttonClickWithIndexPath:indexPath];
                        }];
                        
                        return cell;
                    }else{
                        OrderHotelCell * cell = [tableView dequeueReusableCellWithIdentifier:@"OrderHotelCell"];
                        [cell setCellWithModel:arrM[indexPath.row] OrderModel:order];
                        
                        [cell callBackWithBlock:^{
                            [self buttonClickWithIndexPath:indexPath];
                        }];
                        
                        return cell;
                    }
                }
            }

        }else{
            
            if ([order.producttype integerValue] == 2) {
                OrderHotelCell * cell = [tableView dequeueReusableCellWithIdentifier:@"OrderHotelCell"];
                [cell setCellWithModel:arrM[indexPath.row] OrderModel:order];
                
                [cell callBackWithBlock:^{
                    [self buttonClickWithIndexPath:indexPath];
                }];
                
                return cell;
            }else{
                OrderProductCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
                [cell setCellTypeWithOrderType:kOrderTypeHotelSupplies];
                [cell setCellWithModel:arrM[indexPath.row] OrderModel:order];
                
                [cell callBackWithBlock:^{
                    [self buttonClickWithIndexPath:indexPath];
                }];
                
                return cell;
            }
        }
    }
    
        OrderProductCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        cell.codeTitleLabel.hidden = YES;
        return cell;
    }
}


-(void)pull2RefreshWithScrollerView:(UIScrollView *)scrollerView
{
    _currentPage = 1;
    [_dataSource removeAllObjects];

    if (_currentCommentType == kCommentStatusDone) {
        [self getMyCommentList];
    }else{
        [self getOrderData];
    }
    
}

-(void)push2LoadMoreWithScrollerView:(UIScrollView *)scrollerView
{
    if (_totalPageCount == 1)
    {
        [self performSelector:@selector(endRefreshing) withObject:nil afterDelay:1];
    }
    else if (_currentPage <_totalPageCount)
    {
        _currentPage ++;
        
        if (_currentCommentType == kCommentStatusDone) {
            [self getMyCommentList];
        }else{
            [self getOrderData];
        }
    }
    else
    {
        [self performSelector:@selector(endRefreshing) withObject:nil afterDelay:0.5];
    }
}

#pragma mark - 网络

- (void)getMyCommentList
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
    [bodyDic setObject:@"spcommentlist" forKey:@"functionid"];
    [bodyDic setObject:[NSString stringWithFormat:@"%ld",_currentPage] forKey:@"pageno"];
    //    [bodyDic setObject:[NSString stringWithFormat:@"%ld",_currentType] forKey:@"type"];
    
    if ([[AppInformationSingleton shareAppInfomationSingleton] getLoginCode]) {
        [headDic setObject:[[AppInformationSingleton shareAppInfomationSingleton] getLoginCode] forKey:@"ut"];
        [headDic setObject:[[AppInformationSingleton shareAppInfomationSingleton] getUserID] forKey:@"userid"];
        [bodyDic setObject:[[AppInformationSingleton shareAppInfomationSingleton] getUserID] forKey:@"userid"];
    }
    
    [SVProgressHUD show];
    
    [[NetWorkSingleton sharedManager] postWithHeadParameter:headDic bodyParameter:bodyDic SuccessBlock:^(id responseBody) {
        
        if ([self isRequestSuccess:responseBody]) {
            [SVProgressHUD dismissWithSuccess:@"加载成功" afterDelay:0.5];
        }else{
            [SVProgressHUD dismiss];
        }
        
        CommentsModelParser * parser = [[CommentsModelParser alloc] initWithDictionary:responseBody];
        NSArray * arrM = parser.commentsModel.comments;
        _totalPageCount = [parser.commentsModel.totalpage integerValue];
        
        [arrM enumerateObjectsUsingBlock:^(Comments *  comment, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if ([comment isKindOfClass:[Comments class]]) {
                if ([comment.commentid integerValue]!=0) {
                    [_dataSource addObject:comment];
                }
            }
        }];
        
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
    [bodyDic setObject:[NSString stringWithFormat:@"%ld",_currentPage] forKey:@"pageno"];
//    [bodyDic setObject:@"2" forKey:@"producttype"];
    
    switch (_currentCommentType) {
        case kCommentStatusAll: {
            [bodyDic setObject:@"8" forKey:@"status"];
            break;
        }
        case kCommentStatusWait: {
            [bodyDic setObject:@"4" forKey:@"status"];
            break;
        }
        case kCommentStatusDone: {
            
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
        
        if ([self isRequestSuccess:responseBody]) {
            [SVProgressHUD dismissWithSuccess:@"加载成功" afterDelay:0.5];
        }else{
            [SVProgressHUD dismiss];
        }
        
        OrderListModelParser * parser = [[OrderListModelParser alloc] initWithDictionary:responseBody];
        _totalPageCount =  [parser.orderListModel.totalpage integerValue];
        
        [_dataSource addObjectsFromArray:parser.orderListModel.orders];
        
        
        //        NSLog(@"result = %@",responseBody);
        
        [self endRefreshing];
        
        if (_dataSource.count == 0) {
            [self showEmptyViewWithTableView:self.mainTableView];
        }else{
            [self removeEmptyViewWithTableView:self.mainTableView];
        }
        
        [self.mainTableView reloadData];
        
    } FailureBlock:^(NSString *error) {
        [SVProgressHUD dismiss];
        
        [self endRefreshing];
    }];
}

#pragma mark - 事件

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
                self.hidesBottomBarWhenPushed = YES;
                OrderPaymentViewController * VC = [[OrderPaymentViewController alloc] initPrepayID:model.prepayid orderNumber:model.ordernum payType:kWeixinPayType];
                [self.navigationController pushViewController:VC animated:YES];
                break;
            }
            case kOrderStatusWaitForSendConsignment: {
                
                break;
            }
            case kOrderStatusWaitForReceiveProduct: {
//                [self receiveAndCommentButtonClickedWithIndexPath:indexPath];
                break;
            }
            case kOrderStatusWaitForGiveComment: {
//                [self toCommentButtonClickedWithIndexPath:indexPath];
                self.hidesBottomBarWhenPushed = YES;
                GiveCommentViewController * VC = [[GiveCommentViewController alloc] init];
                Orders * model = _dataSource[indexPath.section];
                VC.orderid = model.orderid;
                [self.navigationController pushViewController:VC animated:YES];
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

-(void)leftButtonClicked
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)rightButtonClicked
{
    
}

//- (void)getCommentList
//{
//    if(![[Reachability reachabilityForInternetConnection]isReachable])
//    {
//        return;
//    }
//    
//    NSMutableDictionary * headDic = [[NSMutableDictionary alloc] initWithCapacity:1];
//    
//    NSMutableDictionary * bodyDic = [[NSMutableDictionary alloc] initWithCapacity:1];
//    [bodyDic setObject:@"spcommentlist" forKey:@"functionid"];
//    [bodyDic setObject:[NSString stringWithFormat:@"%ld",_currentPage] forKey:@"pageno"];
////    [bodyDic setObject:[NSString stringWithFormat:@"%ld",_currentType] forKey:@"type"];
//    
//    if ([[AppInformationSingleton shareAppInfomationSingleton] getLoginCode]) {
//        [headDic setObject:[[AppInformationSingleton shareAppInfomationSingleton] getLoginCode] forKey:@"ut"];
//        [headDic setObject:[[AppInformationSingleton shareAppInfomationSingleton] getUserID] forKey:@"userid"];
//    }
//    
//    [[NetWorkSingleton sharedManager] postWithHeadParameter:headDic bodyParameter:bodyDic SuccessBlock:^(id responseBody) {
//        
//        NSLog(@"result = %@",responseBody);
//        CommentsModelParser * parser = [[CommentsModelParser alloc] initWithDictionary:responseBody];
//        NSArray * arrM = parser.commentsModel.comments;
//        _totalPageCount = [parser.commentsModel.totalpage integerValue];
//        
//        [arrM enumerateObjectsUsingBlock:^(Comments *  comment, NSUInteger idx, BOOL * _Nonnull stop) {
//            
//            if ([comment isKindOfClass:[Comments class]]) {
//                [_dataSource addObject:comment];
//            }
//        }];
//        
//        [self.mainTableView reloadData];
//        
//        [self endRefreshing];
//        
//    } FailureBlock:^(NSString *error) {
//        
//        [self endRefreshing];
//    }];
//}

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
