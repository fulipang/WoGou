//
//  OrderDetailHotelSuppliesViewController.m
//  HomeShopping
//
//  Created by sooncong on 16/1/11.
//  Copyright © 2016年 Administrator. All rights reserved.
//

//#import "Orders.h"
#import "OrderDetail.h"
#import "OrderDetailproducts.h"
#import "OrderPaymentViewController.h"
#import "GiveCommentViewController.h"
#import "RoomReserVationDetailViewController.h"
#import "HotelSuppliesCommodityDetailViewController.h"

#define SPACE_X GET_SCAlE_LENGTH(15)
#define SPACE GET_SCAlE_HEIGHT(10)

@interface HotelOderDetailCell : UITableViewCell

@property (nonatomic, strong) UIImageView * headImageView;
@property (nonatomic, strong) UILabel * priceLabel;
@property (nonatomic, strong) UILabel * numberLabel;
@property (nonatomic, strong) UILabel * titleLabel;
@property (nonatomic, strong) UILabel * orderDays;
@property (nonatomic, strong) UILabel * beginDateLabel;
@property (nonatomic, strong) UILabel * endDateLabel;


/**
 *  配置cell参数
 *
 *  @param model 数据模型
 */
- (void)setCellWithModel:(OrderDetailproducts *)model OrderModel:(OrderDetail *)order;


@end


@implementation HotelOderDetailCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self loadCustomView];
    }
    return self;
}

- (void)loadCustomView
{
    UILabel * line = [UILabel new];
    [self addSubview:line];
    [line makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.mas_bottom);
        make.right.mas_equalTo(self.right);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - GET_SCAlE_LENGTH(10), 0.5));
    }];
    line.backgroundColor = UIColorFromRGB(LINECOLOR);
    
    _headImageView = [UIImageView new];
    _headImageView.image = [UIImage imageNamed:@"headimage"];
    [self addSubview:_headImageView];
    [_headImageView makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.top).with.offset(SPACE);
        make.left.mas_equalTo(self.left).with.offset(SPACE_X);
        make.size.mas_equalTo(CGSizeMake(GET_SCAlE_LENGTH(100), GET_SCAlE_HEIGHT(75)));
    }];
    
    _titleLabel  = [UILabel new];
    [self addSubview:_titleLabel];
    [_titleLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_headImageView.top).with.offset(0);
        make.left.mas_equalTo(_headImageView.right).with.offset(SPACE);
    }];
    _titleLabel.textColor = UIColorFromRGB(BLACKFONTCOLOR);
    _titleLabel.font = [UIFont systemFontOfSize:14];
//    _titleLabel.text = @"莞式大保健一条龙";
    
    _orderDays  = [UILabel new];
    [self addSubview:_orderDays];
    [_orderDays makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(_titleLabel.bottom).with.offset(0);
        make.right.mas_equalTo(self.right).with.offset(GET_SCAlE_LENGTH(-SPACE));
    }];
    _orderDays.textColor = UIColorFromRGB(GRAYFONTCOLOR);
    _orderDays.font = [UIFont systemFontOfSize:SMALLFONTSIZE];
    
    _numberLabel  = [UILabel new];
    [self addSubview:_numberLabel];
    
    UILabel * priceTitleLabel  = [UILabel new];
    [self addSubview:priceTitleLabel];
    
    UIView * reservationBaseView = [UIView new];
    [self addSubview:reservationBaseView];
    
    [_numberLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_titleLabel.left).with.offset(0);
        make.top.mas_equalTo(_titleLabel.bottom).with.offset(GET_SCAlE_HEIGHT(6));
        make.bottom.mas_equalTo(priceTitleLabel.top);
        make.height.mas_equalTo(reservationBaseView.height);
    }];
    _numberLabel.textColor = UIColorFromRGB(GRAYFONTCOLOR);
    _numberLabel.font = [UIFont systemFontOfSize:CELLSMALLFONTSIZE];
    _numberLabel.text = @"数量：";
    
    [priceTitleLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_titleLabel.left).with.offset(0);
        make.top.mas_equalTo(_numberLabel.bottom).with.offset(0);
        make.bottom.mas_equalTo(reservationBaseView.top);
        
    }];
    priceTitleLabel.textColor = UIColorFromRGB(GRAYFONTCOLOR);
    priceTitleLabel.font = [UIFont systemFontOfSize:CELLSMALLFONTSIZE];
    priceTitleLabel.text = @"总价：";
    
    _priceLabel  = [UILabel new];
    [self addSubview:_priceLabel];
    [_priceLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(priceTitleLabel.centerY).with.offset(0);
        make.left.mas_equalTo(priceTitleLabel.right).with.offset(0);
        make.height.mas_equalTo(_titleLabel.height);
    }];
    _priceLabel.textColor = UIColorFromRGB(REDFONTCOLOR);
    _priceLabel.font = [UIFont systemFontOfSize:NORMALFONTSIZE];
