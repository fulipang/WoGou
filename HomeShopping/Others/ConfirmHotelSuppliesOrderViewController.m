//
//  ConfirmHotelSuppliesOrderViewController.m
//  HomeShopping
//
//  Created by sooncong on 16/1/12.
//  Copyright © 2016年 Administrator. All rights reserved.
//

#import "ConfirmHotelSuppliesOrderViewController.h"
#import "HotelSuppliesProductCell.h"
#import "HSProduct.h"
#import "cellDemonstrationView.h"
#import "DayToDayTableViewCell.h"
#import "OrderModel.h"
#import "ProductDetailModelParser.h"


#define SPACE_X GET_SCAlE_LENGTH(15)
#define SPACE GET_SCAlE_HEIGHT(10)

@interface ConfirmHotelSuppliesOrderViewController ()
/**
 *  入住日期标签
 */
@property (nonatomic, strong) UILabel * dayBeginLabel;


/**
 *  离店日期标签
 */
@property (nonatomic, strong) UILabel * datEndLabel;

/**
 *  显示一共住几日标签
 */
@property (nonatomic, strong) UILabel * totalDaysLabel;

@end

@implementation ConfirmHotelSuppliesOrderViewController
{
    OrderOperationType _currentStatusType;
    
    //中部视图 用于显示收货地址/验证码
    UIView * _middleView;
    
    //是否显示中部视图
    BOOL _isSetAddr;
    
    UILabel * _middleLine;
    
    UIButton * _weiChatSelection;
    UIButton * _aliPaySelection;
    UIButton * _coinSelection;
    
    //总付款金额
    UILabel * _totalMoneyLabel;
    UILabel * _totalCoinLabel;
    PayType _payType;
    
    ProductDetail * _productDetail;
    
    NSMutableDictionary * _norm;
    
    BOOL _isHotel;

}

#pragma mark - 生命周期

-(instancetype)initWithProductDetailFromHSView:(ProductDetail *)productDetail NormData:(NSDictionary *)norm
{
    if (self = [super init])
    {
        _productDetail = productDetail;
        _norm = norm;
        
    }
    return self;
}

- (instancetype)initWithProductDetail:(ProductDetail *)productDetail {
    
    if (self = [super init])
    {
        _productDetail = productDetail;
        _isHotel = YES;
        
    }
    return self;
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    [self loadCostomViw];
    _payType = kWeixinPayType;
    
//    [self getProductDetailData];
}



#pragma mark - 网络

- (void)getProductDetailData
{
    NSMutableDictionary * headDic = [[NSMutableDictionary alloc] initWithCapacity:1];
    NSMutableDictionary * bodyDic = [[NSMutableDictionary alloc] initWithCapacity:1];
    
    [bodyDic setObject:self.productID forKey:@"productid"];
    [bodyDic setObject:@"productdetail" forKey:@"functionid"];
    
    [[NetWorkSingleton sharedManager] postWithHeadParameter:headDic bodyParameter:bodyDic SuccessBlock:^(id responseBody) {
        
        NSLog(@"responseBody:%@",responseBody);
        ProductDetailModelParser * parser = [[ProductDetailModelParser alloc] initWithDictionary:responseBody];
        _productDetail = parser.productDetailModel.productDetail;
        
    } FailureBlock:^(NSString *error) {
        
    }];
}


#pragma mark - 自定义视图

/**
 *  装载自定义视图 总览
 */
