//
//  HotelProductInfoCell.m
//  HomeShopping
//
//  Created by sooncong on 16/1/14.
//  Copyright © 2016年 Administrator. All rights reserved.
//

#import "HotelProductInfoCell.h"

@implementation HotelProductInfoCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self loadCustomView];
    }
    
    return self;
}

- (void)loadCustomView
{
    _TitleLabel = [UILabel new];
    [self addSubview:_TitleLabel];
    [_TitleLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).with.offset(GET_SCAlE_HEIGHT(10));
        make.left.mas_equalTo(self.left).with.offset(GET_SCAlE_LENGTH(10));
    }];
    _TitleLabel.textColor = UIColorFromRGB(BLACKFONTCOLOR);
    _TitleLabel.font = [UIFont systemFontOfSize:16];
    
    UILabel * memberPriceLabel  = [UILabel new];
    [self addSubview:memberPriceLabel];
    [memberPriceLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_TitleLabel.bottom).with.offset(GET_SCAlE_HEIGHT(10));
        make.left.mas_equalTo(_TitleLabel.left).with.offset(0);
    }];
    memberPriceLabel.textColor = UIColorFromRGB(GRAYFONTCOLOR);
    memberPriceLabel.font = [UIFont systemFontOfSize:NORMALFONTSIZE];
    memberPriceLabel.text = @"会员价:";
    
    UILabel * rebateLabel  = [UILabel new];
    [self addSubview:rebateLabel];
    [rebateLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(memberPriceLabel.bottom).with.offset(GET_SCAlE_HEIGHT(10));
        make.left.mas_equalTo(_TitleLabel.left).with.offset(0);
    }];
    rebateLabel.textColor = UIColorFromRGB(GRAYFONTCOLOR);
    rebateLabel.font = [UIFont systemFontOfSize:NORMALFONTSIZE];
    rebateLabel.text = @"消费返狗币:";
    
    UILabel * exchangePriceLabel  = [UILabel new];
    [self addSubview:exchangePriceLabel];
    [exchangePriceLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(memberPriceLabel.top).with.offset(0);
        make.left.mas_equalTo(memberPriceLabel.right).with.offset(GET_SCAlE_LENGTH(140));
    }];
    exchangePriceLabel.textColor = UIColorFromRGB(GRAYFONTCOLOR);
    exchangePriceLabel.font = [UIFont systemFontOfSize:NORMALFONTSIZE];
    exchangePriceLabel.text = @"狗币换购:";
    
    _salesVolumeLabel  = [UILabel new];
    [self addSubview:_salesVolumeLabel];
    [_salesVolumeLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(rebateLabel.top).with.offset(0);
        make.left.mas_equalTo(exchangePriceLabel.left).with.offset(0);
    }];
    _salesVolumeLabel.textColor = UIColorFromRGB(GRAYFONTCOLOR);
    _salesVolumeLabel.font = [UIFont systemFontOfSize:NORMALFONTSIZE];
    
    _memberPriceLabel  = [UILabel new];
    [self addSubview:_memberPriceLabel];
    [_memberPriceLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(memberPriceLabel.centerY).with.offset(0);
        make.left.mas_equalTo(memberPriceLabel.right).with.offset(GET_SCAlE_LENGTH(5));
    }];
    _memberPriceLabel.textColor = UIColorFromRGB(REDFONTCOLOR);
    _memberPriceLabel.font = [UIFont systemFontOfSize:18];
    
    _coinPriceLabel  = [UILabel new];
    [self addSubview:_coinPriceLabel];
    [_coinPriceLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(exchangePriceLabel.centerY).with.offset(0);
        make.left.mas_equalTo(exchangePriceLabel.right).with.offset(GET_SCAlE_LENGTH(5));
    }];
    _coinPriceLabel.textColor = UIColorFromRGB(REDFONTCOLOR);
    _coinPriceLabel.font = [UIFont systemFontOfSize:18];
    
    _coinReturnLabel  = [UILabel new];
    [self addSubview:_coinReturnLabel];
    [_coinReturnLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(rebateLabel.centerY).with.offset(0);
        make.left.mas_equalTo(rebateLabel.right).with.offset(GET_SCAlE_LENGTH(5));
    }];
    _coinReturnLabel.textColor = UIColorFromRGB(REDFONTCOLOR);
    _coinReturnLabel.font = [UIFont systemFontOfSize:NORMALFONTSIZE];

}

-(void)setCellWithModel:(ProductDetail *)model
{
    _memberPriceLabel.text = [NSString stringWithFormat:@"￥%.2f",[model.price floatValue]/100];
    _coinPriceLabel.text = [NSString stringWithFormat:@"%ld",[model.coinprice integerValue]];
    _coinReturnLabel.text = [NSString stringWithFormat:@"%ld",[model.coinreturn integerValue]];
    _TitleLabel.text = [NSString stringWithFormat:@"%@",model.title];
    _salesVolumeLabel.text = [NSString stringWithFormat:@"销量：%ld",[model.turnover integerValue]];
}

@end
