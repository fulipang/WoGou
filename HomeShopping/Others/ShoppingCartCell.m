//
//  ShoppingCartCell.m
//  HomeShopping
//
//  Created by sooncong on 16/1/11.
//  Copyright © 2016年 Administrator. All rights reserved.
//

#import "ShoppingCartCell.h"

#define SPACE 8

@implementation ShoppingCartCell
{
    PublicCollectionCallBackBlock _callBackBlock;
    ShoppingCarProduct *_cardProduct;
    NSInteger _count;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        _count = 1;
        [self SetUpCustomTitleLabel];
        
        [self createLine];
        
        [self createMiddleView];
        
        [self createQuantityBaseView];
        
        [self createSelectionButton];
    }
    
    return self;
}


#pragma mark 配置数据

- (void)cellSetShopingCardProduct:(ShoppingCarProduct *)cardProduct {
    _cardProduct = cardProduct;
    
    self.customTitleLabel.text = cardProduct.title;
    self.customPriceLabel.text = cardProduct.price;
    [self.customHeadImageView sd_setImageWithURL:[NSURL URLWithString:cardProduct.logo]];
    self.beginDateLabel.text = cardProduct.indate;
    self.endDateLabel.text = cardProduct.outdate;
    self.shopCurrencyPriceLabel.text = cardProduct.coinprice;
    self.rebateShopCurrencyLabel.text = cardProduct.coinreturn;
    self.numberLabel.text = cardProduct.buycount;
    _count = cardProduct.buycount.intValue;
    self.totalDaysLabel.text = [NSString stringWithFormat:@"共%ld晚",(long)[self days]];
}

- (NSInteger)days {
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = @"yyyy-MM-dd";
    NSDate *beginDate = [formatter dateFromString:_cardProduct.indate];
    NSDate *endDate = [formatter dateFromString:_cardProduct.outdate];
    NSTimeInterval interval = [endDate timeIntervalSinceDate:beginDate];
    NSInteger days = interval / (24 * 3600);
    (days <= 0)?(days = 1):(days = days);
    self.totalDays = days;
    return days;
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
            make.top.mas_equalTo(self.top).with.offset(GET_SCAlE_LENGTH(10));
            make.left.mas_equalTo(self.left).with.offset(GET_SCAlE_HEIGHT(75/2.0));
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
        make.left.mas_equalTo(self.customHeadImageView.right).with.offset(GET_SCAlE_LENGTH(10));
    }];
    
    _customTitleLabel.font = [UIFont systemFontOfSize:TITLENAMEFONTSIZE];
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

- (void)createSelectionButton
{
    _selectionButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:_selectionButton];
    [_selectionButton makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_customHeadImageView.centerY);
        make.centerX.mas_equalTo(_customHeadImageView.left).with.offset(GET_SCAlE_LENGTH(-75/4.0));
        make.size.mas_equalTo(CGSizeMake(GET_SCAlE_LENGTH(15), GET_SCAlE_LENGTH(15)));
    }];