//        _priceLabel.text = @"2000";
    
    [reservationBaseView makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(priceTitleLabel.bottom).with.offset(GET_SCAlE_HEIGHT(0));
        make.left.mas_equalTo(_titleLabel.left);
        make.bottom.mas_equalTo(_headImageView.bottom);
        make.height.mas_equalTo(priceTitleLabel.height);
        make.right.mas_equalTo(self.right).with.offset(GET_SCAlE_LENGTH(-15));
    }];
    
    _beginDateLabel  = [UILabel new];
    [self addSubview:_beginDateLabel];
    [_beginDateLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(reservationBaseView.centerY).with.offset(0);
        make.left.mas_equalTo(reservationBaseView.left).with.offset(0);
    }];
    _beginDateLabel.textColor = UIColorFromRGB(GRAYFONTCOLOR);
    _beginDateLabel.font = [UIFont systemFontOfSize:CELLSMALLFONTSIZE];
//        _beginDateLabel.text = @"入店：2015/12/25";
    
    _endDateLabel  = [UILabel new];
    [self addSubview:_endDateLabel];
    [_endDateLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(reservationBaseView.centerY).with.offset(0);
        make.left.mas_equalTo(reservationBaseView.centerX).with.offset(10);
    }];
    _endDateLabel.textColor = UIColorFromRGB(GRAYFONTCOLOR);
    _endDateLabel.font = [UIFont systemFontOfSize:CELLSMALLFONTSIZE];
//    _endDateLabel.text = @"离店：2015/12/25";
}

-(void)setCellWithModel:(OrderDetailproducts *)model OrderModel:(OrderDetail *)order
{
    [_headImageView sd_setImageWithURL:[NSURL URLWithString:model.logo] placeholderImage:[UIImage imageNamed:@"headimage"]];
    _titleLabel.text = model.title;
    _numberLabel.text = [NSString stringWithFormat:@"数量：%ld",[model.buycount integerValue]];
    _priceLabel.text = [NSString stringWithFormat:@"%.2f",[model.price floatValue]/100];
    if ([model.producttype integerValue] == 2) {
        _beginDateLabel.text = [NSString stringWithFormat:@"入店：%@",model.indate];
        _endDateLabel.text = [NSString stringWithFormat:@"离店：%@", model.outdate];
        _orderDays.text = [NSString stringWithFormat:@"共%ld晚",[model.buycount integerValue]];
    }

}


@end

#pragma mark -

#import "OrderDetailHotelSuppliesViewController.h"
#import "OrderDetailModelParser.h"
#import "OrderDetail.h"
#import "Address.h"
#import "Coupons.h"

#define SPACE_X GET_SCAlE_LENGTH(15)
#define SPACE GET_SCAlE_HEIGHT(10)

@implementation OrderDetailHotelSuppliesViewController
{
    NSMutableArray * _dataSource;
    OrderDetail * _orderDetail;
    
//    BOOL _isHotel;
    
    Orders * _orderModel;
    
    NSMutableArray * _couponsData;
}

-(instancetype)initWithOrderModel:(Orders *)model
{
    self = [super init];
    
    if (self) {
        
        _orderModel = model;
        self.view.backgroundColor = [UIColor whiteColor];
    }
    
    return self;
}

#pragma mark - 生命周期

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self getOrderDetailData];

}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    _dataSource  = [NSMutableArray array];
    _couponsData = [NSMutableArray array];
    
    [self loadCostomViw];
}

#pragma mark - 自定义视图

/**
 *  装载自定义视图 总览
 */
- (void)loadCostomViw
{
    [self setNavigationBarLeftButtonImage:@"NavBar_Back"];
    
    [self setNavigationBarTitle:@"订单详情"];
    
    [self loadMainTableView];
}

- (void)loadMainTableView
{
    self.mainTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    [self.view addSubview:self.mainTableView];
    [self.mainTableView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.and.bottom.mas_equalTo(self.view);
        make.top.mas_equalTo(self.customNavigationBar.bottom);
    }];
    
    self.mainTableView.delegate       = self;
    self.mainTableView.dataSource     = self;
    self.mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.mainTableView.backgroundColor = UIColorFromRGB(WHITECOLOR);
    
    [self.mainTableView registerClass:[HotelOderDetailCell class] forCellReuseIdentifier:@"cell"];
    [self.mainTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"normalCell"];
    
}

