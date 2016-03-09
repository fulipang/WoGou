//
//  OrderDetailViewController.m
//  HomeShopping
//
//  Created by sooncong on 16/1/10.
//  Copyright © 2016年 Administrator. All rights reserved.
//

#import "OrderDetailViewController.h"

#define SPACE_X GET_SCAlE_LENGTH(15)
#define SPACE GET_SCAlE_HEIGHT(10)

@implementation OrderDetailViewController
{
    OrderOperationType _currentStatusType;
    
    //中部视图 用于显示收货地址/验证码
    UIView * _middleView;
    
    //是否显示中部视图
    BOOL isShowMiddleView;
    
    UILabel * _middleLine;
}

-(instancetype)initWithOrderStatusType:(OrderOperationType)type
{
    self = [super init];
    
    if (self) {
        
        _currentStatusType = type;
    }
    
    return self;
}

#pragma mark - 生命周期

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
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
    
    isShowMiddleView = YES;
    
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
    
    switch (_currentStatusType) {
        case kOrderOperationTypePay: {
//            <#statement#>
            break;
        }
        case kOrderOperationTypecomment: {
//            <#statement#>
            break;
        }
        case kOrderOperationTyperRceiveAndComment: {
//            <#statement#>
            break;
        }
        case kOrderOperationTypeDone: {
//            <#statement#>
            break;
        }
    }
    
    //第一部分 （订单）
    UILabel * line_top = [UILabel new];
    [contentView addSubview:line_top];
    [line_top makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(contentView.top).with.offset(GET_SCAlE_HEIGHT(25));
        make.right.mas_equalTo(contentView.right);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 0.5));
    }];
    line_top.backgroundColor = UIColorFromRGB(LINECOLOR);
    
    //订单相关
    UILabel * orderNumberLabel  = [UILabel new];
    [contentView addSubview:orderNumberLabel];
    [orderNumberLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(line_top).with.offset(GET_SCAlE_HEIGHT(-25/2.0));
        make.left.mas_equalTo(contentView.left).with.offset(GET_SCAlE_LENGTH(15));
    }];
    orderNumberLabel.textColor = UIColorFromRGB(GRAYFONTCOLOR);
    orderNumberLabel.font = [UIFont systemFontOfSize:NORMALFONTSIZE];
    orderNumberLabel.text = @"订单号：5457328";
    
    UILabel * orderTimeLabel  = [UILabel new];
    [contentView addSubview:orderTimeLabel];
    [orderTimeLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(orderNumberLabel.centerY).with.offset(0);
        make.right.mas_equalTo(contentView.right).with.offset(GET_SCAlE_LENGTH(-15));
    }];
    orderTimeLabel.textColor = UIColorFromRGB(GRAYFONTCOLOR);
    orderTimeLabel.font = [UIFont systemFontOfSize:NORMALFONTSIZE];
    orderTimeLabel.text = @"2015-12-25 22:22";
    
    
    if (isShowMiddleView) {
        
        _middleView = [UIView new];
        [self.view addSubview:_middleView];
        [_middleView makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.right.mas_equalTo(self.view);
            make.top.mas_equalTo(line_top.bottom);
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
        
        [self positionCode];
    }
    
    UILabel * line_two = [UILabel new];
    [contentView addSubview:line_two];
    [line_two makeConstraints:^(MASConstraintMaker *make) {
        if (isShowMiddleView) {
            make.top.mas_equalTo(_middleView.bottom).with.offset(GET_SCAlE_HEIGHT(65/2.0));
        }else{
            make.top.mas_equalTo(line_top.mas_bottom).with.offset(GET_SCAlE_HEIGHT(65/2.0));
        }
        make.right.mas_equalTo(contentView.right);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - GET_SCAlE_LENGTH(15), 0.5));
    }];
    line_two.backgroundColor = UIColorFromRGB(LINECOLOR);
    
    UILabel * companyLabel  = [UILabel new];
    [contentView addSubview:companyLabel];
    [companyLabel makeConstraints:^(MASConstraintMaker *make) {
        if (isShowMiddleView) {
            make.centerY.mas_equalTo(_middleLine.bottom).with.offset(GET_SCAlE_HEIGHT(65/4.0));
        }else{
            make.centerY.mas_equalTo(line_top).with.offset(GET_SCAlE_HEIGHT(65/4.0));
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

    //第三部分 商品详情
    _headImageView = [UIImageView new];
    _headImageView.image = [UIImage imageNamed:@"headimage"];
    [contentView addSubview:_headImageView];
    [_headImageView makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(line_two.top).with.offset(SPACE);
        make.left.mas_equalTo(contentView.left).with.offset(SPACE_X);
        make.size.mas_equalTo(CGSizeMake(GET_SCAlE_LENGTH(100), GET_SCAlE_HEIGHT(75)));
    }];
    
    _titleLabel  = [UILabel new];
    [contentView addSubview:_titleLabel];
    [_titleLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_headImageView.top).with.offset(0);
        make.left.mas_equalTo(_headImageView.right).with.offset(SPACE);
    }];
    _titleLabel.textColor = UIColorFromRGB(BLACKFONTCOLOR);
    _titleLabel.font = [UIFont systemFontOfSize:14];
    _titleLabel.text = @"莞式大保健一条龙";
    
    _orderDays  = [UILabel new];
    [contentView addSubview:_orderDays];
    [_orderDays makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(_titleLabel.bottom).with.offset(0);
        make.right.mas_equalTo(contentView.right).with.offset(GET_SCAlE_LENGTH(-SPACE));
    }];
    _orderDays.textColor = UIColorFromRGB(GRAYFONTCOLOR);
    _orderDays.font = [UIFont systemFontOfSize:SMALLFONTSIZE];
    _orderDays.text = @"共2晚";
    
    _numberLabel  = [UILabel new];
    [contentView addSubview:_numberLabel];
    
    UILabel * priceTitleLabel  = [UILabel new];
    [contentView addSubview:priceTitleLabel];
    
    UIView * reservationBaseView = [UIView new];
    [contentView addSubview:reservationBaseView];
    
    [_numberLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_titleLabel.left).with.offset(0);
        make.top.mas_equalTo(_titleLabel.bottom).with.offset(GET_SCAlE_HEIGHT(6));
        make.bottom.mas_equalTo(priceTitleLabel.top);
        make.height.mas_equalTo(reservationBaseView.height);
    }];
    _numberLabel.textColor = UIColorFromRGB(GRAYFONTCOLOR);
    _numberLabel.font = [UIFont systemFontOfSize:CELLSMALLFONTSIZE];
    _numberLabel.text = @"数量：2";
    
    [priceTitleLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_titleLabel.left).with.offset(0);
        make.top.mas_equalTo(_numberLabel.bottom).with.offset(0);
        make.bottom.mas_equalTo(reservationBaseView.top);
        
    }];
    priceTitleLabel.textColor = UIColorFromRGB(GRAYFONTCOLOR);
    priceTitleLabel.font = [UIFont systemFontOfSize:CELLSMALLFONTSIZE];
    priceTitleLabel.text = @"总价：";
    
    _priceLabel  = [UILabel new];
    [contentView addSubview:_priceLabel];
    [_priceLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(priceTitleLabel.centerY).with.offset(0);
        make.left.mas_equalTo(priceTitleLabel.right).with.offset(0);
        make.height.mas_equalTo(_titleLabel.height);
    }];
    _priceLabel.textColor = UIColorFromRGB(REDFONTCOLOR);
    _priceLabel.font = [UIFont systemFontOfSize:NORMALFONTSIZE];
    _priceLabel.text = @"2000";
    
    [reservationBaseView makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(priceTitleLabel.bottom).with.offset(GET_SCAlE_HEIGHT(0));
        make.left.mas_equalTo(_titleLabel.left);
        make.bottom.mas_equalTo(_headImageView.bottom);
        make.height.mas_equalTo(priceTitleLabel.height);
        make.right.mas_equalTo(contentView.right).with.offset(GET_SCAlE_LENGTH(-15));
    }];
    
    _beginDateLabel  = [UILabel new];
    [contentView addSubview:_beginDateLabel];
    [_beginDateLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(reservationBaseView.centerY).with.offset(0);
        make.left.mas_equalTo(reservationBaseView.left).with.offset(0);
    }];
    _beginDateLabel.textColor = UIColorFromRGB(GRAYFONTCOLOR);
    _beginDateLabel.font = [UIFont systemFontOfSize:CELLSMALLFONTSIZE];
    _beginDateLabel.text = @"入店：2015/12/25";
    
    _endDateLabel  = [UILabel new];
    [contentView addSubview:_endDateLabel];
    [_endDateLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(reservationBaseView.centerY).with.offset(0);
        make.left.mas_equalTo(reservationBaseView.centerX).with.offset(10);
    }];
    _endDateLabel.textColor = UIColorFromRGB(GRAYFONTCOLOR);
    _endDateLabel.font = [UIFont systemFontOfSize:CELLSMALLFONTSIZE];
    _endDateLabel.text = @"离店：2015/12/25";

    UILabel * line = [UILabel new];
    [contentView addSubview:line];
    [line makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_headImageView.mas_bottom).with.offset(SPACE);
        make.right.mas_equalTo(contentView.right);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - GET_SCAlE_HEIGHT(15), 0.5));
    }];
    line.backgroundColor = UIColorFromRGB(LINECOLOR);
    
    //第四部分 支付详情
    NSArray * titles = [NSArray arrayWithObjects:@"支付方式",@"配送方式",@"使用狗币",@"合计",@"实付款",@"返狗币",@"订单状态", nil];
    NSArray * contents = [NSArray arrayWithObjects:@"微信支付",@"全场包邮",@"0",@"2000",@"2000",@"130",@"已支付", nil];
    [self createOrderInfoViewWithTitles:titles contents:contents baseLine:line];
    
    
}

- (void)positionCode
{
    UILabel * titleLabel  = [UILabel new];
    [_middleLine addSubview:titleLabel];
    [titleLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_middleView.top).with.offset(GET_SCAlE_HEIGHT(10));
        make.left.mas_equalTo(_middleView.left).with.offset(GET_SCAlE_LENGTH(15));
    }];
    titleLabel.textColor = UIColorFromRGB(GRAYFONTCOLOR);
    titleLabel.font = [UIFont systemFontOfSize:NORMALFONTSIZE];
    titleLabel.text = @"温馨提示：请向酒店工作人员出示下方验证码";
    
    UILabel * codeLabel  = [UILabel new];
    [_middleLine addSubview:codeLabel];
    [codeLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(titleLabel.bottom).with.offset(GET_SCAlE_HEIGHT(20));
        make.centerX.mas_equalTo(_middleView.centerX).with.offset(0);
    }];
    codeLabel.textColor = UIColorFromRGB(GRAYFONTCOLOR);
    codeLabel.font = [UIFont systemFontOfSize:LARGEFONTSIZE];
    codeLabel.text = @"验证码：865832920";
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
    bottomBaseView.backgroundColor = [UIColor orangeColor];
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
