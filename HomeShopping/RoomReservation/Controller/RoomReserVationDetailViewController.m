//
//  RoomReserVationDetailViewController.m
//  HomeShopping
//
//  Created by sooncong on 16/1/12.
//  Copyright © 2016年 Administrator. All rights reserved.
//

#import "RoomReserVationDetailViewController.h"
#import "MapViewController.h"
#import "CommentViewController.h"
#import "ConfirmRoomOrderViewController.h"
#import "HotelDetaiViewController.h"
#import "UIImageView+WebCache.h"
#import "LoginViewController.h"
#import "ShoppingCartViewController.h"
#import "PreviewController.h"

//模型
#import "ProductDetailModelParser.h"
#import "ProductDetail.h"
#import "HShotelSuppliesModelParser.h"
#import "PossibleLikeModelParser.h"
#import "HSproductListModelParser.h"
#import "HotelDetailModelParser.h"
#import "HotelModelParser.h"
#import "CommentsModelParser.h"

//视图
#import "ProductDetailTabbar.h"
#import "ProductDetailHeaderView.h"
#import "ImageScrollView.h"
#import "SegmentTapView.h"
#import "cellDemonstrationView.h"

//cell
#import "RoomRaservationPossibleLikeCell.h"
#import "CommentCell.h"
#import "RoomReservationDetailCell.h"
#import "HotelSuppliesProductCell.h"
#import "Top5Cell.h"


//日历选择
#import "CalendarHomeViewController.h"
#import "CalendarViewController.h"
#import "Color.h"

#define NAVISPACE 18

@implementation RoomReserVationDetailViewController
{
    NSMutableArray * _dataSource;
    NSMutableArray * _commentData;
    NSMutableArray * _normData;
    NSMutableArray * _roomListData;
    
    //商品模型
    HSProduct * _product;
    ProductDetail * _productDetail;
    HotelDetailModel * _hotelDetail;
    Hotels * _hotel;
    
    //评论总数
    NSInteger _commentNum;
    
    
    NSString * _sellerID;
    
    //顶部视图
    ProductDetailHeaderView * _headView;
    ProductDetailTabbar * _tabbar;
    
    //标题seg背景
    UIView * _segBackView;
    
    //顶部滚动视图
    ImageScrollView * _ImageScrollHederView;
    
    //数据源
    NSArray * _adsData;
    cellDemonstrationView * _view;
    cellDemonstrationView * _view1;
    SegmentTapView * _segView;
    BOOL _top5;
    NSArray  *_monthDayArr;
}

-(instancetype)initWithHotelModel:(Hotels *)hotel
{
    self = [super init];
    
    if (self) {
        
        _hotel = hotel;
    }
    
    return self;
}

-(instancetype)initWithProduct:(id)product
{
    self = [super init];
    
    if (self) {
        
        if ([product isKindOfClass:[HSProduct class]]) {
            _product = (HSProduct *)product;
        }else{
            HPPossibleLikeModel * model = (HPPossibleLikeModel *)product;
            _product = [[HSProduct alloc] init];
            _product.productid = model.productid;
        }
        
    }
    
    return self;
}

-(instancetype)initWithSellerID:(NSString *)sellerID

