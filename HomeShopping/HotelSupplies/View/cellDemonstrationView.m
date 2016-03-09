//
//  cellDemonstrationView.m
//  HomeShopping
//
//  Created by sooncong on 16/1/1.
//  Copyright © 2016年 Administrator. All rights reserved.
//
///     cell 最上方展示视图

#import "cellDemonstrationView.h"

@implementation cellDemonstrationView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self setUpCustomViewWithFrame:frame];
    }
    
    return self;
}

- (void)setUpCustomViewWithFrame:(CGRect)frame
{
    _titleLabel  = [UILabel new];
    [self addSubview:_titleLabel];
    [_titleLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.centerY).with.offset(0);
        make.left.mas_equalTo(self.left).with.offset(GET_SCAlE_LENGTH(10));
    }];
    _titleLabel.textColor = UIColorFromRGB(BLACKFONTCOLOR);
    _titleLabel.font = [UIFont systemFontOfSize:14];
    _titleLabel.text = @"评分";
    
    _subLabel  = [UILabel new];
    [self addSubview:_subLabel];
    [_subLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.centerY).with.offset(0);
        make.left.mas_equalTo(_titleLabel.right).with.offset(3);
    }];
    _subLabel.textColor = UIColorFromRGB(REDFONTCOLOR);
    _subLabel.font = [UIFont systemFontOfSize:14];
    _subLabel.text = @"9.7";
    
    _symBolImageView = [UIImageView new];
    _symBolImageView.image = [UIImage imageNamed:@"arrow_right"];
    [self addSubview:_symBolImageView];
    [_symBolImageView makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.centerY);
        make.right.mas_equalTo(self.right).with.offset(GET_SCAlE_LENGTH(-15));
        make.size.mas_equalTo(CGSizeMake(_symBolImageView.image.size.width, _symBolImageView.image.size.height));
    }];
    
    _rightLabel  = [UILabel new];
    [self addSubview:_rightLabel];
    [_rightLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.centerY).with.offset(0);
        make.right.mas_equalTo(_symBolImageView.left).with.offset(GET_SCAlE_LENGTH(-10));
    }];
    _rightLabel.textColor = UIColorFromRGB(BLACKFONTCOLOR);
    _rightLabel.font = [UIFont systemFontOfSize:14];
    _rightLabel.text = @"深灰色(2.5L) 两件";
}

-(void)setViewWithTitle:(NSString *)title SubTitle:(NSString *)subtitle RightTitle:(NSString *)rightText SymbolImage:(UIImage *)image
{
    _titleLabel.text       = title;
    _subLabel.text         = subtitle;
    _rightLabel.text       = rightText;
    _symBolImageView.image = image;
    
    [_symBolImageView updateConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(_symBolImageView.image.size.width, _symBolImageView.image.size.height));
    }];
}

@end