- (UIView *)createFooterView
{
    UIView * view = [UIView new];
    
    view.frame = CGRectMake(0, 0, SCREEN_WIDTH, GET_SCAlE_HEIGHT(300));
    view.backgroundColor = UIColorFromRGB(WHITECOLOR);
    
    NSString * RealPayMoney = [NSString stringWithFormat:@"%.2f",([_orderDetail.totalcost floatValue] - [_orderDetail.discount floatValue])/100];
    NSString * TotalMoney = [NSString stringWithFormat:@"%.2f",[_orderDetail.totalcost floatValue]/100];
    NSString * status;
    
    OrderStatusType type = [_orderDetail.status integerValue];
    
    switch (type) {
        case kOrderStatusAll: {
            status = @"";
            break;
        }
        case kOrderStatusWaitForPay: {
            status = @"待支付";
            break;
        }
        case kOrderStatusWaitForSendConsignment: {
            status = @"待发货";
            break;
        }
        case kOrderStatusWaitForReceiveProduct: {
            status = (_isHotel)?@"待消费":@"待发货";
            break;
        }
        case kOrderStatusWaitForGiveComment: {
            status = @"待评价";
            break;
        }
        case kOrderStatusAlreadyComment: {
            status = @"已评价";
            break;
        }
        case kOrderStatusAlreadyPayed: {
            status = @"已支付";
            break;
        }
    }
    
    
    //第四部分 支付详情
    NSArray * titles = [NSArray arrayWithObjects:@"支付方式",@"配送方式",@"使用狗币",@"合计",@"实付款",@"返狗币",@"订单状态", nil];
    NSArray * contents = [NSArray arrayWithObjects:@"微信支付",@"全场包邮",_orderDetail.usecoints,TotalMoney,RealPayMoney,_orderDetail.backcoints,status, nil];
    
    for (NSInteger i = 0; i < titles.count ; i++) {
        
        UILabel * titleLabel  = [UILabel new];
        [view addSubview:titleLabel];
        [titleLabel makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(view.left).with.offset(GET_SCAlE_LENGTH(15));
            make.top.mas_equalTo(view.top).with.offset(i * GET_SCAlE_HEIGHT(22) + GET_SCAlE_HEIGHT(10));
        }];
        
        titleLabel.textColor = UIColorFromRGB(GRAYFONTCOLOR);
        titleLabel.font = [UIFont systemFontOfSize:NORMALFONTSIZE];
        titleLabel.text = [NSString stringWithFormat:@"%@:",titles[i]];
        
        UILabel * contentLabel  = [UILabel new];
        [view addSubview:contentLabel];
        [contentLabel makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(titleLabel.centerY).with.offset(0);
            make.left.mas_equalTo(titleLabel.right).with.offset(GET_SCAlE_LENGTH(5));
        }];
        contentLabel.textColor = (i > 1)?UIColorFromRGB(REDFONTCOLOR):UIColorFromRGB(BLACKFONTCOLOR);
        contentLabel.font = [UIFont systemFontOfSize:NORMALFONTSIZE];
        contentLabel.text = (i == 3 || i == 4)?[NSString stringWithFormat:@"￥%@",contents[i]]:contents[i];
    }

    UIView * bottomBaseView = [UIView new];
    [view addSubview:bottomBaseView];
    [bottomBaseView makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(view.centerX);
        make.top.mas_equalTo(view.top).with.offset(titles.count * GET_SCAlE_HEIGHT(22) + GET_SCAlE_HEIGHT(20));
        make.size.mas_equalTo(CGSizeMake(GET_SCAlE_LENGTH(290), GET_SCAlE_HEIGHT(40)));
    }];
