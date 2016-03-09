//
//  ConfirmHotelSuppliesOrderViewController2.m
//  HomeShopping
//
//  Created by pfl on 16/1/20.
//  Copyright © 2016年 Administrator. All rights reserved.
//

CALayer* GETArrowLayer(UIView *view) {
    CALayer *arrowLayer = [[CALayer alloc]init];
    UIImage *arrowImage = [UIImage imageNamed:@"arrow_right"];
    arrowLayer.contents = (__bridge id _Nullable)(arrowImage.CGImage);
    arrowLayer.frame = CGRectMake(0, 0, arrowImage.size.width, arrowImage.size.height);
    arrowLayer.position = CGPointMake(SCREEN_WIDTH-arrowImage.size.width/2-10, view.centerY_);
    [view.layer addSublayer:arrowLayer];
    return arrowLayer;
}

#import "Addresse.h"

@interface AddressTableViewCell : UITableViewCell
@property (nonatomic, readwrite, strong) Addresse *adress;
@end

@interface AddressTableViewCell ()
/// 详细地址
@property (nonatomic, readwrite, strong) UILabel *addressTextField;
/// 收件人
@property (nonatomic, readwrite, strong) UILabel *addresseeLabel;
/// 电话
@property (nonatomic, readwrite, strong) UILabel *phoneLabel;



- (void)cellWithModel:(Addresse *)model;


@end

@implementation AddressTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.contentView addSubview:self.addresseeLabel];
    [self.contentView addSubview:self.phoneLabel];
    [self.contentView addSubview:self.addressTextField];
    
    GETArrowLayer(self.contentView);
    
}


- (UILabel *)addressTextField {
    if (!_addressTextField) {
        _addressTextField = [[UILabel alloc] initWithFrame:CGRectMake(self.addresseeLabel.leftX, 0, SCREEN_WIDTH-20, self.addresseeLabel.heightY)];
        _addressTextField.text = @"收件人地址:";
        _addressTextField.font = self.addresseeLabel.font;
        _addressTextField.topY = self.addresseeLabel.bottomY;
    }
    return _addressTextField;
}

- (UILabel*)addresseeLabel {
    if (!_addresseeLabel) {
        _addresseeLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, SCREEN_WIDTH*0.3, 30)];
        _addresseeLabel.text = @"收件人:";
        _addresseeLabel.font = [UIFont systemFontOfSize:14];
    }
    return _addresseeLabel;
}

- (UILabel*)phoneLabel {
    if (!_phoneLabel) {
        _phoneLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, self.addresseeLabel.topY, SCREEN_WIDTH*0.7, self.addresseeLabel.heightY)];
        _phoneLabel.rightX = self.contentView.widthX-self.addresseeLabel.leftX-20;
        _phoneLabel.text = @"联系方式:";
        _phoneLabel.textAlignment = NSTextAlignmentRight;
        _phoneLabel.font = self.addresseeLabel.font;
    }
    return _phoneLabel;
}


- (void)setAdress:(Addresse *)adress {
    [self cellWithModel:adress];
}

-(void)cellWithModel:(Addresse *)model
{
    self.addressTextField.text = [[self.addressTextField.text componentsSeparatedByString:@":"].firstObject?:@"" stringByAppendingString:@":"];
    self.addresseeLabel.text = [[self.addresseeLabel.text componentsSeparatedByString:@":"].firstObject?:@"" stringByAppendingString:@":"];
    self.phoneLabel.text = [[self.phoneLabel.text componentsSeparatedByString:@":"].firstObject?:@"" stringByAppendingString:@":"];

    
    self.addresseeLabel.text = [self.addresseeLabel.text stringByAppendingString:model.consignee];
    self.phoneLabel.text = [self.phoneLabel.text stringByAppendingString:model.consigneephone];

    
    NSString *tempAddress = nil;
    NSArray *fourCities = @[@"北京", @"天津", @"上海", @"重庆"];
    for (NSString *city in fourCities) {
        NSRange range = [model.pca rangeOfString:city];
        if (range.location != NSNotFound) {
            tempAddress = [model.pca stringByReplacingCharactersInRange:range withString:@""];
            break;
        }
    }
    if (tempAddress) {
        self.addressTextField.text = [self.addressTextField.text stringByAppendingString:[NSString stringWithFormat:@"%@%@",tempAddress,model.consigneeaddress]];
    }
    else {
        self.addressTextField.text = [self.addressTextField.text stringByAppendingString:[NSString stringWithFormat:@"%@%@",model.pca,model.consigneeaddress]];
    }
    
    
}


@end