{
    self = [super init];
    
    if (self) {
        
        _sellerID     = sellerID;
        
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
    
    [self setNavigationBarLeftButtonImage:@"NavBar_Back"];
    [self setNavigationBarRightButtonImage:@"NavBar_shopCart" WithTitle:@"购物车"];
    
    [self initData];
    
    [self getProductListData];
    
    [self getHotelDetailData];
    
    [self getCommentListData];
    
    [self createTopButtons];
    
    [self leftTableView];
    
    [self setUpHeaderView];
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)initData
{
    _roomListData = [NSMutableArray array];
    _dataSource   = [NSMutableArray array];
    _commentData  = [NSMutableArray array];
}


- (void)createTopButtons
{
    UIButton * collectionButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.customNavigationBar addSubview:collectionButton];
    [collectionButton makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.customNavBarRightBtn.centerY);
        make.right.mas_equalTo(self.customNavBarRightBtn.left).with.offset(GET_SCAlE_LENGTH(- NAVISPACE));
        make.size.mas_equalTo(CGSizeMake(36, 36));
    }];
    [collectionButton addTarget:self action:@selector(collectionHotel) forControlEvents:UIControlEventTouchUpInside];
    [collectionButton setImage:[UIImage imageNamed:@"RR_collection"] forState:UIControlStateNormal];
    [collectionButton setImage:[UIImage imageNamed:@"RR_collection"] forState:UIControlStateHighlighted];
    collectionButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 12, 0);
    
    UILabel * colletionLabel  = [UILabel new];
    [collectionButton addSubview:colletionLabel];
    [colletionLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(collectionButton.centerX).with.offset(0);
        make.bottom.mas_equalTo(collectionButton.bottom).with.offset(0);
    }];
    colletionLabel.textColor = UIColorFromRGB(WHITECOLOR);
    colletionLabel.font = [UIFont systemFontOfSize:9];
    colletionLabel.text = @"收藏";
    
    UIButton * phoneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.customNavigationBar addSubview:phoneButton];
    [phoneButton makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.customNavBarRightBtn.centerY);
        make.right.mas_equalTo(collectionButton.left).with.offset(GET_SCAlE_LENGTH(-NAVISPACE));
        make.size.mas_equalTo(CGSizeMake(36, 36));
    }];
    [phoneButton addTarget:self action:@selector(callPhone) forControlEvents:UIControlEventTouchUpInside];
    [phoneButton setImage:[UIImage imageNamed:@"RR_phone"] forState:UIControlStateNormal];
    [phoneButton setImage:[UIImage imageNamed:@"RR_phone"] forState:UIControlStateHighlighted];
    phoneButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 12, 0);
    
    UILabel * phoneLabel  = [UILabel new];
    [phoneButton addSubview:phoneLabel];
    [phoneLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(phoneButton.centerX).with.offset(0);
        make.bottom.mas_equalTo(phoneButton.bottom).with.offset(0);
    }];
    phoneLabel.textColor = UIColorFromRGB(WHITECOLOR);
    phoneLabel.font = [UIFont systemFontOfSize:9];
    phoneLabel.text = @"电话";
    
    UIButton * talkButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.customNavigationBar addSubview:talkButton];
    [talkButton makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.customNavBarRightBtn.centerY);
        make.right.mas_equalTo(phoneButton.left).with.offset(GET_SCAlE_LENGTH(-NAVISPACE));
        make.size.mas_equalTo(CGSizeMake(36, 36));
    }];
    [talkButton setImage:[UIImage imageNamed:@"RR_talk"] forState:UIControlStateNormal];
    [talkButton setImage:[UIImage imageNamed:@"RR_talk"] forState:UIControlStateHighlighted];
    talkButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 12, 0);
    [talkButton addTarget:self action:@selector(talkToService) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel * talkLabel  = [UILabel new];
    [talkButton addSubview:talkLabel];
    [talkLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(talkButton.centerX).with.offset(0);
        make.bottom.mas_equalTo(talkButton.bottom).with.offset(0);
    }];
    talkLabel.textColor = UIColorFromRGB(WHITECOLOR);
    talkLabel.font = [UIFont systemFontOfSize:9];
    talkLabel.text = @"客服";
    
}

- (void)toCommentViewController {
    
    ProductDetail * model = [[ProductDetail alloc] init];
    model.sellerid = _hotelDetail.sellerid;
    
    self.hidesBottomBarWhenPushed = YES;
    CommentViewController *comment = [[CommentViewController alloc]initWithProductDetail:model];
    [self.navigationController pushViewController:comment animated:YES];
    self.hidesBottomBarWhenPushed = NO;
    
}


#pragma mark - 自定义视图

/**
 *  懒加载 左侧表视图
 *
 *  @return 左侧表视图
 */
-(UITableView *)leftTableView
{
    if (_leftTableView == nil) {
        
        _leftTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:UITableViewStyleGrouped];
        [self.view addSubview:_leftTableView];
        
        _leftTableView.backgroundColor = UIColorFromRGB(GRAYBGCOLOR);
        _leftTableView.delegate        = self;
        _leftTableView.dataSource      = self;
        _leftTableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
        
        [_leftTableView registerClass:[CommentCell class] forCellReuseIdentifier:@"CommentCell"];
        [_leftTableView registerClass:[RoomReservationDetailCell class] forCellReuseIdentifier:@"RoomReservationDetailCell"];
        [_leftTableView registerClass:[HotelSuppliesProductCell class] forCellReuseIdentifier:@"HotelSuppliesProductCell"];
        [_leftTableView registerClass:[Top5Cell class] forCellReuseIdentifier:@"Top5Cell"];
        
    }
    
    return _leftTableView;
}

- (void)setUpProductTabbar
{
    
}

/**
 *  设置轮播图
 */
- (void)setUpHeaderView
{
    _ImageScrollHederView = [[ImageScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, GET_SCAlE_HEIGHT(140))];

    [self.leftTableView setTableHeaderView:_ImageScrollHederView];
    
}