- (void)loadCostomViw
{
    [self setNavigationBarLeftButtonImage:@"NavBar_Back"];
    
    [self setNavigationBarTitle:@"确认订单"];
    
    [self loadMainTableView];
    
    [self createBottomView];
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

    [self.mainTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell1"];
    [self.mainTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell2"];
    [self.mainTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell3"];
    [self.mainTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell4"];

    
    [self.mainTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.mainTableView registerClass:[HotelSuppliesProductCell class] forCellReuseIdentifier:@"HotelSuppliesProductCell"];
    [self.mainTableView registerClass:[DayToDayTableViewCell class] forCellReuseIdentifier:@"HotelDayToDayCell"];
    [self.mainTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"HotelNumberCell"];


    
}

#pragma mark - UITableviewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (_isHotel) {
        return 5;
    }
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (_isHotel) {
        
        
        switch (indexPath.section) {
            case 3:
                return GET_SCAlE_HEIGHT(50);
                break;
            case 1:
                return GET_SCAlE_HEIGHT(30);
                break;
                
            case 0:
                return 0;
                break;
                
            case 2:
                return GET_SCAlE_HEIGHT(101);
                break;
                
            case 4:
                return GET_SCAlE_HEIGHT(270);
                break;
                
            default:
                return 0;
                break;
        }

        
        
        return 0;
    }
    switch (indexPath.section) {
        case 1:

        case 3:
            return GET_SCAlE_HEIGHT(30);
            break;
            
        case 0:
            return (_isSetAddr)?GET_SCAlE_HEIGHT(80):GET_SCAlE_HEIGHT(45);
            break;
            
        case 2:
            return GET_SCAlE_HEIGHT(115);
            break;
            
        case 4:
            return GET_SCAlE_HEIGHT(270);
            break;
            
        default:
            return 0;
            break;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
        case 1:
        case 3:
        case 4:
            return 1;
            break;
            
        case 2:
            return 1;
            break;
            
        default:
            return 1;
            break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 2) {
        HotelSuppliesProductCell * cell = [tableView dequeueReusableCellWithIdentifier:@"HotelSuppliesProductCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.customScoreLabel.hidden = YES;
        cell.turnOverLabel.hidden = YES;
        cell.customDistanceLabel.hidden = YES;
        HSProduct *model = [HSProduct new];
        model.price = _productDetail.price;
        model.coinprice = _productDetail.coinprice;
        model.coinreturn = _productDetail.coinreturn;
        model.logo = _productDetail.logo;
        model.title = _productDetail.title;
        
        [cell.customHeadImageView sd_setImageWithURL:[NSURL URLWithString:model.logo]];
        [cell cellForRowWithModel:model];
        [cell cellShowSpecialSymbol:NO];
        return cell;
    }
    
    if (_isHotel) {
        if (indexPath.section == 3) {
            DayToDayTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"HotelDayToDayCell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.MonthDayArr = self.MonthDayArr;
            cell.orderNumber = self.orderNumber;
            
            return cell;
        }
 
    }
    

    
    
    
    if (indexPath.section == 0) {
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell1"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.contentView addSubview:[self createCustomCellWithIndexPath:indexPath]];

        return cell;
    }
    
    if (indexPath.section == 1) {
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell2"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.contentView addSubview:[self createCustomCellWithIndexPath:indexPath]];

        return cell;
    }

    if (indexPath.section == 3 && !_isHotel) {
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell3"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.contentView addSubview:[self createCustomCellWithIndexPath:indexPath]];

        return cell;
    }

    if (indexPath.section == 4) {
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell4"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.contentView addSubview:[self createCustomCellWithIndexPath:indexPath]];

        return cell;
    }

    
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    for (id subView in cell.contentView.subviews) {
        
        if ([subView isKindOfClass:[UIView class]]) {
            
            UIView *vie = (UIView *)subView;
            [vie removeFromSuperview];
        }
    }

    
    return cell;
}

#pragma mark UITableViewDelegate 

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


#pragma mark 自定义控件



- (UIView * )createCustomCellWithIndexPath:(NSIndexPath *)indexPath
{
    
    switch (indexPath.section) {
        case 0:
        {
            UIView * contentView = [[UIView alloc] init];

            if (_isHotel) {
                
                return nil;
                break;
            }
            else {
                contentView.frame = CGRectMake(0, 0, SCREEN_WIDTH, (_isSetAddr)?GET_SCAlE_HEIGHT(80):GET_SCAlE_HEIGHT(45));
            }

            
            if (_isSetAddr) {
                
            }else{
                
                UILabel * titleLable  = [UILabel new];
                [contentView addSubview:titleLable];
                [titleLable makeConstraints:^(MASConstraintMaker *make) {
                    make.centerY.mas_equalTo(contentView.centerY).with.offset(0);
                    make.left.mas_equalTo(contentView.left).with.offset(GET_SCAlE_LENGTH(15));
                }];
                titleLable.textColor = UIColorFromRGB(LIGHTBLUECOLOR);
                titleLable.font = [UIFont systemFontOfSize:LARGEFONTSIZE];
                titleLable.text = @"填写收货地址";
                
                UIImageView * arrow = [UIImageView new];
                arrow.image = [UIImage imageNamed:@"arrow_right"];
                [contentView addSubview:arrow];
                [arrow makeConstraints:^(MASConstraintMaker *make) {
                    make.centerY.mas_equalTo(contentView.centerY);
                    make.right.mas_equalTo(contentView.right).with.offset(GET_SCAlE_LENGTH(-15));
                    make.size.mas_equalTo(CGSizeMake(arrow.image.size.width, arrow.image.size.height));
                }];
                
                UILabel * line = [UILabel new];
                [contentView addSubview:line];
                [line makeConstraints:^(MASConstraintMaker *make) {
                    make.bottom.mas_equalTo(contentView.mas_bottom);
                    make.centerX.mas_equalTo(contentView.mas_centerX);
                    make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 0.5));
                }];
                line.backgroundColor = UIColorFromRGB(LINECOLOR);
            }
            return contentView;
        }
            break;
            
        case 1:{
            UIView * contentView = [[UIView alloc] init];

            contentView.frame = CGRectMake(0, 0, SCREEN_WIDTH, GET_SCAlE_HEIGHT(30));
            contentView.hidden = NO;
            UILabel * titleLable  = [UILabel new];
            [contentView addSubview:titleLable];
            [titleLable makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(contentView.centerY).with.offset(0);
                make.left.mas_equalTo(contentView.left).with.offset(GET_SCAlE_LENGTH(15));
            }];
            titleLable.textColor = UIColorFromRGB(BLACKFONTCOLOR);
            titleLable.font = [UIFont systemFontOfSize:TITLENAMEFONTSIZE];
            titleLable.text = @"广州某公司";
            
            UIImageView * arrow = [UIImageView new];
            arrow.image = [UIImage imageNamed:@"arrow_right"];
            [contentView addSubview:arrow];
            [arrow makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(contentView.centerY);
                make.right.mas_equalTo(contentView.right).with.offset(GET_SCAlE_LENGTH(-15));
                make.size.mas_equalTo(CGSizeMake(arrow.image.size.width, arrow.image.size.height));
            }];
            
            UILabel * line = [UILabel new];
            [contentView addSubview:line];
            [line makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.mas_equalTo(contentView.mas_bottom);
                make.right.mas_equalTo(contentView.right);
                make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - GET_SCAlE_LENGTH(15), 0.5));
            }];
            line.backgroundColor = UIColorFromRGB(LINECOLOR);
            return contentView;
            break;
        }
            
        case 2:

            break;
            
        case 3:{
            UIView * contentView = [[UIView alloc] init];

            contentView.frame = CGRectMake(0, 0, SCREEN_WIDTH, GET_SCAlE_HEIGHT(30));
            contentView.hidden = NO;
            UILabel * titleLable  = [UILabel new];
            [contentView addSubview:titleLable];
            [titleLable makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(contentView.centerY).with.offset(0);
                make.left.mas_equalTo(contentView.left).with.offset(GET_SCAlE_LENGTH(15));
            }];
            titleLable.textColor = UIColorFromRGB(GRAYFONTCOLOR);
            titleLable.font = [UIFont systemFontOfSize:NORMALFONTSIZE];
            titleLable.text = @"订单留言";
            
            UILabel * line = [UILabel new];
            [contentView addSubview:line];
            [line makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.mas_equalTo(contentView.mas_bottom);
                make.centerX.mas_equalTo(contentView.mas_centerX);
                make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 0.5));
            }];
            line.backgroundColor = UIColorFromRGB(LINECOLOR);
            return contentView;
            break;
        }
            
        //付款选择部分
        case 4:{
            UIView * contentView = [[UIView alloc] init];

            contentView.frame = CGRectMake(0, 0, SCREEN_WIDTH, GET_SCAlE_HEIGHT(270));
            contentView.hidden = NO;
            UILabel * titleLable  = [UILabel new];
            [contentView addSubview:titleLable];
            [titleLable makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(contentView.top).with.offset(GET_SCAlE_HEIGHT(10));
                make.left.mas_equalTo(contentView.left).with.offset(GET_SCAlE_LENGTH(15));
                make.left.mas_equalTo(contentView.left).with.offset(GET_SCAlE_LENGTH(15));
            }];
            titleLable.textColor = UIColorFromRGB(BLACKFONTCOLOR);
            titleLable.font = [UIFont systemFontOfSize:NORMALFONTSIZE];
            titleLable.text = @"支付方式:";
            
            //画线
            UILabel * line_1 = [UILabel new];
            [contentView addSubview:line_1];
            [line_1 makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(contentView.top).with.offset(GET_SCAlE_HEIGHT(90));
                make.centerX.mas_equalTo(contentView.mas_centerX);
                make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 0.5));
            }];
            line_1.backgroundColor = UIColorFromRGB(LINECOLOR);
            
            UILabel * line_2 = [UILabel new];
            [contentView addSubview:line_2];
            [line_2 makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(contentView.top).with.offset(GET_SCAlE_HEIGHT(220));
                make.centerX.mas_equalTo(contentView.mas_centerX);
                make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 0.5));
            }];
            line_2.backgroundColor = UIColorFromRGB(LINECOLOR);
            
            //配置内容
            [self createPayViewWithBaseLine:line_1 ContentView:contentView];
            [self createBottomViewWithBaseLine:line_2 ContentView:contentView];
            return contentView;
            break;
        }
            
        default:{
            UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.1)];
            return view;
            break;
        }
    }
    
    return nil;
}

