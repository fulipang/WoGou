//
//  OrderProductCell.m
//  HomeShopping
//
//  Created by sooncong on 16/1/10.
//  Copyright © 2016年 Administrator. All rights reserved.
//

#import "OrderProductCell.h"
#import "UIImageView+WebCache.h"
#import "Coupon.h"

#define SPACE_X GET_SCAlE_LENGTH(15)
#define SPACE GET_SCAlE_HEIGHT(10)

@implementation OrderProductCell
{
    OrderCellCallBackBlock _callBackblock;
//    OrderOperationType _currentType;
    OrderType _currentOrderType;
    
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _currentOrderType = kOrderTypeReservation;
        
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
        make.centerX.mas_equalTo(self.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 0.5));
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
//    _orderDays.text = @"共2晚";
    
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
//    _priceLabel.text = @"2000";
    
    [reservationBaseView makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(priceTitleLabel.bottom).with.offset(GET_SCAlE_HEIGHT(0));
        make.left.mas_equalTo(_titleLabel.left);
        make.bottom.mas_equalTo(_headImageView.bottom);
        make.height.mas_equalTo(priceTitleLabel.height);
        make.right.mas_equalTo(self.right).with.offset(GET_SCAlE_LENGTH(-15));
    }];
//    reservationBaseView.backgroundColor = [UIColor orangeColor];
    
    _beginDateLabel  = [UILabel new];
    [self addSubview:_beginDateLabel];
    [_beginDateLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(reservationBaseView.centerY).with.offset(0);
        make.left.mas_equalTo(reservationBaseView.left).with.offset(0);
    }];
    _beginDateLabel.textColor = UIColorFromRGB(GRAYFONTCOLOR);
    _beginDateLabel.font = [UIFont systemFontOfSize:CELLSMALLFONTSIZE];
//    _beginDateLabel.text = @"入店：2015/12/25";
    
    _endDateLabel  = [UILabel new];
    [self addSubview:_endDateLabel];
    [_endDateLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(reservationBaseView.centerY).with.offset(0);
        make.left.mas_equalTo(reservationBaseView.centerX).with.offset(10);
    }];
    _endDateLabel.textColor = UIColorFromRGB(GRAYFONTCOLOR);
    _endDateLabel.font = [UIFont systemFontOfSize:CELLSMALLFONTSIZE];
//    _endDateLabel.text = @"离店：2015/12/25";
    
    UIView * bottomView = [UIView new];
    [self addSubview:bottomView];
    [bottomView makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.headImageView.bottom).with.offset(5);
        make.left.mas_equalTo(self.left).with.offset(SPACE_X);
        make.right.mas_equalTo(self.right).with.offset(-SPACE_X);
        make.bottom.mas_equalTo(self.bottom).with.offset(-5);
    }];
    
    _codeTitleLabel  = [UILabel new];
    [bottomView addSubview:_codeTitleLabel];
    [_codeTitleLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(bottomView.centerY).with.offset(0);
        make.left.mas_equalTo(_headImageView.left).with.offset(0);
    }];
    _codeTitleLabel.textColor = UIColorFromRGB(GRAYFONTCOLOR);
    _codeTitleLabel.font = [UIFont systemFontOfSize:NORMALFONTSIZE];
    _codeTitleLabel.text = @"验证码：";
    
    _confirmCodeLabel  = [UILabel new];
    [bottomView addSubview:_confirmCodeLabel];
    [_confirmCodeLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_codeTitleLabel.centerY).with.offset(0);
        make.left.mas_equalTo(_codeTitleLabel.right).with.offset(0);
    }];
    _confirmCodeLabel.textColor = UIColorFromRGB(REDFONTCOLOR);
    _confirmCodeLabel.font = [UIFont systemFontOfSize:NORMALFONTSIZE];
//    _confirmCodeLabel.text = @"536271";
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    [bottomView addSubview:button];
    [button makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(bottomView.centerY);
        make.right.mas_equalTo(bottomView.right);
        make.size.mas_equalTo(CGSizeMake(GET_SCAlE_LENGTH(187/2.0), GET_SCAlE_HEIGHT(21)));
    }];
    [button setTitle:@"去评价" forState:UIControlStateNormal];
    button.tag = 250;
    [button.titleLabel setFont:[UIFont systemFontOfSize:SMALLFONTSIZE]];
    [button setTitleColor:UIColorFromRGB(WHITECOLOR) forState:UIControlStateNormal];
    [button setTitleColor:UIColorFromRGB(GRAYFONTCOLOR) forState:UIControlStateDisabled];
    [button setBackgroundImage:[UIImage imageNamed:@"mine_confrimReceiveandCommentButtonBG"] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"mine_confrimReceiveandCommentButtonBG"] forState:UIControlStateHighlighted];
    [button setBackgroundImage:[UIImage imageNamed:@"mine_grayButtonBG"] forState:UIControlStateDisabled];
    [button addTarget:self action:@selector(buttonClicked) forControlEvents:UIControlEventTouchUpInside];
    
    _statusLabel  = [UILabel new];
    [bottomView addSubview:_statusLabel];
    [_statusLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(bottomView.centerY).with.offset(0);
        make.right.mas_equalTo(button.left).with.offset(GET_SCAlE_LENGTH(-10));
    }];
    _statusLabel.textColor = UIColorFromRGB(REDFONTCOLOR);
    _statusLabel.font = [UIFont systemFontOfSize:SMALLFONTSIZE];
    _statusLabel.text = @"未支付";
    
}

- (void)buttonClicked
{
    if (_callBackblock) {
        _callBackblock();
    }
}

#pragma mark - 外部方法