#pragma mark - UITableViewDelegate

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 1 || section == 2) {
        cellDemonstrationView * view = [[cellDemonstrationView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,GET_SCAlE_HEIGHT(68/2))];
        _view = view;
        view.backgroundColor = UIColorFromRGB(WHITECOLOR);
        
        //画线
        UILabel * line = [UILabel new];
        [view addSubview:line];
        [line makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(view.mas_bottom);
            make.centerX.mas_equalTo(view.mas_centerX);
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 0.5));
        }];
        line.backgroundColor = UIColorFromRGB(LINECOLOR);
        
        if (section == 2) {
            
            NSString * score = [NSString stringWithFormat:@"%.1f",_hotelDetail.score.floatValue/10];
            
            [view setViewWithTitle:@"评分" SubTitle:score RightTitle:[NSString stringWithFormat:@"%ld人评论" ,_commentNum] SymbolImage:
             [UIImage imageNamed:@"arrow_right"]];
            UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(toCommentViewController)];
            [view addGestureRecognizer:tap];
            
        }
        else if (section == 1)
        {
            UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(chooseDateTap)];
            [view addGestureRecognizer:tap];
            
            [view setViewWithTitle:nil SubTitle:nil RightTitle:nil SymbolImage:[UIImage imageNamed:@"arrow_right"]];
            
            UIImageView * calender = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"callender"]];
            [view addSubview:calender];
            [calender makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(view.centerY);
                make.left.mas_equalTo(view.left).with.offset(GET_SCAlE_LENGTH(15));
                make.size.mas_equalTo(CGSizeMake(calender.image.size.width, calender.image.size.height));
            }];
            
            NSDate *date = [NSDate date];
            NSCalendar *calendar = [NSCalendar currentCalendar];
            NSDateComponents *components = [calendar components:NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitYear fromDate:date];
            NSInteger month = components.month;
            NSInteger day = components.day;
            NSInteger year = components.year;
            
            
            
            NSDate *date2 = [NSDate dateWithTimeInterval:24*60*60 sinceDate:date];
            NSDateComponents *components2 = [calendar components:NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitYear  fromDate:date2];
            NSInteger month2 = components2.month;
            NSInteger day2 = components2.day;
            NSInteger year2 = components2.year;
            
            _dayBeginLabel = [UILabel new];
            [view addSubview:_dayBeginLabel];
            [_dayBeginLabel makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(view.centerY);
                make.left.mas_equalTo(calender.right).with.offset(GET_SCAlE_LENGTH(5));
                //                make.size.mas_equalTo(<#CGSize#>);
            }];
            _dayBeginLabel.textColor = UIColorFromRGB(GRAYFONTCOLOR);
            _dayBeginLabel.font = [UIFont systemFontOfSize:NORMALFONTSIZE];
            NSString *monthStr = @(month).stringValue;
            NSString *dayStr = @(day).stringValue;
            
            if (month<10 && month >= 0) {
                monthStr = [@"0" stringByAppendingString:monthStr];
            }
            if (day<10 && day >= 0) {
                dayStr= [@"0" stringByAppendingString:dayStr];
            }
            
            
            
            _datEndLabel  = [UILabel new];
            [view addSubview:_datEndLabel];
            [_datEndLabel makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(view.centerY).with.offset(0);
                make.left.mas_equalTo(_dayBeginLabel.right).with.offset(GET_SCAlE_LENGTH(10));
            }];
            _datEndLabel.textColor = UIColorFromRGB(GRAYFONTCOLOR);
            _datEndLabel.font = [UIFont systemFontOfSize:NORMALFONTSIZE];
            _totalDaysLabel  = [UILabel new];
            [view addSubview:_totalDaysLabel];
            [_totalDaysLabel makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(view.centerY).with.offset(0);
                make.right.mas_equalTo(view.symBolImageView.left).with.offset(GET_SCAlE_LENGTH(-5));
            }];
            _totalDaysLabel.textColor = UIColorFromRGB(LIGHTBLUECOLOR);
            _totalDaysLabel.font = [UIFont systemFontOfSize:NORMALFONTSIZE];
            _totalDaysLabel.text = @"共1晚";
            
            NSString *monthStr2 = @(month2).stringValue;
            NSString *dayStr2 = @(day2).stringValue;
            
            if (month2<10 && month2 >= 0) {
                monthStr2 = [@"0" stringByAppendingString:monthStr2];
            }
            if (day2<10 && day2 >= 0) {
                dayStr2= [@"0" stringByAppendingString:dayStr2];
            }
            _dayBeginLabel.text = [NSString stringWithFormat:@"%ld-%@-%@入住",year,monthStr,dayStr];
            _datEndLabel.text =  [NSString stringWithFormat:@"%ld-%@-%@离店",year2,monthStr2,dayStr2];
            _monthDayArr = @[[_dayBeginLabel.text substringToIndex:_dayBeginLabel.text.length-2],[_datEndLabel.text substringToIndex:_datEndLabel.text.length-2]];
            
            UILabel * line = [UILabel new];
            [view addSubview:line];
            [line makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(view.centerY);
                make.left.mas_equalTo(_dayBeginLabel.right).with.offset(2);
                make.right.mas_equalTo(_datEndLabel.left).with.offset(-2);
                make.height.mas_equalTo(@2);
            }];
            line.backgroundColor = UIColorFromRGB(LINECOLOR);
            
        }
        
        return view;
    }
    else if(section == 3) {
        if (_segView) {
            return _segView;
        }
        SegmentTapView * segView = [[SegmentTapView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, GET_SCAlE_HEIGHT(25)) withDataArray:[NSArray arrayWithObjects:@"猜你喜欢",@"TOP5排行", nil] withFont:NORMALFONTSIZE];
        _segView = segView;
        [segView setTextColor:UIColorFromRGB(GRAYFONTCOLOR) SelectedColor:UIColorFromRGB(LIGHTBLUECOLOR) NoticeViewColor:UIColorFromRGB(LIGHTBLUECOLOR)];
        [segView callBackWithBlock:^(NSInteger index) {
            
            switch (index) {
                case 0:
                    [self getPossibleLikeDataAndTop5:NO];
                    break;
                    
                default:
                    [self getPossibleLikeDataAndTop5:YES];
                    break;
            }
            
        }];
        return segView;
    }
    else{
        
        UIView * headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.1)];
        headView.backgroundColor = UIColorFromRGB(REDFONTCOLOR);
        
        return headView;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 1 || section == 2) {
        return GET_SCAlE_HEIGHT(68/2);
    }
    else if (section == 3)
    {
        return GET_SCAlE_HEIGHT(25);
    }
    else
    {
        return 0.1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _leftTableView) {
        ProductIndexType type = indexPath.section;
        CGFloat height = 0;
        
        switch (type) {
            case kProductIndexTypeInfo: {
                height = GET_SCAlE_HEIGHT(34);
                break;
            }
            case kProductIndexTypeSelect: {
                height = GET_SCAlE_HEIGHT(95);
                break;
            }
            case kProductIndexTypeComment: {
                if (_commentData.count > 0) {
                    return [self countCommentCellHeightWithModel:_commentData.firstObject];
                }else{
                    return 0;
                }
                break;
            }
            case kProductIndexTypePossibleLike: {
                height = GET_SCAlE_HEIGHT(273/2.0);
                break;
            }
        }
        
        return height;
    }else{
        return 0;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 3) {
        //        if (!_top5) {
        return _dataSource.count;
        //        }
        //        return 5;
    }
    else if (section == 1)
    {
        //        NSArray * norms = _productDetail.norms;
        
        return _roomListData.count;
    }
    else if (section == 0)
    {
        return 2;
    }
    else
    {
//        NSArray * comments = _productDetail.comments;
//        
        return (_commentData.count > 0)?1:0;
    }
    
    //    if (tableView == _leftTableView) {
    //        return 1;
    //    }else{
    //        return 3;
    //    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    ProductIndexType type = indexPath.section;
    
    UIView * contentView = [UIView new];
    
    switch (type) {
        case kProductIndexTypeInfo: {
            //            [self createInfoViewWithContentView:contentView];
            
            //分开处理 第一行
            if (indexPath.row == 0) {
                
                if (!_view1) {
                    cellDemonstrationView * view = [[cellDemonstrationView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, GET_SCAlE_HEIGHT(34))];
                    _view1 = view;
                    [view setViewWithTitle:_hotelDetail.address SubTitle:nil RightTitle:nil SymbolImage:[UIImage imageNamed:@"arrow_right"]];
                    
                    UILabel * line = [UILabel new];
                    [view addSubview:line];
                    [line makeConstraints:^(MASConstraintMaker *make) {
                        make.bottom.mas_equalTo(view.mas_bottom);
                        make.centerX.mas_equalTo(view.mas_centerX);
                        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - GET_SCAlE_LENGTH(30), 0.5));
                    }];
                    line.backgroundColor = UIColorFromRGB(LINECOLOR);
                    [contentView addSubview:view];
                    
                }
                
                [_view1 setViewWithTitle:_hotelDetail.address SubTitle:nil RightTitle:nil SymbolImage:[UIImage imageNamed:@"arrow_right"]];
                
                
            }
            //第二行
            else
            {
                if (!([contentView viewWithTag:100] && [[contentView viewWithTag:100] isKindOfClass:[cellDemonstrationView class]])) {
                    cellDemonstrationView * view = [[cellDemonstrationView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, GET_SCAlE_HEIGHT(34))];
                    view.tag = 100;
                    [view setViewWithTitle:nil SubTitle:nil RightTitle:nil SymbolImage:[UIImage imageNamed:@"arrow_right"]];
                    
                    UIImageView * plane = [UIImageView new];
                    plane.image = [UIImage imageNamed:@"plane"];
                    [view addSubview:plane];
                    [plane makeConstraints:^(MASConstraintMaker *make) {
                        make.centerY.mas_equalTo(view.centerY);
                        make.left.mas_equalTo(view.left).with.offset(GET_SCAlE_LENGTH(15));
                        make.size.mas_equalTo(CGSizeMake(plane.image.size.width, plane.image.size.height));
                    }];
                    
                    UIImageView * package = [UIImageView new];
                    package.image = [UIImage imageNamed:@"package"];
                    [view addSubview:package];
                    [package makeConstraints:^(MASConstraintMaker *make) {
                        make.centerY.mas_equalTo(view.centerY);
                        make.left.mas_equalTo(plane.right).with.offset(GET_SCAlE_LENGTH(15));
                        make.size.mas_equalTo(CGSizeMake(package.image.size.width, package.image.size.height));
                    }];
                    
                    UIImageView * airCondition = [UIImageView new];
                    airCondition.image = [UIImage imageNamed:@"aircondition"];
                    [view addSubview:airCondition];
                    [airCondition makeConstraints:^(MASConstraintMaker *make) {
                        make.centerY.mas_equalTo(view.centerY);
                        make.left.mas_equalTo(package.right).with.offset(GET_SCAlE_LENGTH(15));
                        make.size.mas_equalTo(CGSizeMake(airCondition.image.size.width, airCondition.image.size.height));
                    }];
                    
                    UIImageView * wifi = [UIImageView new];
                    wifi.image = [UIImage imageNamed:@"wifi"];
                    [view addSubview:wifi];
                    [wifi makeConstraints:^(MASConstraintMaker *make) {
                        make.centerY.mas_equalTo(view.centerY);
                        make.left.mas_equalTo(airCondition.right).with.offset(GET_SCAlE_LENGTH(15));
                        make.size.mas_equalTo(CGSizeMake(wifi.image.size.width, wifi.image.size.height));
                    }];
                    [contentView addSubview:view];
                    
                }
                
            }
            
            break;
        }
        case kProductIndexTypeSelect: {
            //            [self createSelectedViewWithContentView:contentView];
            RoomReservationDetailCell * cell = [tableView dequeueReusableCellWithIdentifier:@"RoomReservationDetailCell"];
            
            if (_roomListData.count > 0) {
                
                id room = _roomListData[indexPath.row];
                if ([room isKindOfClass:[HSProduct class]]) {
                    [cell cellForRowWithModel:room];
                }
            }
            
            
            HSProduct * model = [_roomListData objectAtIndex:indexPath.row];
//            [cell.customHeadImageView sd_setImageWithURL:[NSURL URLWithString:model.logo]];
            [cell cellForRowWithModel:model];
            
            [cell callBackWithBlock:^{
                NSLog(@"index = %ld",indexPath.row);
                self.hidesBottomBarWhenPushed = YES;
                ConfirmRoomOrderViewController * VC = [[ConfirmRoomOrderViewController alloc] init];
                VC.productid = model.productid;
                VC.productDetail = _productDetail;
                VC.MonthDayArr = _monthDayArr;
                VC.longIntro = _productDetail.longintro;
                
                [self.navigationController pushViewController:VC animated:YES];
            }];
            return cell;
            
            break;
        }
        case kProductIndexTypeComment: {
            CommentCell * cell = [tableView dequeueReusableCellWithIdentifier:@"CommentCell"];
            Comments *comment = [_commentData firstObject];
            [cell setCellWithModel:comment];
            return cell;
            break;
        }
        case kProductIndexTypePossibleLike: {
            if (_top5) {
                Top5Cell * cell = [tableView dequeueReusableCellWithIdentifier:@"Top5Cell"];
                if (_dataSource.count > 0) {
                    [cell cellForRowWithModel:_dataSource[indexPath.row]];
                    cell.topLabel.text = @(indexPath.row+1).stringValue;
                    cell.topImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"RR_top%ld",(long)indexPath.row+1]];
                    
                    Hotels * model = [_dataSource objectAtIndex:indexPath.row];
                    
                    NSDictionary * locationInfo = [[AppInformationSingleton shareAppInfomationSingleton] getLocationInfo];
                    NSString * longitude = locationInfo[@"LONGITUDE"];
                    NSString * latitude = locationInfo[@"LATITUDE"];
                    
                    NSString * distance = [self LantitudeLongitudeDist:[model.coordinatex doubleValue] other_Lat:[model.coordinatey doubleValue] self_Lon:[longitude doubleValue] self_Lat:[latitude doubleValue]];
                    cell.customDistanceLabel.text = [NSString stringWithFormat:@"距离：%.2fkm",[distance doubleValue]/1000];
                }
                return cell;
            }
            else {
                HotelSuppliesProductCell * cell = [tableView dequeueReusableCellWithIdentifier:@"HotelSuppliesProductCell"];
                if (_dataSource.count > 0) {
                    [cell cellForHoelSuppListVC:YES];
                    [cell cellForRowWithPossibleLike:_dataSource[indexPath.row]];
                    
                    Hotels * model = [_dataSource objectAtIndex:indexPath.row];
                    
                    NSDictionary * locationInfo = [[AppInformationSingleton shareAppInfomationSingleton] getLocationInfo];
                    NSString * longitude = locationInfo[@"LONGITUDE"];
                    NSString * latitude = locationInfo[@"LATITUDE"];
                    
                    NSString * distance = [self LantitudeLongitudeDist:[model.coordinatex doubleValue] other_Lat:[model.coordinatey doubleValue] self_Lon:[longitude doubleValue] self_Lat:[latitude doubleValue]];
                    cell.customDistanceLabel.text = [NSString stringWithFormat:@"距离：%.2fkm",[distance doubleValue]/1000];
                }
                return cell;
            }
            break;
        }
    }
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        for (UIView * view in cell.contentView.subviews) {
            [view removeFromSuperview];
        }
        [cell.contentView addSubview:contentView];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    if (indexPath.section == 2) {
    //
    //        [self toCommentViewController];
    //    }
    //    else if (indexPath.section == 1){
    //
    //        [self selectedTaped];
    //    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0 ) {
        if (indexPath.row == 1) {
            self.hidesBottomBarWhenPushed = YES;
            HotelDetaiViewController *detailVc = [[HotelDetaiViewController alloc]initWithProduct:_hotelDetail];
            [self.navigationController pushViewController:detailVc animated:YES];
            detailVc.intro = _hotelDetail.sellerintro;
            detailVc.logo = _hotelDetail.sellerlogo;
            detailVc.rateScore = _hotelDetail.sellerscore;
            detailVc.shopName = _hotelDetail.sellername;
            detailVc.monthDayArr = _monthDayArr;
            detailVc.sellerid = _hotelDetail.sellerid;
        }
        else {
            self.hidesBottomBarWhenPushed = YES;
            MapViewController *map = [[MapViewController alloc]initWithLatitude:_hotelDetail.coordinatey longitude:_hotelDetail.coordinatex];
            [self.navigationController pushViewController:map animated:YES];
        }
    }
    
    else if (indexPath.section == 3) {
        
        if (_dataSource.count > 0) {
            Hotels * model = _dataSource[indexPath.row];
            self.hidesBottomBarWhenPushed = YES;
            RoomReserVationDetailViewController * VC = [[RoomReserVationDetailViewController alloc] initWithHotelModel:model];
            [self.navigationController pushViewController:VC animated:YES];
        }
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 15)];
    view.backgroundColor = UIColorFromRGB(GRAYBGCOLOR);
    
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 15;
}

