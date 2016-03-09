//
//  SCHomeNormalCell.m
//  HomeShopping
//
//  Created by sooncong on 15/12/10.
//  Copyright © 2015年 Administrator. All rights reserved.
//

#import "SCHomeNormalCell.h"
#import "UIImageView+WebCache.h"

#define SPACE 8

@implementation SCHomeNormalCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        [self createLine];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return self;
}

#pragma mark - 懒加载

/**
 *  图片视图懒get方法
 *
 *  @return
 */
-(UIImageView *)customHeadImageView
{
    if (_customHeadImageView == nil) {

        _customHeadImageView = [UIImageView new];
        _customHeadImageView.image = [UIImage imageNamed:@"headimage"];
        [self addSubview:_customHeadImageView];
        
        [_customHeadImageView makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.mas_top).with.offset(GET_SCAlE_HEIGHT(10));
            make.left.mas_equalTo(self.mas_left).with.offset(GET_SCAlE_LENGTH(12));
            make.size.mas_equalTo(CGSizeMake(GET_SCAlE_LENGTH(100), GET_SCAlE_HEIGHT(75)));
        }];
        
        
    }
    
    return _customHeadImageView;
}

/**
 *  标题标签get方法
 *
 *  @return
 */
-(UILabel *)customTitleLabel
{
    if (_customTitleLabel == nil) {
        
        _customTitleLabel = [UILabel new];
        [self addSubview:_customTitleLabel];
        
        [_customTitleLabel makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.customHeadImageView.mas_top);
            make.left.mas_equalTo(self.customHeadImageView.mas_right).with.offset(GET_SCAlE_LENGTH(10));
            make.right.mas_equalTo(self.mas_right).with.offset(GET_SCAlE_LENGTH(-5));
        }];
        
        [_customTitleLabel sizeToFit];
        _customTitleLabel.font = [UIFont systemFontOfSize:14];
        _customTitleLabel.textColor = UIColorFromRGB(BLACKFONTCOLOR);
    }
    return _customTitleLabel;
}

/**
 *  评分标签 get方法
 *
 *  @return
 */
-(UILabel *)customScoreLabel
{
    if (_customScoreLabel == nil) {
        
         _customScoreLabel = [UILabel new];
        [self addSubview:_customScoreLabel];
        [_customScoreLabel makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.rebateShopCurrencyLabel.mas_bottom).with.offset(GET_SCAlE_HEIGHT(SPACE));
            make.left.mas_equalTo(self.customTitleLabel.mas_left);
        }];
        _customScoreLabel.font = [UIFont systemFontOfSize:CELLSMALLFONTSIZE];
        _customScoreLabel.textColor = UIColorFromRGB(GRAYFONTCOLOR);
    }
    
    return _customScoreLabel;
}

/**
 *  星级标签 get 方法
 *
 *  @return
 */
-(UILabel *)customStarLevelLabel
{
    if (_customStarLevelLabel == nil) {
        
        _customStarLevelLabel = [UILabel new];
        [self addSubview:_customStarLevelLabel];
        [_customStarLevelLabel makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.customHeadImageView.bottom).with.offset(SPACE);
            make.left.and.right.mas_equalTo(self.customHeadImageView);
        }];
        _customStarLevelLabel.font = [UIFont systemFontOfSize:SMALLFONTSIZE];
        _customStarLevelLabel.textColor = UIColorFromRGB(GRAYFONTCOLOR);
        _customStarLevelLabel.layer.borderColor = [UIColorFromRGB(LIGHTBLUECOLOR) CGColor];
        _customStarLevelLabel.textAlignment = NSTextAlignmentCenter;

        _customStarLevelLabel.layer.borderWidth = 0.8;
        _customStarLevelLabel.layer.cornerRadius = 2;
        _customStarLevelLabel.clipsToBounds = YES;
    }
    
    return _customStarLevelLabel;
}