/**
 *  创建底部剩余控件
 *
 *  @param line        基准线
 *  @param contentView 父视图
 */
- (void)createBottomViewWithBaseLine:(UILabel *)line ContentView:(UIView *)contentView
{
    _coinSelection = [UIButton buttonWithType:UIButtonTypeCustom];
    [contentView addSubview:_coinSelection];
    [_coinSelection makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(contentView.left).with.offset(GET_SCAlE_LENGTH(15));
        make.bottom.mas_equalTo(line.top).with.offset(GET_SCAlE_HEIGHT(GET_SCAlE_HEIGHT(-15)));
        make.size.mas_equalTo(CGSizeMake(GET_SCAlE_LENGTH(15), GET_SCAlE_LENGTH(15)));
    }];
    [_coinSelection setImage:[UIImage imageNamed:@"selected_r"] forState:UIControlStateNormal];
    [_coinSelection setImage:[UIImage imageNamed:@"selected_rd"] forState:UIControlStateSelected];
    [_coinSelection addTarget:self action:@selector(selectionButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel * coinLabel  = [UILabel new];
    [contentView addSubview:coinLabel];
    [coinLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_coinSelection).with.offset(0);
        make.left.mas_equalTo(_coinSelection.right).with.offset(GET_SCAlE_LENGTH(10));
    }];
    coinLabel.textColor = UIColorFromRGB(BLACKFONTCOLOR);
    coinLabel.font = [UIFont systemFontOfSize:NORMALFONTSIZE];
    coinLabel.text = [@"狗币金额:" stringByAppendingString:_productDetail.coinprice?:@"0.0"];
    
    UILabel * coinTitleLabel  = [UILabel new];
    [contentView addSubview:coinTitleLabel];
    [coinTitleLabel makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(_coinSelection.top).with.offset(GET_SCAlE_HEIGHT(-20));
        make.left.mas_equalTo(contentView.left).with.offset(GET_SCAlE_LENGTH(15));
    }];
    coinTitleLabel.textColor = UIColorFromRGB(BLACKFONTCOLOR);
    coinTitleLabel.font = [UIFont systemFontOfSize:NORMALFONTSIZE];
    coinTitleLabel.text = @"使用狗币换购:";
    
    UILabel * mailType  = [UILabel new];
    [contentView addSubview:mailType];
    [mailType makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(line.bottom).with.offset(GET_SCAlE_HEIGHT(10));
        make.left.mas_equalTo(contentView.left).with.offset(GET_SCAlE_LENGTH(15));
    }];
    mailType.textColor = UIColorFromRGB(BLACKFONTCOLOR);
    mailType.font = [UIFont systemFontOfSize:NORMALFONTSIZE];
    mailType.text = @"配送方式：全场包邮";
    
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
    [orderButton setTitle:@"结算" forState:UIControlStateNormal];
    [orderButton.titleLabel setFont:[UIFont systemFontOfSize:TITLENAMEFONTSIZE]];
    [orderButton setTitleColor:UIColorFromRGB(WHITECOLOR) forState:UIControlStateNormal];
    orderButton.backgroundColor = UIColorFromRGB(REDORDERCOLOR);
    
    UILabel * moneyLabel  = [UILabel new];
    [bottomView addSubview:moneyLabel];
    [moneyLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(bottomView.centerY).with.offset(GET_SCAlE_HEIGHT(-8));
        make.left.mas_equalTo(self.view.left).with.offset(GET_SCAlE_LENGTH(10));
    }];
    moneyLabel.textColor = UIColorFromRGB(WHITECOLOR);
    moneyLabel.font = [UIFont systemFontOfSize:14];
    moneyLabel.text = @"实付款：";
    
    UILabel * coinLabel  = [UILabel new];
    [bottomView addSubview:coinLabel];
    [coinLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(bottomView.centerY).with.offset(GET_SCAlE_HEIGHT(22/2.0));
        make.left.mas_equalTo(self.view.left).with.offset(GET_SCAlE_LENGTH(10));
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
    _totalMoneyLabel.text = [NSString stringWithFormat:@"￥%0.2f",_productDetail.price.floatValue/100 * self.orderNumber * self.sleepDays - _productDetail.coinprice.floatValue*0];
    
    _totalCoinLabel  = [UILabel new];
    [bottomView addSubview:_totalCoinLabel];
    [_totalCoinLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(coinLabel.centerY).with.offset(0);
        make.left.mas_equalTo(coinLabel.right).with.offset(0);
    }];
    _totalCoinLabel.textColor = UIColorFromRGB(WHITECOLOR);
    _totalCoinLabel.font = [UIFont systemFontOfSize:CELLSMALLFONTSIZE];
    _totalCoinLabel.text = _productDetail.coinreturn?:@"";
    
    //添加事件
    [orderButton addTarget:self action:@selector(commitOrder) forControlEvents:UIControlEventTouchUpInside];
}