#import "ConfirmHotelSuppliesOrderViewController2.h"
#import "ReceivingGoodsAddressViewController.h"
#import "RoomReserVationDetailViewController.h"
#import "HotelSuppliesCommodityDetailViewController.h"
#import "HotelSuppliesProductCell.h"
#import "HSProduct.h"
#import "cellDemonstrationView.h"
#import "DayToDayTableViewCell.h"
#import "OrderModel.h"
#import "ProductDetailModelParser.h"
#import "ShoppingCarProduct.h"
#import "AddressModelParser.h"
#import "Addresse.h"


#define SPACE_X GET_SCAlE_LENGTH(15)
#define SPACE GET_SCAlE_HEIGHT(10)

@interface ConfirmHotelSuppliesOrderViewController2 ()
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

@property (nonatomic, readwrite, assign) OrderType orderType;

@end

@implementation ConfirmHotelSuppliesOrderViewController2
{
    OrderOperationType _currentStatusType;
    
    NSMutableArray * _addresData;
    NSDictionary * _normDic;
    
    Addresse * _addressModel;
    
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
    
    BOOL _isHotel;
    
    UITextField * _remarkTextField;
    
    NSMutableArray *_buyDaysArr;
    NSMutableArray *_productsArr;
    
    UIView *_aliPayView;
}

#pragma mark - 生命周期



-(instancetype)initWithDataSource:(NSArray *)dataSource withOrderType:(OrderType)orderType {
    if (self = [super initWithNibName:nil bundle:nil]) {
        _orderType = orderType;
        if (orderType == kOrderTypeReservation) {
            _isHotel = YES;
        }
        self.dataSource = dataSource;
    }
    return self;
}

-(instancetype)initWithNormDic:(NSDictionary *)normDic withOrderType:(OrderType)orderType
{
    if (self = [super init]) {
        _orderType = orderType;
        if (orderType == kOrderTypeReservation) {
            _isHotel = YES;
        }
        
        normDic = _normDic;
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    _addresData = [NSMutableArray array];
    
    [self getAddrList];
    
    [self loadCostomViw];
    
    _payType = kWeixinPayType;
    
    
    //    [self getProductDetailData];
}


- (void)setDataSource:(NSArray *)dataSource  {
    _dataSource = dataSource;
    _productsArr = [NSMutableArray array];
    _buyDaysArr = [NSMutableArray array];
    if (_dataSource) {
        
        for (NSArray *arr in dataSource) {
            [_productsArr addObject:arr.firstObject];
            [_buyDaysArr addObject:arr.lastObject];
            
        }
        
    }
    
    [self.mainTableView reloadData];
}


#pragma mark - 网络

- (void)getAddrList
{
    [[NetWorkSingleton sharedManager] getReceivingGoodsAddressWhetherGetDefaultAddress:YES GetReight:YES GetPayType:YES SuccessBlock:^(id responseBody) {
        
        AddressModelParser * parser = [[AddressModelParser alloc] initWithDictionary:responseBody];
        NSArray * arr = parser.addressModel.addresse;
        
        id arrM = responseBody[@"body"][@"addresses"];
        
        if ([arrM isKindOfClass:[NSDictionary class]]) {
//            Addresse * model = [Addresse modelObjectWithDictionary:arrM[@"address"]];
//            [_addresData addObject:model];
            _addressModel = [Addresse modelObjectWithDictionary:arrM[@"address"]]?:[Addresse new];
            [_addresData addObject:_addressModel];

        }else{
            
            if (_dataSource.count > 0) {
                [_addresData removeAllObjects];
            }
            
            [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if ([obj isKindOfClass:[Addresse class]]) {
                    [_addresData addObject:obj];
                }
            }];
            _addressModel = [_addresData firstObject];
        }
        
        [self.mainTableView reloadData];
        
        
    } FailureBlock:^(NSString *error) {
        
    }];
}

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
    self.mainTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    [self.view addSubview:self.mainTableView];
    [self.mainTableView makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view.bottom).with.offset(GET_SCAlE_HEIGHT(-50));
        make.top.mas_equalTo(self.customNavigationBar.bottom);
    }];
    
    self.mainTableView.delegate       = self;
    self.mainTableView.dataSource     = self;
    self.mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.mainTableView registerClass:[AddressTableViewCell class] forCellReuseIdentifier:NSStringFromClass([AddressTableViewCell class])];
    
    
    self.mainTableView.tableFooterView = [self setupPayTypeView];
    
    [self.mainTableView registerClass:[HotelSuppliesProductCell class] forCellReuseIdentifier:@"HotelSuppliesProductCell"];
    [self.mainTableView registerClass:[DayToDayTableViewCell class] forCellReuseIdentifier:@"HotelDayToDayCell"];
    
    
    
}