-(void)setCellTypeWithOrderType:(OrderType)type
{
    _currentOrderType = type;
    
    if (type == kOrderTypeHotelSupplies) {
        _orderDays.hidden = YES;
        _beginDateLabel.hidden = YES;
        _endDateLabel.hidden = YES;
        _codeTitleLabel.hidden = YES;
        _confirmCodeLabel.hidden = YES;
    }
}

-(void)callBackWithBlock:(OrderCellCallBackBlock)block
{
    _callBackblock = block;
}

-(void)setCellWithModel:(Products *)model OrderModel:(Orders *)order
{
    _confirmCodeLabel.hidden = YES;
    _codeTitleLabel.hidden = YES;
    
    [_headImageView sd_setImageWithURL:[NSURL URLWithString:model.logo] placeholderImage:[UIImage imageNamed:@"headimage"]];
    _titleLabel.text = model.title;
    _orderDays.text = [NSString stringWithFormat:@"共%ld晚",[model.buycount integerValue]];
    _beginDateLabel.text = [NSString stringWithFormat:@"入店：%@",model.indate];
    _endDateLabel.text = [NSString stringWithFormat:@"离店：%@",model.outdate];
    _numberLabel.text = [NSString stringWithFormat:@"数量：%ld",[model.buycount integerValue]];
    _priceLabel.text = [NSString stringWithFormat:@"%.2f",[model.price floatValue]/100];
    
    Coupon * couponModel = [Coupon new];
    
    if (model.coupons.count > 0) {
        NSInteger index = [self findIndex:model.coupons];
        couponModel = model.coupons[index];
        _confirmCodeLabel.text = couponModel.couponcode;
    }
    
    UIButton * button = [self viewWithTag:250];
    
    OrderStatusType type = [order.status integerValue];
    
    if (_currentOrderType == kOrderTypeHotelSupplies) {
        
        switch (type) {
                
            case kOrderStatusAll:
                
                break;
                
            case kOrderStatusWaitForPay: {
                _statusLabel.text = @"待付款";
                [button setTitle:@"去支付" forState:UIControlStateNormal];
                button.hidden = NO;
                button.enabled = YES;
                break;
            }
            case kOrderStatusWaitForSendConsignment: {
                _statusLabel.text = @"待发货";
                button.hidden = YES;
                button.enabled = YES;
                break;
            }
            case kOrderStatusWaitForReceiveProduct: {
                _statusLabel.text = @"待收货";
                [button setTitle:@"确认收货并评价" forState:UIControlStateNormal];
                button.hidden = NO;
                button.enabled = YES;
                break;
            }
            case kOrderStatusWaitForGiveComment: {
                _statusLabel.text = @"待评价";
                [button setTitle:@"去评价" forState:UIControlStateNormal];
                button.enabled = YES;
                button.hidden = NO;
                break;
            }
            case kOrderStatusAlreadyComment: {
                _statusLabel.text = @"已付款";
                [button setTitle:@"已评价" forState:UIControlStateDisabled];
                button.enabled = NO;
                button.hidden = NO;
                break;
            }
            case kOrderStatusAlreadyPayed:{
            
                break;
            }
        }
    }
    //  酒店
    else
    {
        
        switch (type) {
            case kOrderStatusAll:{
                
                
                break;
            }
            case kOrderStatusWaitForPay: {
                _statusLabel.text = @"待付款";
                _codeTitleLabel.hidden = YES;
                _confirmCodeLabel.text = couponModel.couponcode;
                [button setTitle:@"支付" forState:UIControlStateNormal];
                button.enabled = YES;
                break;
            }
            case kOrderStatusWaitForSendConsignment: {
                _statusLabel.text = @"已付款";
                _codeTitleLabel.hidden = NO;
                _confirmCodeLabel.hidden = NO;
                button.enabled = YES;
                break;
            }
            case kOrderStatusWaitForReceiveProduct: {
                _statusLabel.text = @"未消费";
                _codeTitleLabel.hidden = NO;
                _confirmCodeLabel.hidden = NO;
                [button setTitle:@"马上消费" forState:UIControlStateNormal];
                button.enabled = YES;
                break;
            }
            case kOrderStatusWaitForGiveComment: {
                _statusLabel.text = @"已付款";
                [button setTitle:@"去评价" forState:UIControlStateNormal];
                _codeTitleLabel.hidden = NO;
                _confirmCodeLabel.hidden = NO;
                button.enabled = YES;
                break;
            }
            case kOrderStatusAlreadyComment: {
                _statusLabel.text = @"已消费";
                _codeTitleLabel.hidden = NO;
                _confirmCodeLabel.hidden = NO;
                [button setTitle:@"已评价" forState:UIControlStateDisabled];
                button.enabled = NO;
                break;
            }
            case kOrderStatusAlreadyPayed:{
                _statusLabel.text = @"已支付";
                _confirmCodeLabel.text = couponModel.couponcode;
                _codeTitleLabel.hidden = NO;
                _confirmCodeLabel.hidden = NO;
                break;
            }
        }
    }
    
    if (_currentOrderType == kOrderTypeReservation) {
        _confirmCodeLabel.hidden = NO;
    }else{
        _confirmCodeLabel.hidden = YES;
    }
}

/**
 *  查找正确数据的下标
 *
 *  @param dictionary 消费券数组
 *
 *  @return
 */
- (NSInteger)findIndex:(NSArray *)dictionary
{
    __block NSInteger index = 0;
    
    if (dictionary.count == 2) {
        [dictionary enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if ([obj isKindOfClass:[Coupon class]]) {

                Coupon * model = (Coupon *)obj;

                if ([model.couponcode integerValue] == 0) {
                    
                    index = idx;
                    *stop = YES;
                }
            }
        }];
    }
    
    return index;
}

@end