#pragma mark - 代理方法
/**
 *  点击时触发
 *
 *  @param index 识别用下标
 */
-(void)selectedIndex:(NSInteger)index
{
    NSLog(@"%ld",index);
    //    [self.flipView selectIndex:index];
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
        
        alert.tag = 100;
        [alert show];
        
    }else{
        
        self.hidesBottomBarWhenPushed = YES;
        ShoppingCartViewController * VC = [[ShoppingCartViewController alloc] initWithProductType:kProductTypeVirtual];
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

- (void)chooseDateTap
{
    
    CalendarHomeViewController * chvc = [[CalendarHomeViewController alloc]init];
    
    [chvc setHotelToDay:60 ToDateforString:nil];
    
    chvc.calendarblock = ^(CalendarDayModel *beginDay ,CalendarDayModel * endDay){
        
        NSLog(@"\n---------------------------");
        NSLog(@"1星期 %@",[beginDay getWeek]);
        NSLog(@"2字符串 %@",[beginDay toString]);
        NSLog(@"3节日  %@",beginDay.holiday);
        
        NSLog(@"\n---------------------------");
        NSLog(@"1星期 %@",[endDay getWeek]);
        NSLog(@"2字符串 %@",[endDay toString]);
        NSLog(@"3节日  %@",endDay.holiday);
        
        _dayBeginLabel.text = [beginDay.toString stringByAppendingString:@"入住"];
        _datEndLabel.text = [endDay.toString stringByAppendingString:@"离店"];
        
        
        _monthDayArr = @[beginDay.toString, endDay.toString];
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        formatter.dateFormat = @"yyyy-MM-dd";
        NSDate *beginDate = [formatter dateFromString:beginDay.toString];
        NSDate *endDate = [formatter dateFromString:endDay.toString];
        BOOL is  = [beginDate timeIntervalSinceDate:endDate]>0 ? NO:YES;
        
        NSTimeInterval interval = [endDate timeIntervalSinceDate:beginDate];
        
        if (!is) {
            _dayBeginLabel.text = [endDay.toString stringByAppendingString:@"入住"];
            _datEndLabel.text = [beginDay.toString stringByAppendingString:@"离店"];
            _monthDayArr = @[endDay.toString, beginDay.toString];
            interval = [beginDate timeIntervalSinceDate:endDate];
        }
        
        NSInteger days = interval / (24 * 3600);
        (days < 0)?(days = 1):(days = days);
        
        if ([endDay.toString isEqualToString:beginDay.toString]) {
            _totalDaysLabel.text = [NSString stringWithFormat:@"共%ld晚",days];
        }
        else {
            _totalDaysLabel.text = [NSString stringWithFormat:@"共%ld晚",days];
        }
        
    };
    
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:chvc animated:YES];
    
    
}