/**
 *  创建支付选择视图
 *
 *  @param line        基准线
 *  @param contentView 父视图
 */
- (void)createPayViewWithBaseLine:(UILabel *)line ContentView:(UIView *)contentView
{
//    UIImage * selectionImageNo = [UIImage imageNamed:sele]
    
    UIView * weiChatBaseView = [UIView new];
    [contentView addSubview:weiChatBaseView];
    [weiChatBaseView makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(contentView.left).with.offset(GET_SCAlE_LENGTH(15));
        make.bottom.mas_equalTo(line.top);
        make.size.mas_equalTo(CGSizeMake(GET_SCAlE_LENGTH(250), GET_SCAlE_HEIGHT(60)));
    }];
//    weiChatBaseView.backgroundColor = [UIColor orangeColor];
    
    _weiChatSelection = [UIButton buttonWithType:UIButtonTypeCustom];
    [weiChatBaseView addSubview:_weiChatSelection];
    [_weiChatSelection makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weiChatBaseView.centerY);
        make.left.mas_equalTo(weiChatBaseView.left);
        make.size.mas_equalTo(CGSizeMake(GET_SCAlE_LENGTH(15), GET_SCAlE_LENGTH(15)));
    }];
    [_weiChatSelection setImage:[UIImage imageNamed:@"selected_r"] forState:UIControlStateNormal];
    [_weiChatSelection setImage:[UIImage imageNamed:@"selected_rd"] forState:UIControlStateSelected];
//    weiChatSelection.layer.cornerRadius = GET_SCAlE_LENGTH(15)/2.0;
//    weiChatSelection.clipsToBounds = YES;
    _weiChatSelection.tag = 100;
    _weiChatSelection.selected = YES;
    [_weiChatSelection addTarget:self action:@selector(selectionButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView * weiChatLogo = [UIImageView new];
    [weiChatBaseView addSubview:weiChatLogo];
    [weiChatLogo makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weiChatBaseView.centerY);
        make.left.mas_equalTo(_weiChatSelection.right).with.offset(GET_SCAlE_LENGTH(10));
        make.size.mas_equalTo(CGSizeMake(GET_SCAlE_LENGTH(50), GET_SCAlE_HEIGHT(30)));
    }];
    weiChatLogo.backgroundColor = [UIColor orangeColor];
    
    UILabel * payNameTop  = [UILabel new];
    [weiChatBaseView addSubview:payNameTop];
    [payNameTop makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weiChatLogo.right).with.offset(GET_SCAlE_LENGTH(10));
        make.top.mas_equalTo(weiChatLogo.top).with.offset(0);
    }];
    payNameTop.textColor = UIColorFromRGB(BLACKFONTCOLOR);
    payNameTop.font = [UIFont systemFontOfSize:NORMALFONTSIZE];
    payNameTop.text = @"微信支付";
    
    UILabel * descripLabelTop  = [UILabel new];
    [weiChatBaseView addSubview:descripLabelTop];
    [descripLabelTop makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weiChatLogo.right).with.offset(GET_SCAlE_LENGTH(10));
        make.bottom.mas_equalTo(weiChatLogo.bottom).with.offset(0);
    }];
    descripLabelTop.textColor = UIColorFromRGB(GRAYFONTCOLOR);
    descripLabelTop.font = [UIFont systemFontOfSize:CELLSMALLFONTSIZE];
    descripLabelTop.text = @"推荐安装微信5.0及以上版本使用";
    
    //---------------------- 分割线 --------------------------
    
    UIView * aliPayBaseView = [UIView new];
    [contentView addSubview:aliPayBaseView];
    [aliPayBaseView makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(contentView.left).with.offset(GET_SCAlE_LENGTH(15));
        make.top.mas_equalTo(line.bottom);
        make.size.mas_equalTo(CGSizeMake(GET_SCAlE_LENGTH(250), GET_SCAlE_HEIGHT(60)));
    }];