#pragma mark - UITableviewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    /// 酒店用品
    if (self.dataSource.count) {
        if (!_isHotel) {
            return self.dataSource.count+1;
        }
        return self.dataSource.count;
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 1;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (_isHotel) {
        return  GET_SCAlE_HEIGHT(140);
    }
    else {
        if (indexPath.section == 0) {
            return GET_SCAlE_HEIGHT(70);
        }
        else {
            return  GET_SCAlE_HEIGHT(110);
        }
    }
    
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    /// 是酒店
    if (_isHotel) {
        DayToDayTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"HotelDayToDayCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        ShoppingCarProduct *product = _productsArr[indexPath.section];
        HSProduct *model = [HSProduct new];
        cell.MonthDayArr = @[product.indate?:@"",product.outdate?:@""];
        cell.orderNumber = [_buyDaysArr[indexPath.section] intValue];
        model.price = product.price;
        model.coinprice = product.coinprice;
        model.coinreturn = product.coinreturn;
        model.logo = product.logo;
        model.title = product.title;
        [cell cellForRowWithModel:model];
        return cell;
    }
    else {
        
        if (indexPath.section == 0) {
            AddressTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"AddressTableViewCell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            if (_addresData.count > 0) {
                [cell cellWithModel:_addressModel];
            }
            return cell;
        }
        else {
            DayToDayTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"HotelDayToDayCell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.MonthDayArr = nil; //这句必须的
            cell.orderNumber = [_buyDaysArr[indexPath.section-1] intValue];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            ShoppingCarProduct *product = _productsArr[indexPath.section-1];
            HSProduct *model = [HSProduct new];
            model.price = product.price;
            model.coinprice = product.coinprice;
            model.coinreturn = product.coinreturn;
            model.logo = product.logo;
            model.title = product.title;
            [cell cellForRowWithModel:model];
            return cell;
        }
    }
    
    
    return nil;
}

#pragma mark UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return GET_SCAlE_HEIGHT(30);
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.001;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (!_isHotel) {
        if (indexPath.section == 0) {
            AddressTableViewCell *cell = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
            ReceivingGoodsAddressViewController *addressVC = [[ReceivingGoodsAddressViewController alloc]init];
            [addressVC setCallbackAddressID:^(Addresse *address) {
                _addressModel = address;
                cell.adress = address;
            }];
            self.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:addressVC animated:YES];
        }
        else {
            self.hidesBottomBarWhenPushed = YES;
            
            self.hidesBottomBarWhenPushed = YES;
            ShoppingCarProduct *model = _productsArr[indexPath.section-1];
            HotelSuppliesCommodityDetailViewController * VC = [[HotelSuppliesCommodityDetailViewController alloc] initWithProductID:model.productid?:@""];
            [self.navigationController pushViewController:VC animated:YES];

        }
        
    }
    else {
        ShoppingCarProduct *orderDetail = _productsArr[indexPath.section];
        RoomReserVationDetailViewController * VC = [[RoomReserVationDetailViewController alloc] initWithSellerID:orderDetail.sellerid?:@""];
        [self.navigationController pushViewController:VC animated:YES];
    }
    

    
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, GET_SCAlE_HEIGHT(30))];
    UILabel *titleL = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH-40, backView.heightY)];
    [backView addSubview:titleL];
    titleL.font = [UIFont systemFontOfSize:14];
    
    if (!_isHotel) {
        if (section == 0) {
            titleL.text = @"送货地址";
        }
        else {
            GETArrowLayer(backView);
            titleL.text = [(ShoppingCarProduct*)_productsArr[section-1] sellername];
        }
    }
    else {
        GETArrowLayer(backView);
        titleL.text = [(ShoppingCarProduct*)_productsArr[section] sellername];
    }

    return backView;
}

- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    if (_isHotel) {
        if (section == self.dataSource.count-1) {
            //            return [self setupPayTypeView];
        }
    }
    else {
        if (section == self.dataSource.count) {
            //            return [self setupPayTypeView];
        }
    }
    
    return nil;
}