//    bottomBaseView.backgroundColor = [UIColor orangeColor];
    ;
    
    switch (type) {
        case kOrderStatusAll: {
            
            break;
        }
        case kOrderStatusWaitForPay: {
            
            UIButton * leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [bottomBaseView addSubview:leftButton];
            [leftButton makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(bottomBaseView.centerY);
                make.left.mas_equalTo(bottomBaseView.left);
                make.size.mas_equalTo(CGSizeMake(GET_SCAlE_LENGTH(280/2.0), GET_SCAlE_HEIGHT(40)));
            }];
            [leftButton setTitle:@"删除订单" forState:UIControlStateNormal];
            [leftButton.titleLabel setFont:[UIFont systemFontOfSize:LARGEFONTSIZE]];
            [leftButton setTitleColor:UIColorFromRGB(BLACKFONTCOLOR) forState:UIControlStateNormal];
            leftButton.layer.cornerRadius = 10;
            leftButton.clipsToBounds = YES;
            leftButton.backgroundColor = UIColorFromRGB(GRAYBGCOLOR);
            leftButton.layer.borderColor = UIColorFromRGB(GRAYLINECOLOR).CGColor;
            leftButton.layer.borderWidth = 1;
            

            UIButton * rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [bottomBaseView addSubview:rightButton];
            [rightButton makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(bottomBaseView.centerY);
                make.right.mas_equalTo(bottomBaseView.right);
                make.size.mas_equalTo(CGSizeMake(GET_SCAlE_LENGTH(280/2.0), GET_SCAlE_HEIGHT(40)));
            }];
            [rightButton setTitle:@"付款" forState:UIControlStateNormal];
            [rightButton.titleLabel setFont:[UIFont systemFontOfSize:LARGEFONTSIZE]];
            [rightButton setTitleColor:UIColorFromRGB(WHITECOLOR) forState:UIControlStateNormal];
            rightButton.layer.cornerRadius = 10;
            rightButton.clipsToBounds = YES;
            rightButton.backgroundColor = [UIColor orangeColor];
            [rightButton addTarget:self action:@selector(payButtonClicked) forControlEvents:UIControlEventTouchUpInside];

            
            break;
        }
        case kOrderStatusWaitForSendConsignment: {
            
            break;
        }
        case kOrderStatusWaitForReceiveProduct: {
            
            if (_isHotel) {
                
            }else{
                UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
                [bottomBaseView addSubview:button];
                [button makeConstraints:^(MASConstraintMaker *make) {
                    make.left.right.top.and.bottom.mas_equalTo(bottomBaseView);
                }];
                [button setTitle:@"确认收货并评价" forState:UIControlStateNormal];
                [button.titleLabel setFont:[UIFont systemFontOfSize:LARGEFONTSIZE]];
                [button setTitleColor:UIColorFromRGB(WHITECOLOR) forState:UIControlStateNormal];
                [button addTarget:self action:@selector(receiveAndCommentButtonClicked) forControlEvents:UIControlEventTouchUpInside];
                button.layer.cornerRadius = 10;
                button.clipsToBounds = YES;
                button.backgroundColor = [UIColor orangeColor];
            }
            
            break;
        }
        case kOrderStatusWaitForGiveComment: {
            
            UIButton * leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [bottomBaseView addSubview:leftButton];
            [leftButton makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(bottomBaseView.centerY);
                make.left.mas_equalTo(bottomBaseView.left);
                make.size.mas_equalTo(CGSizeMake(GET_SCAlE_LENGTH(280/2.0), GET_SCAlE_HEIGHT(40)));
            }];
            [leftButton setTitle:@"删除订单" forState:UIControlStateNormal];
            [leftButton.titleLabel setFont:[UIFont systemFontOfSize:LARGEFONTSIZE]];
            [leftButton setTitleColor:UIColorFromRGB(BLACKFONTCOLOR) forState:UIControlStateNormal];
            leftButton.layer.cornerRadius = 10;
            leftButton.clipsToBounds = YES;
            leftButton.backgroundColor = UIColorFromRGB(GRAYBGCOLOR);
            leftButton.layer.borderColor = UIColorFromRGB(GRAYLINECOLOR).CGColor;
            leftButton.layer.borderWidth = 1;
            
            
            UIButton * rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [bottomBaseView addSubview:rightButton];
            [rightButton makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(bottomBaseView.centerY);
                make.right.mas_equalTo(bottomBaseView.right);
                make.size.mas_equalTo(CGSizeMake(GET_SCAlE_LENGTH(280/2.0), GET_SCAlE_HEIGHT(40)));
            }];
            [rightButton setTitle:@"去评价" forState:UIControlStateNormal];
            [rightButton.titleLabel setFont:[UIFont systemFontOfSize:LARGEFONTSIZE]];
            [rightButton setTitleColor:UIColorFromRGB(WHITECOLOR) forState:UIControlStateNormal];
            rightButton.layer.cornerRadius = 10;
            rightButton.clipsToBounds = YES;
            rightButton.backgroundColor = [UIColor orangeColor];
            [rightButton addTarget:self action:@selector(toCommentButtonClicked) forControlEvents:UIControlEventTouchUpInside];
            
            break;
        }
        case kOrderStatusAlreadyComment: {
            
            break;
        }
        case kOrderStatusAlreadyPayed: {
            
            break;
        }
    }
    
    return view;
    
}