//    aliPayBaseView.backgroundColor = [UIColor greenColor];
    
    _aliPaySelection = [UIButton buttonWithType:UIButtonTypeCustom];
    [aliPayBaseView addSubview:_aliPaySelection];
    [_aliPaySelection makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(aliPayBaseView.centerY);
        make.left.mas_equalTo(aliPayBaseView.left);
        make.size.mas_equalTo(CGSizeMake(GET_SCAlE_LENGTH(15), GET_SCAlE_LENGTH(15)));
    }];
    [_aliPaySelection setImage:[UIImage imageNamed:@"selected_r"] forState:UIControlStateNormal];
    [_aliPaySelection setImage:[UIImage imageNamed:@"selected_rd"] forState:UIControlStateSelected];
//    aliPayButton.layer.cornerRadius = GET_SCAlE_LENGTH(15)/2.0;
//    aliPayButton.clipsToBounds = YES;

    _aliPaySelection.tag = 101;
    [_aliPaySelection addTarget:self action:@selector(selectionButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView * aliPayLogo = [UIImageView new];
    [aliPayBaseView addSubview:aliPayLogo];
    [aliPayLogo makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(aliPayBaseView.centerY);
        make.left.mas_equalTo(_aliPaySelection.right).with.offset(GET_SCAlE_LENGTH(10));
        make.size.mas_equalTo(CGSizeMake(GET_SCAlE_LENGTH(50), GET_SCAlE_HEIGHT(30)));
    }];
    aliPayLogo.backgroundColor = [UIColor orangeColor];
    
    UILabel * payNameBottom  = [UILabel new];
    [aliPayBaseView addSubview:payNameBottom];
    [payNameBottom makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(aliPayLogo.right).with.offset(GET_SCAlE_LENGTH(10));
        make.top.mas_equalTo(aliPayLogo.top).with.offset(0);
    }];
    payNameBottom.textColor = UIColorFromRGB(BLACKFONTCOLOR);
    payNameBottom.font = [UIFont systemFontOfSize:NORMALFONTSIZE];
    payNameBottom.text = @"支付宝支付";
    
    UILabel * descripLabelBottom  = [UILabel new];
    [aliPayBaseView addSubview:descripLabelBottom];
    [descripLabelBottom makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(aliPayLogo.right).with.offset(GET_SCAlE_LENGTH(10));
        make.bottom.mas_equalTo(aliPayLogo.bottom).with.offset(0);
    }];
    descripLabelBottom.textColor = UIColorFromRGB(GRAYFONTCOLOR);
    descripLabelBottom.font = [UIFont systemFontOfSize:CELLSMALLFONTSIZE];
    descripLabelBottom.text = @"推荐已安装支付宝客户端的用户使用";
    
    //tag区分
    weiChatBaseView.tag = 600;
    aliPayBaseView.tag = 601;
    
    UITapGestureRecognizer * tapWeiChat = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectionBaseViewTaped:)];
    [weiChatBaseView addGestureRecognizer:tapWeiChat];
    
    UITapGestureRecognizer * tapAli = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectionBaseViewTaped:)];
    [aliPayBaseView addGestureRecognizer:tapAli];
    
}

#pragma mark - 事件

- (void)selectionBaseViewTaped:(UITapGestureRecognizer *)tap
{
    if (tap.view.tag == 600) {
        _weiChatSelection.selected = YES;
        _aliPaySelection.selected = NO;
        _payType = kWeixinPayType;
    }else{
        _aliPaySelection.selected = YES;
        _weiChatSelection.selected = NO;
        _payType = kAliPayType;
    }
}

- (void)selectionButtonClicked:(UIButton *)sender
{
    NSInteger position = sender.tag % 10;
    
    NSLog(@"position = %ld",position);
    
    if (sender == _weiChatSelection) {
        sender.selected = YES;
        _aliPaySelection.selected = NO;
        _payType = kWeixinPayType;
    }
    else if (sender == _aliPaySelection){
        sender.selected = YES;
        _weiChatSelection.selected = NO;
        _payType = kAliPayType;

    }else{
        BOOL selection = sender.selected;
        sender.selected = !selection;
        
    }
}

- (void)commitOrder
{
    NSLog(@"%s", __func__);
    
    self.hidesBottomBarWhenPushed = YES;
    OrderModel *order = [OrderModel new];
    
    if (!_isHotel) {
        order.productid = _productDetail.productid;
        order.buycount = @(self.orderNumber).stringValue;
        order.normtitle = _norm[@"normtitle"];
        order.indate = self.MonthDayArr.firstObject;
        order.outdate = self.MonthDayArr.lastObject;
        order.addressid = _productDetail.address;
        order.remark = @"";
        order.expresscompanyid = @"";
        order.usecoints = _productDetail.coinprice;
        order.title = _productDetail.title;
        order.totalAccount = self.orderNumber * _productDetail.price.floatValue/100 * self.sleepDays-_productDetail.coinprice.floatValue*0;
    }else{
    
    order.productid = _productDetail.productid;
    order.buycount = @(self.orderNumber).stringValue;
    order.normtitle = @"";
    order.indate = self.MonthDayArr.firstObject;
    order.outdate = self.MonthDayArr.lastObject;
    order.addressid = _productDetail.address;
    order.remark = @"";
    order.expresscompanyid = @"";
    order.usecoints = _productDetail.coinprice;
    order.title = _productDetail.title;
    order.totalAccount = self.orderNumber * _productDetail.price.floatValue/100 * self.sleepDays-_productDetail.coinprice.floatValue*0;
    }

    OrderPaymentViewController *pay = [[OrderPaymentViewController alloc]initPayOrder:order withPayType:_payType orderType:kOrderTypeReservation];
    [self.navigationController pushViewController:pay animated:YES];
    
}