//    _selectionButton.backgroundColor = [UIColor orangeColor];
    [_selectionButton setBackgroundImage:[UIImage imageNamed:@"selected_r"] forState:UIControlStateNormal];
    [_selectionButton setBackgroundImage:[UIImage imageNamed:@"selected_rd"] forState:UIControlStateSelected];
    [_selectionButton addTarget:self action:@selector(bottomButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
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
    
    //换购狗币标签
    UILabel * shoppingCurrencyLabel = [UILabel new];
    [self addSubview:shoppingCurrencyLabel];
    
    //返狗币标签
    UILabel * rebateSCLabel = [UILabel new];
    [self addSubview:rebateSCLabel];
    
    [memberLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.customTitleLabel.mas_bottom).with.offset(GET_SCAlE_HEIGHT(SPACE));
        make.left.mas_equalTo(self.customTitleLabel.mas_left);
        make.bottom.mas_equalTo(shoppingCurrencyLabel.top);
        make.height.mas_equalTo(shoppingCurrencyLabel.height);
    }];
    

    [shoppingCurrencyLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(memberLabel.mas_bottom);
        make.left.mas_equalTo(memberLabel.mas_left);
        make.height.mas_equalTo(rebateSCLabel.height);
    }];
    
    [rebateSCLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(shoppingCurrencyLabel.mas_bottom);
        make.left.mas_equalTo(shoppingCurrencyLabel.mas_left);
        make.height.mas_equalTo(memberLabel.height);
        make.bottom.mas_equalTo(_customHeadImageView.bottom);
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

- (void)createMiddleView
{
    _beginDateLabel = [UILabel new];
    [self addSubview:_beginDateLabel];
    [_beginDateLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_customHeadImageView.bottom).with.offset(GET_SCAlE_HEIGHT(5));
        make.left.mas_equalTo(_customHeadImageView.left).with.offset(0);
    }];
    _beginDateLabel.textColor = UIColorFromRGB(GRAYFONTCOLOR);
    _beginDateLabel.font = [UIFont systemFontOfSize:CELLSMALLFONTSIZE];
    _beginDateLabel.text = @"入住：2015/12/24";
    
    _endDateLabel  = [UILabel new];
    [self addSubview:_endDateLabel];
    [_endDateLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_beginDateLabel.centerY).with.offset(0);
        make.left.mas_equalTo(_beginDateLabel.right).with.offset(GET_SCAlE_LENGTH(15));
    }];
    _endDateLabel.textColor = UIColorFromRGB(GRAYFONTCOLOR);
    _endDateLabel.font = [UIFont systemFontOfSize:CELLSMALLFONTSIZE];
    _endDateLabel.text = @"离店：2015/12/25";
    
    _totalDaysLabel  = [UILabel new];
    [self addSubview:_totalDaysLabel];
    [_totalDaysLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_beginDateLabel.centerY).with.offset(0);
        make.right.mas_equalTo(self.right).with.offset(GET_SCAlE_LENGTH(-15));
    }];
    _totalDaysLabel.textColor = UIColorFromRGB(GRAYFONTCOLOR);
    _totalDaysLabel.font = [UIFont systemFontOfSize:CELLSMALLFONTSIZE];
    _totalDaysLabel.text = [NSString stringWithFormat:@"共%ld晚",(long)[self days]];
    
}

#pragma mark - 事件

/**
 *  底部按钮点击方法
 *
 *  @param sender 当前按钮
 */
- (void)bottomButtonClicked:(UIButton *)sender
{
    
    sender.selected = !sender.selected;
    !self.selectedButtonCallback ?: self.selectedButtonCallback(sender.selected);

    PublicCollectionViewClickType type = sender.tag % 10;
    if (_callBackBlock) {
        _callBackBlock(type);
    }
}