#pragma mark - UITableviewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 0.1;
    }
    else if (indexPath.section == 1)
    {
        if (_isHotel) {
            return GET_SCAlE_HEIGHT(20);
        }else{
            return GET_SCAlE_HEIGHT(100);
        }
    }else{
    
        return GET_SCAlE_HEIGHT(100);   
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return GET_SCAlE_HEIGHT(20);
            break;
            
        case 1:
            
            if (_isHotel) {
                if ([_orderDetail.status integerValue] != 1) {
                    return GET_SCAlE_HEIGHT(25);
                }else{
                    return 0.1;
                }
            }else{
                return 0.1;
            }
            break;
            
        default:
            return GET_SCAlE_HEIGHT(33);
            break;
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 0;
            break;
            
        case 1:             //  中间显示部分
        {
            if (_isHotel) { //  酒店
                
                
                return _couponsData.count;

            }else{          //  用品
                return (_dataSource.count > 0)?1:0;
            }
            
            break;
        }
        default:
        {
            NSArray * arrM = _orderDetail.orderDetailproducts;
            return ([self isProductOne:arrM])?1:arrM.count;
        }
            break;
        
    }
    
    
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, (section == 0)?GET_SCAlE_HEIGHT(20):GET_SCAlE_HEIGHT(33))];
    view.backgroundColor = UIColorFromRGB(WHITECOLOR);
    
    switch (section) {
        case 0:
        {
            //订单相关
            UILabel * orderNumberLabel  = [UILabel new];
            [view addSubview:orderNumberLabel];
            [orderNumberLabel makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(view.centerY);
                make.left.mas_equalTo(view.left).with.offset(GET_SCAlE_LENGTH(15));
            }];
            orderNumberLabel.textColor = UIColorFromRGB(GRAYFONTCOLOR);
            orderNumberLabel.font = [UIFont systemFontOfSize:SMALLFONTSIZE];
            orderNumberLabel.text = [NSString stringWithFormat:@"订单号：%@",_orderDetail.ordernum];
            
            UILabel * orderTimeLabel  = [UILabel new];
            [view addSubview:orderTimeLabel];
            [orderTimeLabel makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(orderNumberLabel.centerY).with.offset(0);
                make.right.mas_equalTo(view.right).with.offset(GET_SCAlE_LENGTH(-15));
            }];
            orderTimeLabel.textColor = UIColorFromRGB(GRAYFONTCOLOR);
            orderTimeLabel.font = [UIFont systemFontOfSize:SMALLFONTSIZE];
            orderTimeLabel.text = _orderDetail.borndate;
        }
            break;
            
        case 1:{
            
            if (_isHotel) {
                
                if ([_orderDetail.status integerValue] != 1) {
                    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, GET_SCAlE_HEIGHT(25))];
                    view.backgroundColor = [UIColor whiteColor];
                    
                    UILabel * titleLabel  = [UILabel new];
                    [view addSubview:titleLabel];
                    [titleLabel makeConstraints:^(MASConstraintMaker *make) {
                        make.centerY.mas_equalTo(view.centerY).with.offset(GET_SCAlE_HEIGHT(0));
                        make.left.mas_equalTo(view.left).with.offset(GET_SCAlE_LENGTH(15));
                    }];
                    titleLabel.textColor = UIColorFromRGB(GRAYFONTCOLOR);
                    titleLabel.font = [UIFont systemFontOfSize:NORMALFONTSIZE];
                    titleLabel.text = @"温馨提示：请向酒店工作人员出示下方验证码";
                    return view;
                }else{
                    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.1)];
                    return view;
                }
                
                
            }else{
                UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.1)];
                return view;
            }
            
            break;
        }
            
        default:
        {
            UILabel * line = [UILabel new];
            [view addSubview:line];
            [line makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(view.top);
                make.centerX.mas_equalTo(view.mas_centerX);
                make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 0.5));
            }];
            line.backgroundColor = UIColorFromRGB(LINECOLOR);
            
            UILabel * companyLabel  = [UILabel new];
            [view addSubview:companyLabel];
            [companyLabel makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(view.centerY);
                make.left.mas_equalTo(view.left).with.offset(GET_SCAlE_LENGTH(15));
            }];
            companyLabel.textColor = UIColorFromRGB(BLACKFONTCOLOR);
            companyLabel.font = [UIFont systemFontOfSize:14];
            companyLabel.text = _orderModel.sellername;
            
            UIImageView * arrow = [[UIImageView alloc] init];
            arrow.image = [UIImage imageNamed:@"arrow_right"];
            [view addSubview:arrow];
            [arrow makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(companyLabel.centerY);
                make.right.mas_equalTo(view.right).with.offset(GET_SCAlE_LENGTH(-10));
                make.size.mas_equalTo(CGSizeMake(arrow.image.size.width, arrow.image.size.height));
            }];
        }
            break;
    }
    
    UILabel * line = [UILabel new];
    [view addSubview:line];
    [line makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(view.mas_bottom);
        make.right.mas_equalTo(view.right);
        make.size.mas_equalTo(CGSizeMake((section == 0)?SCREEN_WIDTH:(SCREEN_WIDTH - GET_SCAlE_LENGTH(15)), 0.5));
    }];
    line.backgroundColor = UIColorFromRGB(LINECOLOR);
    
    return view;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 1) {
        
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"normalCell"];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (_isHotel) {
            
//            OrderDetailproducts * order = _dataSource[indexPath.row];
            
            if (_couponsData.count > 0) {
                cell.textLabel.text = [NSString stringWithFormat:@"%@ %@",_couponsData[indexPath.row][@"title"],_couponsData[indexPath.row][@"code"]];
                cell.textLabel.textColor = UIColorFromRGB(GRAYFONTCOLOR);
                cell.textLabel.font = [UIFont systemFontOfSize:NORMALFONTSIZE];
                [cell.textLabel makeConstraints:^(MASConstraintMaker *make) {
                    make.centerY.mas_equalTo(cell.contentView.centerY);
                    make.left.mas_equalTo(cell.contentView.left).with.offset(GET_SCAlE_LENGTH(15));
                }];
            }

            
        }else{
            
            for (id subView in cell.contentView.subviews) {
                
                if ([subView isKindOfClass:[UIView class]]) {
                    
                    UIView *vie = (UIView *)subView;
                    [vie removeFromSuperview];
                }
            }
            
            [cell.contentView addSubview:[self viewWithCell:indexPath]];
        }
        return cell;
    }

    
    HotelOderDetailCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (_dataSource.count > 0) {
        [cell setCellWithModel:_dataSource[indexPath.row] OrderModel:_orderDetail];
    }
    return cell;
    
    