#pragma mark -------------------------------------------------------------

-(instancetype)initWithOrderStatusType:(OrderOperationType)type
{
    self = [super init];
    
    if (self) {
        
        _currentStatusType = type;
    }
    
    return self;
}

#pragma mark - 生命周期

//- (void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated];
//}
//
//-(void)viewDidLoad
//{
//    [super viewDidLoad];
//    
//    [self loadCostomViw];
//}

#pragma mark - 自定义视图

/**
 *  装载自定义视图 总览
 */
- (void)test
{
    [self setNavigationBarLeftButtonImage:@"NavBar_Back"];
    
    [self setNavigationBarTitle:@"确认订单"];
    
//    isShowMiddleView = YES;
    
    [self createCustomView];
}

- (void)createCustomView
{
    UIView * contentView = [UIView new];
    [self.view addSubview:contentView];
    [contentView makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.customNavigationBar.bottom);
        make.left.right.and.bottom.mas_equalTo(self.view);
    }];
    contentView.backgroundColor = UIColorFromRGB(WHITECOLOR);
    
    if (_isSetAddr) {
        
        _middleView = [UIView new];
        [self.view addSubview:_middleView];
        [_middleView makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.right.mas_equalTo(self.view);
            make.top.mas_equalTo(self.customNavigationBar.bottom);
            make.height.mas_equalTo(@(GET_SCAlE_HEIGHT(203/2.0)));
        }];
        
        _middleLine = [UILabel new];
        [_middleView addSubview:_middleLine];
        [_middleLine makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(_middleView.mas_bottom);
            make.centerX.mas_equalTo(_middleView.mas_centerX);
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 0.5));
        }];
        _middleLine.backgroundColor = UIColorFromRGB(LINECOLOR);
        
        [self positionAddrInfo];
    }
    
    UILabel * line_two = [UILabel new];
    [contentView addSubview:line_two];
    [line_two makeConstraints:^(MASConstraintMaker *make) {
        if (_isSetAddr) {
            make.top.mas_equalTo(_middleView.bottom).with.offset(GET_SCAlE_HEIGHT(65/2.0));
        }else{
            make.top.mas_equalTo(self.customNavigationBar.mas_bottom).with.offset(GET_SCAlE_HEIGHT(65/2.0));
        }
        make.right.mas_equalTo(contentView.right);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - GET_SCAlE_LENGTH(15), 0.5));
    }];
    line_two.backgroundColor = UIColorFromRGB(LINECOLOR);
    
    UILabel * companyLabel  = [UILabel new];
    [contentView addSubview:companyLabel];
    [companyLabel makeConstraints:^(MASConstraintMaker *make) {
        if (_isSetAddr) {
            make.centerY.mas_equalTo(_middleLine.bottom).with.offset(GET_SCAlE_HEIGHT(65/4.0));
        }else{
            make.centerY.mas_equalTo(self.customNavigationBar.bottom).with.offset(GET_SCAlE_HEIGHT(65/4.0));
        }
        make.left.mas_equalTo(contentView.left).with.offset(GET_SCAlE_LENGTH(15));
    }];
    companyLabel.textColor = UIColorFromRGB(BLACKFONTCOLOR);
    companyLabel.font = [UIFont systemFontOfSize:14];
    companyLabel.text = @"广州某公司";
    
    UIImageView * arrow = [[UIImageView alloc] init];
    arrow.image = [UIImage imageNamed:@"arrow_right"];
    [contentView addSubview:arrow];
    [arrow makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(companyLabel.centerY);
        make.right.mas_equalTo(contentView.right).with.offset(GET_SCAlE_LENGTH(-15));
        make.size.mas_equalTo(CGSizeMake(arrow.image.size.width, arrow.image.size.height));
    }];
//    arrow.backgroundColor = [UIColor orangeColor];
    
    //第三部分 商品详情
    _headImageView = [UIImageView new];
    _headImageView.image = [UIImage imageNamed:@"headimage"];
    [contentView addSubview:_headImageView];
    [_headImageView makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(line_two.top).with.offset(SPACE);
        make.left.mas_equalTo(contentView.left).with.offset(SPACE_X);
        make.size.mas_equalTo(CGSizeMake(GET_SCAlE_LENGTH(100), GET_SCAlE_HEIGHT(75)));
    }];
