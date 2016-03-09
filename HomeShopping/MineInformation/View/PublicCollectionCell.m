//
//  PublicCollectionCell.m
//  HomeShopping
//
//  Created by sooncong on 16/1/9.
//  Copyright © 2016年 Administrator. All rights reserved.
//

#import "PublicCollectionCell.h"
#import "UIImageView+WebCache.h"
#define SPACE 8

@implementation PublicCollectionCell
{
    PublicCollectionCallBackBlock _callBackBlock;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self SetUpCustomTitleLabel];
        
        [self createLine];
        
        [self createButton];
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
            make.top.mas_equalTo(self.mas_top).with.offset(10);
            make.left.mas_equalTo(self.mas_left).with.offset(12);
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
-(void)SetUpCustomTitleLabel
{
    _customTitleLabel = [UILabel new];
    [self addSubview:_customTitleLabel];
    
    [_customTitleLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.customHeadImageView.mas_top);
        make.left.mas_equalTo(self.left).with.offset(GET_SCAlE_LENGTH(120));
    }];
    
    _customTitleLabel.font = [UIFont systemFontOfSize:14];
    _customTitleLabel.textColor = UIColorFromRGB(BLACKFONTCOLOR);
    _customTitleLabel.text = @"天上人间";
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
    
    //初始化 和位置
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
    
    
     //更新显示标签位置
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
    
    
    //配置标签内容
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

/**
 *  创建按钮方法
 */