- (void)createQuantityBaseView
{
    //数量部分
    _quantityBaseView = [UIView new];
    [self addSubview:_quantityBaseView];
    [_quantityBaseView makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_beginDateLabel.bottom).with.offset(GET_SCAlE_HEIGHT(0));
        make.centerX.mas_equalTo(self.centerX);
        make.size.mas_equalTo(CGSizeMake(GET_SCAlE_LENGTH(290), GET_SCAlE_HEIGHT(50)));
    }];
    
    UILabel * quantityTitleLabel  = [UILabel new];
    [_quantityBaseView addSubview:quantityTitleLabel];
    [quantityTitleLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_quantityBaseView.centerY).with.offset(0);
        make.left.mas_equalTo(_quantityBaseView.left).with.offset(0);
    }];
    quantityTitleLabel.textColor = UIColorFromRGB(BLACKFONTCOLOR);
    quantityTitleLabel.font = [UIFont systemFontOfSize:TITLENAMEFONTSIZE];
    quantityTitleLabel.text = @"购买数量";
    
    UIButton * rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_quantityBaseView addSubview:rightButton];
    [rightButton makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_quantityBaseView.centerY);
        make.right.mas_equalTo(_quantityBaseView.right);
        make.size.mas_equalTo(CGSizeMake(GET_SCAlE_LENGTH(30), GET_SCAlE_LENGTH(30)));
    }];
    rightButton.backgroundColor = [UIColor clearColor];
    [self setOperationButton:rightButton WithImage:[UIImage imageNamed:@"selected_plus"]PressImage:[UIImage imageNamed:@"selected_plus_p"]];
    rightButton.tag = 12;
    [rightButton addTarget:self action:@selector(operationButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    _numberLabel  = [UILabel new];
    [_quantityBaseView addSubview:_numberLabel];
    [_numberLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_quantityBaseView.centerY).with.offset(0);
        make.right.mas_equalTo(rightButton.left).with.offset(-2);
        make.width.mas_equalTo(@(GET_SCAlE_LENGTH(40)));
    }];
    _numberLabel.textColor = UIColorFromRGB(BLACKFONTCOLOR);
    _numberLabel.font = [UIFont systemFontOfSize:TITLENAMEFONTSIZE];
    _numberLabel.text = @(_count).stringValue;
    _numberLabel.textAlignment = NSTextAlignmentCenter;
    
    UIButton * leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_quantityBaseView addSubview:leftButton];
    [leftButton makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_quantityBaseView.centerY);
        make.right.mas_equalTo(_numberLabel.left).with.offset(-2);
        make.size.mas_equalTo(CGSizeMake(GET_SCAlE_LENGTH(30), GET_SCAlE_LENGTH(30)));
    }];
    leftButton.backgroundColor = [UIColor clearColor];
    [self setOperationButton:leftButton WithImage:[UIImage imageNamed:@"selected_div"]PressImage:[UIImage imageNamed:@"selected_div_p"]];
    leftButton.tag = 11;
    [leftButton addTarget:self action:@selector(operationButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
}

/**
 *  设置按钮图片
 *
 *  @param button 当前按钮
 *  @param image  图像
 */
- (void)setOperationButton:(UIButton *)button WithImage:(UIImage *)image PressImage:(UIImage *)pressImage
{
    [button setImage:image forState:UIControlStateNormal];
    [button setImage:pressImage forState:UIControlStateHighlighted];
}

#pragma mark - 外部调用方法

/**
 *  配置cell参数
 *
 *  @param model 模型
 */
//-(void)cellForRowWithModel:(HSProduct *)model
//{
//    
//    [self.customHeadImageView sd_setImageWithURL:[NSURL URLWithString:model.logo] placeholderImage:[UIImage imageNamed:@"bird"]];
//    
//    self.customTitleLabel.text = model.title;
//    
//    self.customPriceLabel.text = [NSString stringWithFormat:@"￥%@起",model.price];
//    self.shopCurrencyPriceLabel.text = [NSString stringWithFormat:@"￥%@起",model.coinprice];
//    self.rebateShopCurrencyLabel.text = [NSString stringWithFormat:@"￥%@起",model.coinreturn];
//    
//    CGFloat titleWidth = [self sizeForText:model.title WithMaxSize:CGSizeMake(1000, 14) AndWithFontSize:14].width;
//    [_customTitleLabel updateConstraints:^(MASConstraintMaker *make) {
//        
//        if (titleWidth >= 170) {
//            
//            make.size.mas_equalTo(CGSizeMake(170, 14));
//        }
//        else
//        {
//            make.size.mas_equalTo(CGSizeMake(titleWidth, 14));
//        }
//    }];
//}

-(void)callBackWithBlock:(PublicCollectionCallBackBlock)callBackBlock
{
    _callBackBlock = callBackBlock;
}

/**
 *  数量操作按钮点击事件
 *
 *  @param sender
 */
- (void)operationButtonClicked:(UIButton *)sender
{
    switch (sender.tag % 10) {
        case 2:
            _count++;
            _numberLabel.text = [NSString stringWithFormat:@"%ld",_count];
            break;
            
        case 1:
            if (_count > 1) {
                _count--;
                _numberLabel.text = [NSString stringWithFormat:@"%ld",_count];
            }
            break;
            
        default:
            break;
    }
    
    !self.selectedCellCallback ?: self.selectedCellCallback(_selectionButton.selected);

    
//    [_callBackDictionary setObject:[NSString stringWithFormat:@"%ld",_count] forKey:@"number"];
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