//    _headImageView.backgroundColor = [UIColor orangeColor];
    
    _titleLabel  = [UILabel new];
    [contentView addSubview:_titleLabel];
    [_titleLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_headImageView.top).with.offset(0);
        make.left.mas_equalTo(_headImageView.right).with.offset(SPACE);
    }];
    _titleLabel.textColor = UIColorFromRGB(BLACKFONTCOLOR);
    _titleLabel.font = [UIFont systemFontOfSize:14];
    _titleLabel.text = @"莞式大保健一条龙";
    
    _priceLabel  = [UILabel new];
    [contentView addSubview:_priceLabel];
    
    UILabel * coinPriceTile  = [UILabel new];
    [contentView addSubview:coinPriceTile];
    
    UIView * reservationBaseView = [UIView new];
    [contentView addSubview:reservationBaseView];
    
    UILabel * priceTitleLabel  = [UILabel new];
    [contentView addSubview:priceTitleLabel];
    [priceTitleLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_priceLabel.centerY).with.offset(0);
        make.left.mas_equalTo(_titleLabel.left);
    }];
    priceTitleLabel.textColor = UIColorFromRGB(GRAYFONTCOLOR);
    priceTitleLabel.font = [UIFont systemFontOfSize:CELLSMALLFONTSIZE];
    priceTitleLabel.text = @"会员价：";
    
    [_priceLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(priceTitleLabel.right).with.offset(0);
        make.top.mas_equalTo(_titleLabel.bottom).with.offset(GET_SCAlE_HEIGHT(6));
        make.bottom.mas_equalTo(coinPriceTile.top);
        make.height.mas_equalTo(reservationBaseView.height);
    }];
    _priceLabel.textColor = UIColorFromRGB(REDFONTCOLOR);
    _priceLabel.font = [UIFont systemFontOfSize:NORMALFONTSIZE];
    _priceLabel.text = @"";
    
    [coinPriceTile makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_titleLabel.left).with.offset(0);
        make.top.mas_equalTo(_priceLabel.bottom).with.offset(0);
        make.bottom.mas_equalTo(reservationBaseView.top);
        
    }];
    coinPriceTile.textColor = UIColorFromRGB(GRAYFONTCOLOR);
    coinPriceTile.font = [UIFont systemFontOfSize:CELLSMALLFONTSIZE];
    coinPriceTile.text = @"狗币换购：";
    
    _coinPriceLabel  = [UILabel new];
    [contentView addSubview:_coinPriceLabel];
    [_coinPriceLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(coinPriceTile.centerY).with.offset(0);
        make.left.mas_equalTo(coinPriceTile.right).with.offset(0);
        make.height.mas_equalTo(_titleLabel.height);
    }];
    _coinPriceLabel.textColor = UIColorFromRGB(REDFONTCOLOR);
    _coinPriceLabel.font = [UIFont systemFontOfSize:NORMALFONTSIZE];
    _coinPriceLabel.text = @"";
    
    [reservationBaseView makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(coinPriceTile.bottom).with.offset(GET_SCAlE_HEIGHT(0));
        make.left.mas_equalTo(_titleLabel.left);
        make.bottom.mas_equalTo(_headImageView.bottom).with.offset(GET_SCAlE_HEIGHT(5));
        make.height.mas_equalTo(coinPriceTile.height);
        make.right.mas_equalTo(contentView.right).with.offset(GET_SCAlE_LENGTH(-15));
    }];
    //    reservationBaseView.backgroundColor = [UIColor orangeColor];
    
    UILabel * returnCoinTitleLabel  = [UILabel new];
    [reservationBaseView addSubview:returnCoinTitleLabel];
    [returnCoinTitleLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(reservationBaseView.centerY).with.offset(0);
        make.left.mas_equalTo(reservationBaseView.left).with.offset(0);
    }];
    returnCoinTitleLabel.textColor = UIColorFromRGB(GRAYFONTCOLOR);
    returnCoinTitleLabel.font = [UIFont systemFontOfSize:CELLSMALLFONTSIZE];
    returnCoinTitleLabel.text = @"消费返狗币：";
    
    _coinReturnLabel  = [UILabel new];
    [reservationBaseView addSubview:_coinReturnLabel];
    [_coinReturnLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(reservationBaseView.centerY).with.offset(0);
        make.left.mas_equalTo(returnCoinTitleLabel.right).with.offset(0);
    }];
    _coinReturnLabel.textColor = UIColorFromRGB(REDFONTCOLOR);
    _coinReturnLabel.font = [UIFont systemFontOfSize:NORMALFONTSIZE];
    _coinReturnLabel.text = @"";
    
    _numberLabel  = [UILabel new];
    [contentView addSubview:_numberLabel];
    [_numberLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_coinReturnLabel.bottom).with.offset(0);
        make.left.mas_equalTo(returnCoinTitleLabel.left).with.offset(0);
        make.height.mas_equalTo(_priceLabel.height);
    }];
    _numberLabel.textColor = UIColorFromRGB(GRAYFONTCOLOR);
    _numberLabel.font = [UIFont systemFontOfSize:CELLSMALLFONTSIZE];
    _numberLabel.text = @"数量：";
    
    UILabel * line = [UILabel new];
    [contentView addSubview:line];
    [line makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_numberLabel.mas_bottom).with.offset(5);
        make.right.mas_equalTo(contentView.right);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - GET_SCAlE_HEIGHT(15), 0.5));
    }];
    line.backgroundColor = UIColorFromRGB(LINECOLOR);
    
    //第四部分 支付详情
    NSArray * titles = [NSArray arrayWithObjects:@"支付方式",@"配送方式",@"使用狗币",@"合计",@"实付款",@"返狗币",@"订单状态", nil];
    NSArray * contents = [NSArray arrayWithObjects:@"微信支付",@"全场包邮",@"0",@"2000",@"2000",@"130",@"已支付", nil];
    [self createOrderInfoViewWithTitles:titles contents:contents baseLine:line];
    
    
}


/**
 *  配置收货地址视图
 */