/**
 *  预订标签 get方法
 *
 *  @return
 */
-(UILabel *)customReservationLabel
{
    if (_customReservationLabel == nil) {
        
        _customReservationLabel = [UILabel new];
        [self addSubview:_customReservationLabel];
        [_customReservationLabel makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.customStarLevelLabel.bottom).with.offset(SPACE);
            make.left.and.right.mas_equalTo(self.customStarLevelLabel);
        }];
        _customReservationLabel.font = [UIFont systemFontOfSize:SMALLFONTSIZE];
        _customReservationLabel.textColor = UIColorFromRGB(GRAYFONTCOLOR);
        _customReservationLabel.layer.borderColor = [UIColorFromRGB(LIGHTBLUECOLOR) CGColor];
        _customReservationLabel.textAlignment = NSTextAlignmentCenter;
        
        _customReservationLabel.layer.borderWidth = 0.8;
        _customReservationLabel.layer.cornerRadius = 2;
        _customReservationLabel.clipsToBounds = YES;
    }
    
    return _customReservationLabel;
}

/**
 *  价格标签 get方法
 *
 *  @return
 */
-(UILabel *)customPriceLabel
{
    if (_customPriceLabel == nil) {

        _customPriceLabel = [UILabel new];
        
        [self configPricesLabelWithLabel:_customPriceLabel];
    }
    
    return _customPriceLabel;
}

/**
 *  距离标签 get方法
 *
 *  @return
 */
-(UILabel *)customDistanceLabel
{
    if (_customDistanceLabel == nil) {
        
        _customDistanceLabel = [UILabel new];
        [self addSubview:_customDistanceLabel];
        [_customDistanceLabel makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self.customReservationLabel.mas_bottom);
            make.right.mas_equalTo(self.mas_right).with.offset(-10);
        }];
        
        _customDistanceLabel.textColor = UIColorFromRGB(GRAYFONTCOLOR);
        _customDistanceLabel.font = [UIFont systemFontOfSize:CELLSMALLFONTSIZE];
    }
    
    return _customDistanceLabel;
}

- (UILabel *)turnOverLabel
{
    if (_turnOverLabel == nil) {
        
        _turnOverLabel = [UILabel new];
        [self addSubview:_turnOverLabel];
        [_turnOverLabel makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.customScoreLabel.centerY);
            make.right.mas_equalTo(self.customDistanceLabel.mas_right);
        }];
        
        _turnOverLabel.textColor = UIColorFromRGB(GRAYFONTCOLOR);
        _turnOverLabel.font = [UIFont systemFontOfSize:CELLSMALLFONTSIZE];
    }
    
    return _turnOverLabel;
}

-(UILabel *)shopCurrencyPriceLabel
{
    if (_shopCurrencyPriceLabel == nil) {
        
        _shopCurrencyPriceLabel = [UILabel new];
        
        [self configPricesLabelWithLabel:_shopCurrencyPriceLabel];
    }
    
    return _shopCurrencyPriceLabel;
}

-(UILabel *)rebateShopCurrencyLabel
{
    if (_rebateShopCurrencyLabel == nil) {
        
        _rebateShopCurrencyLabel = [UILabel new];
        
        [self configPricesLabelWithLabel:_rebateShopCurrencyLabel];
    }
    
    return _rebateShopCurrencyLabel;
}

#pragma mark - 公共部分视图