- (UIView*)setupPayTypeView {
    UIView * contentView = [[UIView alloc] init];
    
    contentView.frame = CGRectMake(0, 0, SCREEN_WIDTH, GET_SCAlE_HEIGHT(300));
    contentView.hidden = NO;
    
    UITextField * remarkTextField  = [UITextField new];
    _remarkTextField = remarkTextField;
    [contentView addSubview:remarkTextField];
    [remarkTextField makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(contentView.top).with.offset(GET_SCAlE_HEIGHT(10));
        make.left.mas_equalTo(contentView.left).with.offset(GET_SCAlE_LENGTH(15));
        make.size.mas_equalTo((CGSize){SCREEN_WIDTH-30,GET_SCAlE_HEIGHT(30)});
    }];
    remarkTextField.textColor = UIColorFromRGB(BLACKFONTCOLOR);
    remarkTextField.font = [UIFont systemFontOfSize:NORMALFONTSIZE];
    remarkTextField.placeholder = @"订单留言(选填)";
    
    UILabel * lineF = [UILabel new];
    [contentView addSubview:lineF];
    [lineF makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(remarkTextField.bottom).with.offset(0.5);
        make.centerX.mas_equalTo(contentView.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 0.5));
    }];
    lineF.backgroundColor = UIColorFromRGB(LINECOLOR);
    
    
    
    UILabel * titleLable  = [UILabel new];
    [contentView addSubview:titleLable];
    [titleLable makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(remarkTextField.bottom).with.offset(GET_SCAlE_HEIGHT(10));
        make.left.mas_equalTo(contentView.left).with.offset(GET_SCAlE_LENGTH(15));
    }];
    titleLable.textColor = UIColorFromRGB(BLACKFONTCOLOR);
    titleLable.font = [UIFont systemFontOfSize:NORMALFONTSIZE];
    titleLable.text = @"支付方式:";
    
    //画线
    //    UILabel * line_1 = [UILabel new];
    //    [contentView addSubview:line_1];
    //    [line_1 makeConstraints:^(MASConstraintMaker *make) {
    //        make.top.mas_equalTo(titleLable.bottom).with.offset(GET_SCAlE_HEIGHT(10));
    //        make.centerX.mas_equalTo(contentView.mas_centerX);
    //        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 0.5));
    //    }];
    //    line_1.backgroundColor = UIColorFromRGB(LINECOLOR);
    
    [self createPayViewWithBaseLine:titleLable ContentView:contentView];
    
    
    UILabel * line_2 = [UILabel new];
    [contentView addSubview:line_2];
    [line_2 makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_aliPayView.bottom).with.offset(GET_SCAlE_HEIGHT(60));
        make.centerX.mas_equalTo(contentView.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 0.5));
    }];
    line_2.backgroundColor = UIColorFromRGB(LINECOLOR);
    
    //配置内容
    [self createBottomViewWithBaseLine:line_2 ContentView:contentView];
    return contentView;
}


#pragma mark 自定义控件
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
        make.bottom.mas_equalTo(line.top).with.offset(GET_SCAlE_HEIGHT(GET_SCAlE_HEIGHT(-10)));
        make.size.mas_equalTo(CGSizeMake(GET_SCAlE_LENGTH(15), GET_SCAlE_LENGTH(15)));
    }];
    [_coinSelection setImage:[UIImage imageNamed:@"selected"] forState:UIControlStateNormal];
    [_coinSelection setImage:[UIImage imageNamed:@"selected_d"] forState:UIControlStateSelected];
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
        make.bottom.mas_equalTo(_coinSelection.top).with.offset(GET_SCAlE_HEIGHT(-10));
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
    _totalMoneyLabel.text = [NSString stringWithFormat:@"￥%0.2f",self.totalMoney];
    
    _totalCoinLabel  = [UILabel new];
    [bottomView addSubview:_totalCoinLabel];
    [_totalCoinLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(coinLabel.centerY).with.offset(0);
        make.left.mas_equalTo(coinLabel.right).with.offset(0);
    }];
    _totalCoinLabel.textColor = UIColorFromRGB(WHITECOLOR);
    _totalCoinLabel.font = [UIFont systemFontOfSize:CELLSMALLFONTSIZE];
    _totalCoinLabel.text = @(self.totalReturn).stringValue;
    
    //添加事件
    [orderButton addTarget:self action:@selector(commitOrder) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setTotalMoney:(float)totalMoney {
    _totalMoney = totalMoney;
    _totalMoneyLabel.text = [NSString stringWithFormat:@"￥%0.2f",self.totalMoney];
}

- (void)setTotalReturn:(float)totalReturn {
    _totalReturn = totalReturn;
    _totalCoinLabel.text = @(self.totalReturn).stringValue;
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
        make.left.mas_equalTo(contentView.left).with.offset(GET_SCAlE_LENGTH(5));
        make.top.mas_equalTo(line.bottom).offset(GET_SCAlE_HEIGHT(0));
        make.size.mas_equalTo(CGSizeMake(GET_SCAlE_LENGTH(250), GET_SCAlE_HEIGHT(60)));
    }];