//    switch (indexPath.section) {
//        case 0:{
//            
//            UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"a"];
//            
//            if (cell == nil) {
//                UITableViewCell * cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"a"];
//                
////                for (id subView in cell.contentView.subviews) {
////                    
////                    if ([subView isKindOfClass:[UIView class]]) {
////                        
////                        UIView *vie = (UIView *)subView;
////                        [vie removeFromSuperview];
////                    }
////                }
////                
////                [cell.contentView addSubview:[self viewWithCell:indexPath]];
//            }
////
//            return cell;
//            break;
//        }
//        default:{
//            HotelOderDetailCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
//            cell.selectionStyle = UITableViewCellSelectionStyleNone;
//
//            NSArray * products = _orderModel.products;
//            if (products.count > 0) {
//                [cell setCellWithModel:products[indexPath.row] OrderModel:_orderModel];
//            }
//            return cell;
//
//            break;
//        }
//    }
    
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 2) {
        
        Products * model = _orderDetail.orderDetailproducts[indexPath.row];
        ProductType type = [model.producttype integerValue];
        
        switch (type) {
            case kProductTypeEntity: {
                self.hidesBottomBarWhenPushed = YES;
                HotelSuppliesCommodityDetailViewController * VC = [[HotelSuppliesCommodityDetailViewController alloc] initWithProductID:model.productid];
                [self.navigationController pushViewController:VC animated:YES];
                self.hidesBottomBarWhenPushed = NO;
                break;
            }
            case kProductTypeVirtual: {
                self.hidesBottomBarWhenPushed = YES;
                RoomReserVationDetailViewController * VC = [[RoomReserVationDetailViewController alloc] initWithSellerID:_orderDetail.sellerid];
                [self.navigationController pushViewController:VC animated:YES];
                self.hidesBottomBarWhenPushed = NO;
                break;
            }
        }
    }
}

- (UIView *)viewWithCell:(NSIndexPath *)indexPath
{
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, GET_SCAlE_HEIGHT(100))];
    
    Address * addresModel = _orderDetail.address;
    
    UILabel * userNameLabel  = [UILabel new];
    [view addSubview:userNameLabel];
    [userNameLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(view.top).with.offset(GET_SCAlE_HEIGHT(10));
        make.left.mas_equalTo(view.left).with.offset(GET_SCAlE_LENGTH(15));
    }];
    userNameLabel.textColor = UIColorFromRGB(BLACKFONTCOLOR);
    userNameLabel.font = [UIFont systemFontOfSize:NORMALFONTSIZE];
//    userNameLabel.text = @"收件人：小灰灰";
    userNameLabel.text = [NSString stringWithFormat:@"收件人：%@",addresModel.consignee];

    UILabel * telphoneLabel  = [UILabel new];
    [view addSubview:telphoneLabel];
    [telphoneLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(userNameLabel.centerY).with.offset(0);
        make.right.mas_equalTo(view.right).with.offset(GET_SCAlE_LENGTH(-15));
    }];
    telphoneLabel.textColor = UIColorFromRGB(BLACKFONTCOLOR);
    telphoneLabel.font = [UIFont systemFontOfSize:NORMALFONTSIZE];
