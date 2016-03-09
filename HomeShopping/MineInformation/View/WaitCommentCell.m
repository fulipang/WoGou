//
//  WaitCommentCell.m
//  HomeShopping
//
//  Created by sooncong on 16/1/10.
//  Copyright © 2016年 Administrator. All rights reserved.
//  待评价cell

#import "WaitCommentCell.h"

@implementation WaitCommentCell
{
    WaitCommentBlock _block;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        [self loadCustomView];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
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
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH - GET_SCAlE_LENGTH(15), 0.5));
    }];
    line.backgroundColor = UIColorFromRGB(LINECOLOR);
    
    _headImageView = [UIImageView new];
    _headImageView.image = [UIImage imageNamed:@"headimage"];
    [self addSubview:_headImageView];
    [_headImageView makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.top).with.offset(GET_SCAlE_HEIGHT(10));
        make.left.mas_equalTo(self.left).with.offset(GET_SCAlE_LENGTH(15));
        make.size.mas_equalTo(CGSizeMake(GET_SCAlE_LENGTH(100), GET_SCAlE_HEIGHT(75)));
    }];
    
    _titleLabel  = [UILabel new];
    [self addSubview:_titleLabel];
    [_titleLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_headImageView.top).with.offset(GET_SCAlE_HEIGHT(5));
        make.left.mas_equalTo(_headImageView.right).with.offset(GET_SCAlE_LENGTH(10));
        make.right.mas_equalTo(self.right).with.offset(GET_SCAlE_LENGTH(-10));
    }];
    _titleLabel.textColor = UIColorFromRGB(BLACKFONTCOLOR);
    _titleLabel.font = [UIFont systemFontOfSize:TITLENAMEFONTSIZE];
    _titleLabel.text = @"天上人间夜总会欢迎你再次光临";
    
    UILabel * numberTitleLabel  = [UILabel new];
    [self addSubview:numberTitleLabel];
    [numberTitleLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_titleLabel.left).with.offset(0);
        make.top.mas_equalTo(_titleLabel.bottom).with.offset(GET_SCAlE_HEIGHT(5));
    }];
    numberTitleLabel.textColor = UIColorFromRGB(GRAYFONTCOLOR);
    numberTitleLabel.font = [UIFont systemFontOfSize:SMALLFONTSIZE];
    numberTitleLabel.text = @"数量：";
    
    UILabel * priceTitleLabel  = [UILabel new];
    [self addSubview:priceTitleLabel];
    [priceTitleLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_titleLabel.left).with.offset(0);
        make.top.mas_equalTo(numberTitleLabel.bottom).with.offset(GET_SCAlE_HEIGHT(5));
    }];
    priceTitleLabel.textColor = UIColorFromRGB(GRAYFONTCOLOR);
    priceTitleLabel.font = [UIFont systemFontOfSize:SMALLFONTSIZE];
    priceTitleLabel.text = @"价格：";
    
    _numberLabel  = [UILabel new];
    [self addSubview:_numberLabel];
    [_numberLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(numberTitleLabel.centerY).with.offset(0);
        make.left.mas_equalTo(numberTitleLabel.right).with.offset(0);
    }];
    _numberLabel.textColor = UIColorFromRGB(GRAYFONTCOLOR);
    _numberLabel.font = [UIFont systemFontOfSize:SMALLFONTSIZE];
    _numberLabel.text = @"2";
    
    _priceLabel  = [UILabel new];
    [self addSubview:_priceLabel];
    [_priceLabel makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(priceTitleLabel.bottom).with.offset(0);
        make.left.mas_equalTo(priceTitleLabel.right).with.offset(0);
    }];
    _priceLabel.textColor = UIColorFromRGB(REDFONTCOLOR);
    _priceLabel.font = [UIFont systemFontOfSize:NORMALFONTSIZE];
    _priceLabel.text = @"2000";
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:button];
    [button makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.bottom).with.offset(GET_SCAlE_HEIGHT(-10));
        make.right.mas_equalTo(self.right).with.offset(GET_SCAlE_HEIGHT(-15));
        make.size.mas_equalTo(CGSizeMake(GET_SCAlE_LENGTH(60), GET_SCAlE_HEIGHT(21)));
    }];
    [button setTitle:@"去评价" forState:UIControlStateNormal];
    [button.titleLabel setFont:[UIFont systemFontOfSize:NORMALFONTSIZE]];
    [button setTitleColor:UIColorFromRGB(WHITECOLOR) forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"mine_toCommentButtonBG"] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"mine_toCommentButtonBG"] forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(buttonClicked) forControlEvents:UIControlEventTouchUpInside];
    
}

#pragma mark - 事件

-(void)buttonClicked
{
    if (_block) {
        _block();
    }
}

-(void)toCommentButtonClicked:(WaitCommentBlock)block
{
    _block = block;
}

@end