- (void)createLine
{
    UILabel * line = [UILabel new];
    [self addSubview:line];
    [line makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.and.centerX.mas_equalTo(self);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 1));
    }];
    line.backgroundColor = UIColorFromRGB(GRAYBGCOLOR);
    
    /**
     *  初始化 和位置
     */
    UILabel * memberLabel = [UILabel new];
    [self addSubview:memberLabel];
    [memberLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.customTitleLabel.mas_bottom).with.offset(GET_SCAlE_HEIGHT(SPACE));
        make.left.mas_equalTo(self.customTitleLabel.mas_left);
    }];
    
    //换购狗币标签
    UILabel * shoppingCurrencyLabel = [UILabel new];
    [self addSubview:shoppingCurrencyLabel];
    [shoppingCurrencyLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.customPriceLabel.mas_bottom).with.offset(GET_SCAlE_HEIGHT(SPACE));
        make.left.mas_equalTo(memberLabel.mas_left);
    }];
    
    //返狗币标签
    UILabel * rebateSCLabel = [UILabel new];
    [self addSubview:rebateSCLabel];
    [rebateSCLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(shoppingCurrencyLabel.mas_bottom).with.offset(GET_SCAlE_HEIGHT(SPACE));
        make.left.mas_equalTo(shoppingCurrencyLabel.mas_left);
    }];
    
    
    /**
     *  更新显示标签位置
     */
    [self.customPriceLabel updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(memberLabel.mas_right);
        make.bottom.mas_equalTo(memberLabel.mas_bottom);
    }];
    
    [self.shopCurrencyPriceLabel updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(shoppingCurrencyLabel.mas_right);
        make.bottom.mas_equalTo(shoppingCurrencyLabel.mas_bottom);
    }];
    
    [self.rebateShopCurrencyLabel updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(rebateSCLabel.mas_right);
        make.bottom.mas_equalTo(rebateSCLabel.mas_bottom);
    }];
    
    
    /**
     *  配置标签内容
     */
    [self configLabelWithLabel:memberLabel text:@"会员价 ："];
    [self configLabelWithLabel:shoppingCurrencyLabel text:@"狗币换购 ："];
    [self configLabelWithLabel:rebateSCLabel text:@"消费返狗币 ："];
}

/**
 *  配置标签参数
 *
 *  @param label 需要配置的标签
 *  @param text  标签的文字
 */
- (void)configLabelWithLabel:(UILabel *)label text:(NSString *)text
{
    label.font = [UIFont systemFontOfSize:CELLSMALLFONTSIZE];
    label.text = text;
    label.textColor = UIColorFromRGB(LIGHTGRAYFONTCOLOR);
}

/**
 *  配置价格相关标签
 *
 *  @param label 需要配置的标签
 */
-(void)configPricesLabelWithLabel:(UILabel *)label
{
    [self addSubview:label];
    [label makeConstraints:^(MASConstraintMaker *make) {
        
    }];
    label.textColor = [UIColor redColor];
    label.font = [UIFont systemFontOfSize:12];
}

#pragma mark - 外部调用方法

/**
 *  配置cell参数
 *
 *  @param model 模型
 */
-(void)cellForRowWithModel:(HPPossibleLikeModel *)model
{
    self.customReservationLabel.hidden = YES;
    
    [self.customHeadImageView sd_setImageWithURL:[NSURL URLWithString:model.logo] placeholderImage:[UIImage imageNamed:@"headimage"]];
    self.customTitleLabel.text = model.title;
    self.customScoreLabel.text = [NSString stringWithFormat:@"评分%@分",model.score];
    self.customStarLevelLabel.text = model.starlevel;
    self.customPriceLabel.text = [NSString stringWithFormat:@"￥%@起",model.price];
    self.customDistanceLabel.text = [NSString stringWithFormat:@"距离：%@km",model.distance];
    self.shopCurrencyPriceLabel.text = [NSString stringWithFormat:@"￥%@起",model.coinprice];
    self.rebateShopCurrencyLabel.text = [NSString stringWithFormat:@"￥%@起",model.coinreturn];
    self.customReservationLabel.text = @"需预定";
    if ([model.isneedbook isEqualToString:@"是"] || [model.isneedbook integerValue] == 1) {
        self.customReservationLabel.hidden = NO;
    }
    self.turnOverLabel.text = [NSString stringWithFormat:@"销量：%@",model.turnover];

}

@end