//    telphoneLabel.text = @"18617105521";
    telphoneLabel.text = addresModel.consigneephone;
    
    
    UILabel * addrLabel  = [UILabel new];
    [view addSubview:addrLabel];
    [addrLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(userNameLabel.bottom).with.offset(GET_SCAlE_HEIGHT(5));
        make.left.mas_equalTo(userNameLabel.left).with.offset(0);
        make.right.mas_equalTo(view.right).with.offset(GET_SCAlE_LENGTH(-15));
    }];
    addrLabel.textColor = UIColorFromRGB(BLACKFONTCOLOR);
    addrLabel.font = [UIFont systemFontOfSize:NORMALFONTSIZE];
    addrLabel.text = [NSString stringWithFormat:@"收货人地址：%@%@",addresModel.pca,addresModel.consigneeaddress];
    addrLabel.numberOfLines = 0;
    
    UIButton * mailPackageButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [view addSubview:mailPackageButton];
    [mailPackageButton makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(view.bottom).with.offset(GET_SCAlE_HEIGHT(-10));
        make.right.mas_equalTo(view.right).with.offset(GET_SCAlE_LENGTH(-15));
        make.size.mas_equalTo(CGSizeMake(GET_SCAlE_LENGTH(93), GET_SCAlE_HEIGHT(21)));
    }];
    
    [mailPackageButton setTitle:@"查物流" forState:UIControlStateNormal];
    [mailPackageButton.titleLabel setFont:[UIFont systemFontOfSize:NORMALFONTSIZE]];
    [mailPackageButton setTitleColor:UIColorFromRGB(WHITECOLOR) forState:UIControlStateNormal];
    [mailPackageButton setBackgroundImage:[UIImage imageNamed:@"mine_confrimReceiveandCommentButtonBG"] forState:UIControlStateNormal];
    [mailPackageButton setBackgroundImage:[UIImage imageNamed:@"mine_confrimReceiveandCommentButtonBG"] forState:UIControlStateHighlighted];
    [mailPackageButton addTarget:self action:@selector(mailButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel * line = [UILabel new];
    [view addSubview:line];
    [line makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(view.mas_bottom);
        make.centerX.mas_equalTo(view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 0.5));
    }];
    line.backgroundColor = UIColorFromRGB(LINECOLOR);
    
    return view;
}

#pragma mark - 网络

- (void)getOrderDetailData
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
    [bodyDic setObject:@"sj_orderdetail" forKey:@"functionid"];
    [bodyDic setObject:_orderModel.orderid forKey:@"orderid"];
    [bodyDic setObject:_orderModel.ordernum forKey:@"ordernum"];
    
    NSString * ut = [[AppInformationSingleton shareAppInfomationSingleton] getLoginCode];
    NSString * userid = [[AppInformationSingleton shareAppInfomationSingleton] getUserID];
    
    if (ut) {
        [headDic setObject:ut forKey:@"ut"];
        [headDic setObject:userid forKey:@"userid"];
    }
    
    [[NetWorkSingleton sharedManager] postWithHeadParameter:headDic bodyParameter:bodyDic SuccessBlock:^(id responseBody) {
        
        if ([self isRequestSuccess:responseBody]) {
            [SVProgressHUD dismissWithSuccess:@"加载成功" afterDelay:0.5];
        }else{
            [SVProgressHUD dismiss];
        }
        
        OrderDetailModelParser * parser = [[OrderDetailModelParser alloc] initWithDictionary:responseBody];
//        NSLog(@"result = %@",parser);
        _orderDetail = parser.orderDetailModel.orderDetail;
        [_dataSource addObjectsFromArray:_orderDetail.orderDetailproducts];
        
        if ([self isProductOne:_dataSource]) {
            for (OrderDetailproducts * model in _dataSource) {
                if ([model isKindOfClass:[OrderDetailproducts class]]) {
                    if ([model.productid integerValue] != 0) {
                        NSArray * arrM = model.coupons;

                        if ([self isCouponOne:arrM])
                        {
                            
                            for (Coupons * coupon in arrM) {
                                if ([coupon.couponcode integerValue] != 0) {
                                    NSMutableDictionary * dic = [[NSMutableDictionary alloc] init];
                                    [dic setObject:model.title forKey:@"title"];
                                    [dic setObject:coupon.couponcode forKey:@"code"];
                                    [_couponsData addObject:dic];
                                }
                            }
                        }
                        else
                        {
                            for (Coupons * coupon in arrM) {
                                if ([coupon.couponcode integerValue] != 0) {
                                    NSMutableDictionary * dic = [[NSMutableDictionary alloc] init];
                                    [dic setObject:model.title forKey:@"title"];
                                    [dic setObject:coupon.couponcode forKey:@"code"];
                                    [_couponsData addObject:dic];
                                }
                            }
                        }
                    }
                }
            }
        }else{
            for (OrderDetailproducts * model in _dataSource) {
                if ([model isKindOfClass:[OrderDetailproducts class]]) {
                    NSArray * arrM = model.coupons;
                    
                    if ([self isCouponOne:arrM])
                    {
                        
                        for (Coupons * coupon in arrM) {
                            if ([coupon.couponcode integerValue] != 0) {
                                NSMutableDictionary * dic = [[NSMutableDictionary alloc] init];
                                [dic setObject:model.title forKey:@"title"];
                                [dic setObject:coupon.couponcode forKey:@"code"];
                                [_couponsData addObject:dic];
                            }
                        }
                    }
                    else
                    {
                        for (Coupons * coupon in arrM) {
                            if ([coupon.couponcode integerValue] != 0) {
                                NSMutableDictionary * dic = [[NSMutableDictionary alloc] init];
                                [dic setObject:model.title forKey:@"title"];
                                [dic setObject:coupon.couponcode forKey:@"code"];
                                [_couponsData addObject:dic];
                            }
                        }
                    }
                }
            }
        }
        
        [self.mainTableView reloadData];
        
        self.mainTableView.tableFooterView = [self createFooterView];
        
    } FailureBlock:^(NSString *error) {
       
        [SVProgressHUD dismiss];
        
    }];
}