//        weiChatBaseView.backgroundColor = [UIColor orangeColor];
    
    _weiChatSelection = [UIButton buttonWithType:UIButtonTypeCustom];
    [weiChatBaseView addSubview:_weiChatSelection];
    [_weiChatSelection makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weiChatBaseView.centerY);
        make.left.mas_equalTo(weiChatBaseView.left);
        make.size.mas_equalTo(CGSizeMake(GET_SCAlE_LENGTH(15), GET_SCAlE_LENGTH(15)));
    }];
    [_weiChatSelection setImage:[UIImage imageNamed:@"selected"] forState:UIControlStateNormal];
    [_weiChatSelection setImage:[UIImage imageNamed:@"selected_d"] forState:UIControlStateSelected];
    [_weiChatSelection setImage:[UIImage imageNamed:@"selected"] forState:UIControlStateNormal];
    [_weiChatSelection setImage:[UIImage imageNamed:@"selected_d"] forState:UIControlStateSelected];
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
//    weiChatLogo.backgroundColor = [UIColor orangeColor];
    [weiChatLogo setImage:[UIImage imageNamed:@"pay_wechat"]];
    
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
    
    
    //画线
    UILabel * line_1 = [UILabel new];
    [contentView addSubview:line_1];
    [line_1 makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weiChatBaseView.bottom).with.offset(GET_SCAlE_HEIGHT(10));
        make.centerX.mas_equalTo(contentView.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 0.5));
    }];
    line_1.backgroundColor = UIColorFromRGB(LINECOLOR);
    
    
    //---------------------- 分割线 --------------------------
    
    UIView * aliPayBaseView = [UIView new];
    _aliPayView = aliPayBaseView;
    [contentView addSubview:aliPayBaseView];
    [aliPayBaseView makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(contentView.left).with.offset(GET_SCAlE_LENGTH(5));
        make.top.mas_equalTo(line_1.bottom).offset(GET_SCAlE_HEIGHT(10));
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
    [_aliPaySelection setImage:[UIImage imageNamed:@"selected"] forState:UIControlStateNormal];
    [_aliPaySelection setImage:[UIImage imageNamed:@"selected_d"] forState:UIControlStateSelected];
    [_aliPaySelection setImage:[UIImage imageNamed:@"selected"] forState:UIControlStateNormal];
    [_aliPaySelection setImage:[UIImage imageNamed:@"selected_d"] forState:UIControlStateSelected];
    _aliPaySelection.tag = 101;
    [_aliPaySelection addTarget:self action:@selector(selectionButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView * aliPayLogo = [UIImageView new];
    [aliPayBaseView addSubview:aliPayLogo];
    [aliPayLogo makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(aliPayBaseView.centerY);
        make.left.mas_equalTo(_aliPaySelection.right).with.offset(GET_SCAlE_LENGTH(10));
        make.size.mas_equalTo(CGSizeMake(GET_SCAlE_LENGTH(50), GET_SCAlE_HEIGHT(30)));
    }];
    [aliPayLogo setImage:[UIImage imageNamed:@"pay_ali"]];
    
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
    
    
    if (!_isHotel && !_addressModel.addressid) {
        [SVProgressHUD showErrorWithStatus:@"没有选择收货地址" duration:1.5];
        return;
    }
    
    
    self.hidesBottomBarWhenPushed = YES;
    
    NSMutableArray *products = [NSMutableArray array];
    float totalMoney = 0;
    for (int i = 0; i < _productsArr.count; i++) {
        ShoppingCarProduct *product = _productsArr[i];
        OrderModel *order = [OrderModel new];
        order.productid = product.productid;
        order.buycount = _buyDaysArr[i];
        order.normtitle = product.normtitle?:@"";
        order.indate = product.indate;
        order.outdate = product.outdate;
        if (!_isHotel) {
            if (_addressModel.addressid && !order.addressid) {
                order.addressid = _addressModel.addressid;
            }
        }
        
        if (!order.remark) {
            order.remark = _remarkTextField.text;
        }
        if (!order.expresscompanyid && !_isHotel) {
            order.expresscompanyid = @"";
            
        }
        order.usecoints = _productDetail.coinprice;
        order.title = _productDetail.title;
        totalMoney += product.price.floatValue * [_buyDaysArr[i] intValue];
        [products addObject:order];
        
    }
    
    OrderPaymentViewController *pay = [[OrderPaymentViewController alloc]initWithProducts:products withPayType:_payType orderType:_orderType];
    pay.totalMoney = self.totalMoney*100.0;
    [self.navigationController pushViewController:pay animated:YES];
    
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