/**
 *  联系客服
 */
- (void)talkToService
{
    NSString *showMsg = @"敬请期待";
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"提示"
                                                    message: showMsg
                                                   delegate: self
                                          cancelButtonTitle:@"确定"
                                          otherButtonTitles: nil, nil];
    
    [alert show];
    
}

-(void)collectionHotel
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
    [bodyDic setObject:@"addtocar" forKey:@"functionid"];
    
    if ([[AppInformationSingleton shareAppInfomationSingleton] getLoginCode]) {
        [headDic setObject:[[AppInformationSingleton shareAppInfomationSingleton] getLoginCode] forKey:@"ut"];
        [headDic setObject:[[AppInformationSingleton shareAppInfomationSingleton] getUserID] forKey:@"userid"];
    }
    
    //    NSArray * arrM = [NSArray arrayWithObjects:_postNormDic, nil];
    
    //    [bodyDic setObject:arrM forKey:@"products"];
    
    //    [bodyDic setObject:_productID forKey:@"scproductid"];
    [bodyDic setObject:_hotelDetail.sellerid forKey:@"sellerid"];
    
    
    [[NetWorkSingleton sharedManager] postWithHeadParameter:headDic bodyParameter:bodyDic SuccessBlock:^(id responseBody) {
        
        if ([responseBody[@"head"][@"resultcode"] isEqualToString:@"0000"]) {
            [SVProgressHUD dismissWithSuccess:@"收藏成功" afterDelay:1];
        }else{
            [SVProgressHUD dismissWithSuccess:nil afterDelay:0.3];
        }
    } FailureBlock:^(NSString *error) {
        [SVProgressHUD dismissWithError:nil afterDelay:0.3];
    }];
}