#pragma mark - 事件

-(void)leftButtonClicked
{
    
    if (self.isFromPay) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    else
        [self.navigationController popViewControllerAnimated:YES];
}

-(void)rightButtonClicked
{
    
}

- (void)mailButtonClicked
{
    NSString *showMsg = @"敬请期待";
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"提示"
                                                    message: showMsg
                                                   delegate: self
                                          cancelButtonTitle:@"确定"
                                          otherButtonTitles: nil, nil];
    
    [alert show];

}

- (BOOL)isProductOne:(NSArray *)array
{
    __block BOOL isOne = NO;
    
    if (array.count == 2) {
        [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if ([obj isKindOfClass:[OrderDetailproducts class]]) {
                
                OrderDetailproducts * model = (OrderDetailproducts *)obj;
                
                if ([model.productid isEqualToString:@"0"]) {
                    isOne = YES;
                }
            }
        }];
    }
    
    return isOne;
}

- (BOOL)isCouponOne:(NSArray *)array
{
    __block BOOL isOne = NO;
    
    if (array.count == 2) {
        [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if ([obj isKindOfClass:[Coupons class]]) {
                
                Coupons * model = (Coupons*)obj;
                
                if ([model.couponcode isEqualToString:@"0"]) {
                    isOne = YES;
                }
            }
        }];
    }
    
    return isOne;
}

/**
 *  支付
 */
- (void)payButtonClicked
{
//    NSLog(@"%s", __func__);
    self.hidesBottomBarWhenPushed = YES;
    OrderPaymentViewController * VC = [[OrderPaymentViewController alloc] initPrepayID:_orderDetail.prepayid orderNumber:_orderDetail.ordernum payType:(_orderDetail.paytype.intValue == 1)?kWeixinPayType:kAliPayType];
    NSString * RealPayMoney = [NSString stringWithFormat:@"%.2f",([_orderDetail.totalcost floatValue] - [_orderDetail.discount floatValue])/100];
    VC.totalMoney = RealPayMoney.floatValue * 100;
    [self.navigationController pushViewController:VC animated:YES];
}

/**
 *  删除订单
 */
- (void)deleteOrderButtonClicked
{
    NSLog(@"%s", __func__);
}

/**
 *  收货
 */
- (void)receiveAndCommentButtonClicked
{
    
    NSString *showMsg = @"确认收到货品？";
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @""
                                                    message: showMsg
                                                   delegate: self
                                          cancelButtonTitle:@"取消"
                                          otherButtonTitles: @"确定", nil];
    [alert show];

    
}

/**
 *  评价
 */
- (void)toCommentButtonClicked
{
//    NSLog(@"%s", __func__);
    self.hidesBottomBarWhenPushed = YES;
    GiveCommentViewController * VC = [[GiveCommentViewController alloc] init];
    VC.orderid = _orderDetail.orderid;
    [self.navigationController pushViewController:VC animated:YES];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
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
        [bodyDic setObject:_orderDetail.orderid forKey:@"orderid"];
        
        NSString * ut = [[AppInformationSingleton shareAppInfomationSingleton] getLoginCode];
        NSString * userid = [[AppInformationSingleton shareAppInfomationSingleton] getUserID];
        
        if (ut) {
            [headDic setObject:ut forKey:@"ut"];
            [headDic setObject:userid forKey:@"userid"];
        }
        
        [[NetWorkSingleton sharedManager] postWithHeadParameter:headDic bodyParameter:bodyDic SuccessBlock:^(id responseBody) {
            
            if ([self isRequestSuccess:responseBody]) {
                [SVProgressHUD dismissWithSuccess:@"收货成功"];
                
                [self toCommentButtonClicked];
                
            }else{
                [SVProgressHUD dismiss];
            }
            
        } FailureBlock:^(NSString *error) {
            
            [SVProgressHUD dismiss];
        }];

    }
}

@end