- (void)positionAddrInfo
{
    UILabel * userNameLabel  = [UILabel new];
    [_middleView addSubview:userNameLabel];
    [userNameLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_middleView.top).with.offset(GET_SCAlE_HEIGHT(10));
        make.left.mas_equalTo(_middleView.left).with.offset(GET_SCAlE_LENGTH(15));
    }];
    userNameLabel.textColor = UIColorFromRGB(BLACKFONTCOLOR);
    userNameLabel.font = [UIFont systemFontOfSize:NORMALFONTSIZE];
    userNameLabel.text = @"收件人：小灰灰";
    
    UILabel * telphoneLabel  = [UILabel new];
    [_middleView addSubview:telphoneLabel];
    [telphoneLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(userNameLabel.centerY).with.offset(0);
        make.right.mas_equalTo(_middleView.right).with.offset(GET_SCAlE_LENGTH(-15));
    }];
    telphoneLabel.textColor = UIColorFromRGB(BLACKFONTCOLOR);
    telphoneLabel.font = [UIFont systemFontOfSize:NORMALFONTSIZE];
    telphoneLabel.text = @"18617105521";
    
    UILabel * addrLabel  = [UILabel new];
    [_middleView addSubview:addrLabel];
    [addrLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(userNameLabel.bottom).with.offset(GET_SCAlE_HEIGHT(5));
        make.left.mas_equalTo(userNameLabel.left).with.offset(0);
        make.right.mas_equalTo(_middleView.right).with.offset(GET_SCAlE_LENGTH(-15));
    }];
    addrLabel.textColor = UIColorFromRGB(BLACKFONTCOLOR);
    addrLabel.font = [UIFont systemFontOfSize:NORMALFONTSIZE];
    addrLabel.text = @"收件人地址：黑龙江省牡丹江市西安区温春农经学院家属楼阿里的是佛诶放假啊两款发动机阿里咖啡哦阿斯顿发科技拉克丝打飞机啊啥发动机";
    addrLabel.numberOfLines = 0;
    
    UIButton * mailPackageButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_middleView addSubview:mailPackageButton];
    [mailPackageButton makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(_middleView.bottom).with.offset(GET_SCAlE_HEIGHT(-10));
        make.right.mas_equalTo(_middleView.right).with.offset(GET_SCAlE_LENGTH(-15));
        make.size.mas_equalTo(CGSizeMake(GET_SCAlE_LENGTH(93), GET_SCAlE_HEIGHT(21)));
    }];
    
    [mailPackageButton setTitle:@"查物流" forState:UIControlStateNormal];
    [mailPackageButton.titleLabel setFont:[UIFont systemFontOfSize:NORMALFONTSIZE]];
    [mailPackageButton setTitleColor:UIColorFromRGB(WHITECOLOR) forState:UIControlStateNormal];
    [mailPackageButton setBackgroundImage:[UIImage imageNamed:@"mine_confrimReceiveandCommentButtonBG"] forState:UIControlStateNormal];
    [mailPackageButton setBackgroundImage:[UIImage imageNamed:@"mine_confrimReceiveandCommentButtonBG"] forState:UIControlStateHighlighted];
}


/**
 *  配置支付详情信息
 *
 *  @param titles   标题数组
 *  @param contents 内容数组
 *  @param baseLine 基准线
 */
- (void)createOrderInfoViewWithTitles:(NSArray *)titles contents:(NSArray *)contents baseLine:(UILabel *)baseLine
{
    for (NSInteger i = 0; i < titles.count ; i++) {
        
        UILabel * titleLabel  = [UILabel new];
        [baseLine.superview addSubview:titleLabel];
        [titleLabel makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(baseLine.left).with.offset(0);
            make.top.mas_equalTo(baseLine.bottom).with.offset(i * GET_SCAlE_HEIGHT(22) + GET_SCAlE_HEIGHT(10));
        }];
        
        titleLabel.textColor = UIColorFromRGB(GRAYFONTCOLOR);
        titleLabel.font = [UIFont systemFontOfSize:NORMALFONTSIZE];
        titleLabel.text = [NSString stringWithFormat:@"%@:",titles[i]];
        
        UILabel * contentLabel  = [UILabel new];
        [baseLine.superview addSubview:contentLabel];
        [contentLabel makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(titleLabel.centerY).with.offset(0);
            make.left.mas_equalTo(titleLabel.right).with.offset(GET_SCAlE_LENGTH(5));
        }];
        contentLabel.textColor = (i > 1)?UIColorFromRGB(REDFONTCOLOR):UIColorFromRGB(BLACKFONTCOLOR);
        contentLabel.font = [UIFont systemFontOfSize:NORMALFONTSIZE];
        contentLabel.text = (i == 3 || i == 4)?[NSString stringWithFormat:@"￥%@",contents[i]]:contents[i];
    }
    
    //第五部分
    UIView * bottomBaseView = [UIView new];
    [baseLine.superview addSubview:bottomBaseView];
    [bottomBaseView makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.centerX);
        make.top.mas_equalTo(baseLine.top).with.offset(titles.count * GET_SCAlE_HEIGHT(22) + GET_SCAlE_HEIGHT(20));
        make.size.mas_equalTo(CGSizeMake(GET_SCAlE_LENGTH(290), GET_SCAlE_HEIGHT(40)));
    }];
//    bottomBaseView.backgroundColor = [UIColor orangeColor];
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
 *  付款按钮点击事件
 */
- (void)payButtonClicked
{
    NSLog(@"%s", __func__);
}

/**
 *  删除订单按钮点击事件
 */
- (void)deleteOrderButtonClicked
{
    NSLog(@"%s", __func__);
}

/**
 *  收货并评论按钮点击事件
 */
- (void)receiveAndCommentButtonClicked
{
    NSLog(@"%s", __func__);
}

/**
 *  评价按钮点击事件
 */
- (void)toCommentButtonClicked
{
    NSLog(@"%s", __func__);
}

@end