- (void)callPhone {
    UIWebView *web = [[UIWebView alloc]initWithFrame:CGRectZero];
    [web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",_hotelDetail.servicephone]]]];
    [self.view addSubview:web];
}

#pragma mark - 网络

- (void)getProductListData
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
    
    NSString * sellerid = _sellerID;
    
    if (sellerid) {
        [bodyDic setObject:sellerid forKey:@"sellerid"];
    }else{
        [bodyDic setObject:_hotel.sellerid forKey:@"sellerid"];
    }
    [bodyDic setObject:@"2" forKey:@"producttype"];
    [bodyDic setObject:@"productlist" forKey:@"functionid"];
    
    [[NetWorkSingleton sharedManager] postWithHeadParameter:headDic bodyParameter:bodyDic SuccessBlock:^(id responseBody) {
        
        id roomlist = responseBody[@"body"][@"products"];
        
        HSproductListModelParser * parser = [[HSproductListModelParser alloc] initWithDictionary:responseBody];
        _adsData = parser.productListModel.topadvs;
        
        if ([roomlist isKindOfClass:[NSDictionary class]]) {
            HSProduct * model = [HSProduct modelObjectWithDictionary:roomlist[@"product"]];
            [_roomListData addObject:model];
        }else{
            
            [parser.productListModel.product enumerateObjectsUsingBlock:^(Product * _Nonnull room, NSUInteger idx, BOOL * _Nonnull stop) {
                if ([room isKindOfClass:[HSProduct class]]) {
                    
                    HSProduct * model  = (HSProduct *)room;
                    if ([model.productid integerValue] != 0) {
                        [_roomListData addObject:room];
                    }
                }
            }];
        }
        
        
        [self getPossibleLikeDataAndTop5:NO];
        
        [SVProgressHUD dismissWithSuccess:@"加载成功" afterDelay:1];
        
    } FailureBlock:^(NSString *error) {
        
        [SVProgressHUD dismiss];
        
    }];
}