- (void)createButton
{
    UIButton * checkButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.contentView addSubview:checkButton];
    [checkButton makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.contentView.bottom).with.offset(GET_SCAlE_HEIGHT(-10));
        make.right.mas_equalTo(self.contentView.right).with.offset(GET_SCAlE_LENGTH(-25/2.0));
        make.size.mas_equalTo(CGSizeMake(GET_SCAlE_LENGTH(94), GET_SCAlE_HEIGHT(21)));
    }];
    [checkButton setTitle:@"查看" forState:UIControlStateNormal];
    [checkButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [checkButton setTitleColor:UIColorFromRGB(WHITECOLOR) forState:UIControlStateNormal];
    [checkButton setBackgroundImage:[UIImage imageNamed:@"mine_confrimReceiveandCommentButtonBG"] forState:UIControlStateNormal];
    [checkButton setBackgroundImage:[UIImage imageNamed:@"mine_confrimReceiveandCommentButtonBG"] forState:UIControlStateHighlighted];
    
    UIButton * deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.contentView addSubview:deleteButton];
    [deleteButton makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(checkButton.left).with.offset(GET_SCAlE_LENGTH(-15));
        make.centerY.mas_equalTo(checkButton.centerY);
        make.size.mas_equalTo(CGSizeMake(GET_SCAlE_LENGTH(94), GET_SCAlE_HEIGHT(21)));
    }];
    [deleteButton setTitle:@"删除" forState:UIControlStateNormal];
    [deleteButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [deleteButton setTitleColor:UIColorFromRGB(GRAYFONTCOLOR) forState:UIControlStateNormal];
    [deleteButton setBackgroundImage:[UIImage imageNamed:@"mine_grayButtonBG"] forState:UIControlStateNormal];
    [deleteButton setBackgroundImage:[UIImage imageNamed:@"mine_grayButtonBG"] forState:UIControlStateHighlighted];
    
    deleteButton.tag = 161;
    checkButton.tag  = 160;

    //添加事件
    [deleteButton addTarget:self action:@selector(bottomButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [checkButton addTarget:self action:@selector(bottomButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - 事件

/**
 *  底部按钮点击方法
 *
 *  @param sender 当前按钮
 */
- (void)bottomButtonClicked:(UIButton *)sender
{
    PublicCollectionViewClickType type = sender.tag % 10;
    if (_callBackBlock) {
        _callBackBlock(type);
    }
}

#pragma mark - 外部调用方法

/**
 *  配置cell参数
 *
 *  @param model 模型
 */
-(void)cellForRowWithModel:(HSProduct *)model
{
    
    [self.customHeadImageView sd_setImageWithURL:[NSURL URLWithString:model.logo] placeholderImage:[UIImage imageNamed:@"collection"]];
    
    self.customTitleLabel.text = model.title;
    
    self.customPriceLabel.text = [NSString stringWithFormat:@"￥%@起",model.price];
    self.shopCurrencyPriceLabel.text = [NSString stringWithFormat:@"￥%@起",model.coinprice];
    self.rebateShopCurrencyLabel.text = [NSString stringWithFormat:@"￥%@起",model.coinreturn];
    
    CGFloat titleWidth = [self sizeForText:model.title WithMaxSize:CGSizeMake(1000, 14) AndWithFontSize:14].width;
    [_customTitleLabel updateConstraints:^(MASConstraintMaker *make) {
        
        if (titleWidth >= GET_SCAlE_LENGTH(170)) {
            
            make.size.mas_equalTo(CGSizeMake(GET_SCAlE_LENGTH(170), 14));
        }
        else
        {
            make.size.mas_equalTo(CGSizeMake(titleWidth, 14));
        }
    }];
}

-(void)setCellWithSellerModel:(Sellers *)model
{
    [self.customHeadImageView sd_setImageWithURL:[NSURL URLWithString:model.sellerlogo] placeholderImage:[UIImage imageNamed:@"collection"]];
    
    self.customTitleLabel.text = model.sellertitle;
    
    self.customPriceLabel.text = [NSString stringWithFormat:@"￥%@起",model.price];
    self.shopCurrencyPriceLabel.text = [NSString stringWithFormat:@"￥%@起",model.coinprice];
    self.rebateShopCurrencyLabel.text = [NSString stringWithFormat:@"￥%@起",model.coinreturn];
    
    CGFloat titleWidth = [self sizeForText:model.sellertitle WithMaxSize:CGSizeMake(1000, 14) AndWithFontSize:14].width;
    [_customTitleLabel updateConstraints:^(MASConstraintMaker *make) {
        
        if (titleWidth >= GET_SCAlE_LENGTH(170)) {
            
            make.size.mas_equalTo(CGSizeMake(GET_SCAlE_LENGTH(170), 14));
        }
        else
        {
            make.size.mas_equalTo(CGSizeMake(titleWidth, 14));
        }
    }];
}

-(void)setCellWithHotelDetailModel:(HotelDetailModel *)model
{
    [self.customHeadImageView sd_setImageWithURL:[NSURL URLWithString:model.sellerlogo] placeholderImage:[UIImage imageNamed:@"collection"]];
    
    self.customTitleLabel.text = model.title;
    
    self.customPriceLabel.text = [NSString stringWithFormat:@"￥%@起",model.price];
    self.shopCurrencyPriceLabel.text = [NSString stringWithFormat:@"￥%@起",model.coinprice];
    self.rebateShopCurrencyLabel.text = [NSString stringWithFormat:@"￥%@起",model.coinreturn];
    
    CGFloat titleWidth = [self sizeForText:model.title WithMaxSize:CGSizeMake(1000, 14) AndWithFontSize:14].width;
    [_customTitleLabel updateConstraints:^(MASConstraintMaker *make) {
        
        if (titleWidth >= GET_SCAlE_LENGTH(170)) {
            
            make.size.mas_equalTo(CGSizeMake(GET_SCAlE_LENGTH(170), 14));
        }
        else
        {
            make.size.mas_equalTo(CGSizeMake(titleWidth, 14));
        }
    }];
}

-(void)setCellWithCollectionModel:(CollectionProduct *)model
{
    [self.customHeadImageView sd_setImageWithURL:[NSURL URLWithString:model.logo] placeholderImage:[UIImage imageNamed:@"collection"]];
    
    self.customTitleLabel.text = model.title;
    
    self.customPriceLabel.text = [NSString stringWithFormat:@"￥%.2f起",[model.price floatValue]/100];
    self.shopCurrencyPriceLabel.text = [NSString stringWithFormat:@"￥%@起",model.coinprice];
    self.rebateShopCurrencyLabel.text = [NSString stringWithFormat:@"￥%@起",model.coinreturn];
    
    CGFloat titleWidth = [self sizeForText:model.title WithMaxSize:CGSizeMake(1000, 14) AndWithFontSize:14].width;
    [_customTitleLabel updateConstraints:^(MASConstraintMaker *make) {
        
        if (titleWidth >= GET_SCAlE_LENGTH(170)) {
            
            make.size.mas_equalTo(CGSizeMake(GET_SCAlE_LENGTH(170), 14));
        }
        else
        {
            make.size.mas_equalTo(CGSizeMake(titleWidth, 14));
        }
    }];
}

-(void)callBackWithBlock:(PublicCollectionCallBackBlock)callBackBlock
{
    _callBackBlock = callBackBlock;
}

#pragma mark - 公用方法

/**
 *  求label大小
 *
 *  @param text     内容
 *  @param maxSize  最大值
 *  @param fontSize 字体大小
 *
 *  @return 需要的大小
 */
- (CGSize) sizeForText:(NSString *)text WithMaxSize:(CGSize)maxSize AndWithFontSize:(CGFloat)fontSize
{
    CGRect rect = [text boundingRectWithSize: maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize: fontSize]} context:nil];
    
    return rect.size;
}

@end