- (void)getPossibleLikeDataAndTop5:(BOOL)top5
{
    _top5 = top5;
    if(![[Reachability reachabilityForInternetConnection]isReachable])
    {
        return;
    }
    
    NSMutableDictionary * headDic = [[NSMutableDictionary alloc] initWithCapacity:1];
    
    NSMutableDictionary * bodyDic = [[NSMutableDictionary alloc] initWithCapacity:1];
    if (top5) {
        [bodyDic setObject:@"hotellist" forKey:@"functionid"];
        [bodyDic setObject:@"5" forKey:@"pagesize"];
        [bodyDic setObject:@"2" forKey:@"producttype"];
        
    }
    else {
        [bodyDic setObject:@"sj_like" forKey:@"functionid"];
        [bodyDic setObject:@"2" forKey:@"producttype"];
        [bodyDic setObject:@"5" forKey:@"pagesize"];
    }
    
    
    [[NetWorkSingleton sharedManager] postWithHeadParameter:headDic bodyParameter:bodyDic SuccessBlock:^(id responseBody) {
        
        if (!top5) {
            PossibleLikeModelParser * parser = [[PossibleLikeModelParser alloc] initWithDictionary:responseBody];
            
            //            id arrM = responseBody[@"body"][@"hotelliks"];
            //
            //            if ([arrM isKindOfClass:[NSArray class]]) {
            //                NSArray * hotels = (NSArray *)arrM;
            //                [hotels enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            //                    if ([obj isKindOfClass:[NSDictionary class]]) {
            //                        Hotels * model = [Hotels modelObjectWithDictionary:obj];
            //                        [_dataSource addObject:model];
            //                    }
            //                }];
            //            }
            
            [_dataSource removeAllObjects];
            [_dataSource addObjectsFromArray:[[parser possibleLikeModel]hotellikes]];
        }
        else {
            HotelModelParser * parser = [[HotelModelParser alloc] initWithDictionary:responseBody];
            [_dataSource removeAllObjects];
            [_dataSource addObjectsFromArray:parser.hotelModel.hotels];
            
        }
        [self.leftTableView reloadData];
        
    } FailureBlock:^(NSString *error) {
        
    }];
}

/**
 *  获取酒店商家详情数据
 */
- (void)getHotelDetailData
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
    [bodyDic setObject:@"sellerdetail" forKey:@"functionid"];
    if (_sellerID) {
        [bodyDic setObject:_sellerID forKey:@"sellerid"];
    }else{
        [bodyDic setObject:_hotel.sellerid forKey:@"sellerid"];
    }
    [SVProgressHUD show];
    
    [[NetWorkSingleton sharedManager] postWithHeadParameter:headDic bodyParameter:bodyDic SuccessBlock:^(id responseBody) {
        
        HotelDetailModelParser * parser = [[HotelDetailModelParser alloc] initWithDictionary:responseBody];
        _hotelDetail = parser.hotelDetailModel;
        
        id bodyDic = responseBody[@"body"];
        
        if ([bodyDic isKindOfClass:[NSDictionary class]]) {
        
        if (responseBody[@"body"][@"imagelist"]) {
            [_ImageScrollHederView setImageArray:responseBody[@"body"][@"imagelist"]];
            [_ImageScrollHederView callBackWithBlock:^(NSInteger index) {
                PreviewController * VC = [[PreviewController alloc] initWithParentViewController:self];
                VC.imageArr = responseBody[@"body"][@"imagelist"];
                [VC didMoveToParentViewController];
            }];
            
            UILabel * line = [UILabel new];
            [_ImageScrollHederView addSubview:line];
            [line makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.mas_equalTo(_ImageScrollHederView.mas_bottom);
                make.centerX.mas_equalTo(_ImageScrollHederView.mas_centerX);
                make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, GET_SCAlE_HEIGHT(25)));
            }];
            line.backgroundColor = UIColorFromRGB(BLACKCOLOR);
            line.alpha = 0.2;
            [_ImageScrollHederView insertSubview:line aboveSubview:_ImageScrollHederView.pageControl];
            
            UILabel * HotelName  = [UILabel new];
            [_ImageScrollHederView addSubview:HotelName];
            [HotelName makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.mas_equalTo(_ImageScrollHederView.bottom).with.offset(-5);
                make.left.mas_equalTo(_ImageScrollHederView.left).with.offset(GET_SCAlE_LENGTH(10));
            }];
            HotelName.text = parser.hotelDetailModel.sellername;
            HotelName.font = [UIFont systemFontOfSize:TITLENAMEFONTSIZE];
            HotelName.textColor = UIColorFromRGB(WHITECOLOR);
        }
        }

        [[AppInformationSingleton shareAppInfomationSingleton] setBrowseHistory:_hotelDetail];
        
        [SVProgressHUD dismiss];
        
    } FailureBlock:^(NSString *error) {
        
        [SVProgressHUD dismiss];
    }];
}

- (void)getCommentListData
{
    if(![[Reachability reachabilityForInternetConnection]isReachable])
    {
        return;
    }
    
    NSMutableDictionary * headDic = [[NSMutableDictionary alloc] initWithCapacity:1];
    NSMutableDictionary * bodyDic = [[NSMutableDictionary alloc] initWithCapacity:1];
    [bodyDic setObject:@"spcommentlist" forKey:@"functionid"];
    if (_sellerID) {
        [bodyDic setObject:_sellerID forKey:@"sellerid"];
    }else{
        [bodyDic setObject:_hotel.sellerid forKey:@"sellerid"];
    }
    [SVProgressHUD show];
    
    [[NetWorkSingleton sharedManager] postWithHeadParameter:headDic bodyParameter:bodyDic SuccessBlock:^(id responseBody) {
        
        CommentsModelParser * parser = [[CommentsModelParser alloc] initWithDictionary:responseBody];
        _commentNum = [parser.commentsModel.totalcount0 integerValue];
        [_commentData addObjectsFromArray:parser.commentsModel.comments];
        
        [SVProgressHUD dismiss];
        
    } FailureBlock:^(NSString *error) {
        
        [SVProgressHUD dismiss];
    }];
}

- (void)configureViewWithData
{
    [_view setViewWithTitle:@"评分" SubTitle:_hotelDetail.score RightTitle:[NSString stringWithFormat:@"%d人评论" ,_productDetail.commentcount.intValue] SymbolImage:
     [UIImage imageNamed:@"arrow_right"]];
    [_view1 setViewWithTitle:_productDetail.address SubTitle:nil RightTitle:nil SymbolImage:[UIImage imageNamed:@"arrow_right"]];
    
    
}



@end
