//
//  DayToDayTableViewCell.m
//  HomeShopping
//
//  Created by pfl on 16/1/18.
//  Copyright © 2016年 Administrator. All rights reserved.
//

#import "DayToDayTableViewCell.h"
#import "cellDemonstrationView.h"
#import "UIImageView+WebCache.h"

#define SPACE GET_SCAlE_HEIGHT(8)


@implementation DayToDayTableViewCell
{
    //是否需要显示特惠
    BOOL isNeedSpecail;
    UIImageView * _calender;
    UILabel *_orderNumLabel;
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self SetUpCustomTitleLabel];
        
        [self createLine];

        [self setUpSpecialImage];
        
        [self setupHotelNumber];

    }
    
    return self;
}

- (void)setMonthDayArr:(NSArray *)MonthDayArr {
    _MonthDayArr = MonthDayArr;
    if (_MonthDayArr) {
        _dayBeginLabel.text = [NSString stringWithFormat:@"入店:%@",_MonthDayArr.firstObject?:@""];
        _datEndLabel.text = [NSString stringWithFormat:@"离店:%@",_MonthDayArr.lastObject?:@""];
    }
    else {
        _datEndLabel.hidden = YES;
        _dayBeginLabel.hidden = YES;
        _calender.hidden = YES;
        _totalDaysLabel.hidden = YES;
        [[self setupHotelNumber] makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.customHeadImageView.bottom).offset(GET_SCAlE_HEIGHT(-5));
            make.left.equalTo(self.contentView);
            make.size.mas_equalTo((CGSize){SCREEN_WIDTH,GET_SCAlE_HEIGHT(25)});
        }];
    }
    
    _totalDaysLabel.text = [NSString stringWithFormat:@"共%ld晚",[self days]];
}

- (NSInteger)days {
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = @"yyyy-MM-dd";
    NSDate *beginDate = [formatter dateFromString:_MonthDayArr.firstObject?:@""];
    NSDate *endDate = [formatter dateFromString:_MonthDayArr.lastObject?:@""];
    NSTimeInterval interval = [endDate timeIntervalSinceDate:beginDate];
    NSInteger days = interval / (24 * 3600);
    (days <= 0)?(days = 1):(days = days);
    return days;
}



- (void)layoutSubviews {
    [super layoutSubviews];
}

- (void)setOrderNumber:(NSInteger)orderNumber {
    _orderNumber = orderNumber;
    _orderNumLabel.text = [NSString stringWithFormat:@"数量:%ld",self.orderNumber];
}

- (UIView*)setupHotelNumber {
    if ([self.contentView viewWithTag:1000]) {
        return [self.contentView viewWithTag:1000];
    }
    cellDemonstrationView * view = [cellDemonstrationView new];//[[cellDemonstrationView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,GET_SCAlE_HEIGHT(50))];
    [self.contentView addSubview:view];
    [view makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.customHeadImageView.bottom).offset(GET_SCAlE_HEIGHT(5));
        make.left.equalTo(self.contentView);
        make.size.mas_equalTo((CGSize){SCREEN_WIDTH,GET_SCAlE_HEIGHT(50)});
    }];
    view.tag = 1000;
    view.backgroundColor = UIColorFromRGB(WHITECOLOR);
    
    [view setViewWithTitle:nil SubTitle:nil RightTitle:nil SymbolImage:[UIImage imageNamed:@""]];
    
    UIImageView * calender = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"callender"]];
    [view addSubview:calender];
    _calender = calender;
    [calender makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(view.centerY).multipliedBy(0.5);
        make.left.mas_equalTo(view.left).with.offset(GET_SCAlE_LENGTH(15));
        make.size.mas_equalTo(CGSizeMake(calender.image.size.width, calender.image.size.height));
    }];
    
    
    _dayBeginLabel = [UILabel new];
    [view addSubview:_dayBeginLabel];
    [_dayBeginLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(view.centerY).multipliedBy(0.5);
        make.left.mas_equalTo(calender.right).with.offset(GET_SCAlE_LENGTH(5));
        //                make.size.mas_equalTo(<#CGSize#>);
    }];
    _dayBeginLabel.textColor = UIColorFromRGB(GRAYFONTCOLOR);
    _dayBeginLabel.font = [UIFont systemFontOfSize:NORMALFONTSIZE];
    _dayBeginLabel.text = [NSString stringWithFormat:@"入店:%@",_MonthDayArr.firstObject?:@""];
    
    
    
    _datEndLabel  = [UILabel new];
    [view addSubview:_datEndLabel];
    [_datEndLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(view.centerY).multipliedBy(0.5);
        make.left.mas_equalTo(_dayBeginLabel.right).with.offset(GET_SCAlE_LENGTH(10));
    }];
    _datEndLabel.textColor = UIColorFromRGB(GRAYFONTCOLOR);
    _datEndLabel.font = [UIFont systemFontOfSize:NORMALFONTSIZE];
    _datEndLabel.text = [NSString stringWithFormat:@"离店:%@",_MonthDayArr.lastObject?:@""];
    _totalDaysLabel  = [UILabel new];
    [view addSubview:_totalDaysLabel];
    [_totalDaysLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(view.centerY).multipliedBy(0.5);
        make.right.mas_equalTo(view.symBolImageView.left).with.offset(GET_SCAlE_LENGTH(-5));
    }];
    _totalDaysLabel.textColor = UIColorFromRGB(LIGHTBLUECOLOR);
    _totalDaysLabel.font = [UIFont systemFontOfSize:NORMALFONTSIZE];
    
    UILabel *orderNumLabel  = [UILabel new];
    _orderNumLabel = orderNumLabel;
    [view addSubview:orderNumLabel];
    [orderNumLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(view.centerY).multipliedBy(1.5);
        make.right.mas_equalTo(view.symBolImageView.left).with.offset(GET_SCAlE_LENGTH(-5));
    }];
    orderNumLabel.textColor = UIColorFromRGB(LIGHTBLUECOLOR);
    orderNumLabel.font = [UIFont systemFontOfSize:NORMALFONTSIZE];
    orderNumLabel.text = [NSString stringWithFormat:@"数量:%ld",self.orderNumber];
    
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = @"yyyy-MM-dd";
    NSDate *beginDate = [formatter dateFromString:self.MonthDayArr.firstObject];
    NSDate *endDate = [formatter dateFromString:self.MonthDayArr.lastObject];
    BOOL is  = [beginDate timeIntervalSinceDate:endDate]>0 ? NO:YES;
    
    NSTimeInterval interval = [endDate timeIntervalSinceDate:beginDate];
    
    if (!is) {
        _dayBeginLabel.text = [@"入住:" stringByAppendingString:self.MonthDayArr.lastObject?:@""];
        _datEndLabel.text = [@"离店:" stringByAppendingString:self.MonthDayArr.firstObject?:@""];
        interval = [beginDate timeIntervalSinceDate:endDate];
    }
    
    NSInteger days = interval / (24 * 3600);
    (days < 0)?(days = 1):(days = days);
    
    _totalDaysLabel.text = [NSString stringWithFormat:@"共%ld晚",days];
    
    
//    UILabel * line = [UILabel new];
//    [view addSubview:line];
//    line.backgroundColor = UIColorFromRGB(LINECOLOR);
//    [line makeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.mas_equalTo(view.bottom);
//        make.left.mas_equalTo(view.left).with.offset(0);
//        make.right.mas_equalTo(view.right).with.offset(0);
//        make.height.mas_equalTo(@.5);
//    }];
    return view;
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
            make.top.mas_equalTo(self.mas_top).with.offset(GET_SCAlE_HEIGHT(GET_SCAlE_HEIGHT(10)));
            make.left.mas_equalTo(self.mas_left).with.offset(GET_SCAlE_LENGTH(GET_SCAlE_LENGTH(12)));
            make.size.mas_equalTo(CGSizeMake(GET_SCAlE_LENGTH(100), GET_SCAlE_HEIGHT(75)));
        }];
        
        //        _customHeadImageView.backgroundColor = [UIColor orangeColor];
        
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
    //    _customTitleLabel.backgroundColor = [UIColor greenColor];
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



#pragma mark - 公共部分视图

- (void)setUpSpecialImage
{
    _specailOfferImageView = [UIImageView new];
    [self addSubview:_specailOfferImageView];
    [_specailOfferImageView makeConstraints:^(MASConstraintMaker *make) {
        
    }];
    //    _specailOfferImageView.backgroundColor = [UIColor orangeColor];
    _specailOfferImageView.image = [UIImage imageNamed:@"specailOffer"];
}

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
    label.textColor = UIColorFromRGB(REDFONTCOLOR);
    label.font = [UIFont systemFontOfSize:12];
}

#pragma mark - 外部调用方法

/**
 *  配置cell参数
 *
 *  @param model 模型
 */
-(void)cellForRowWithModel:(HSProduct *)model
{
    self.specailOfferImageView.hidden = YES;
    
    [self.customHeadImageView sd_setImageWithURL:[NSURL URLWithString:model.logo] placeholderImage:[UIImage imageNamed:@"headimage"]];
    
    self.customTitleLabel.text = model.title;
    
    self.customStarLevelLabel.text = model.starlevel;
    self.customPriceLabel.text = [NSString stringWithFormat:@"￥%.2f",[model.price floatValue]/100];
    self.shopCurrencyPriceLabel.text = [NSString stringWithFormat:@"￥%d",model.coinprice.intValue];
    self.rebateShopCurrencyLabel.text = [NSString stringWithFormat:@"￥%d",model.coinreturn.intValue];

    
    if ([model.isspecial isEqualToString:@"是"] || [model.isspecial integerValue] == 1) {
        self.specailOfferImageView.hidden = NO;
    }
    
    CGFloat titleWidth = [self sizeForText:model.title WithMaxSize:CGSizeMake(1000, 14) AndWithFontSize:14].width;
    [_customTitleLabel updateConstraints:^(MASConstraintMaker *make) {
        
        if (titleWidth >= 170) {
            
            make.size.mas_equalTo(CGSizeMake(170, 14));
        }
        else
        {
            make.size.mas_equalTo(CGSizeMake(titleWidth, 14));
        }
    }];
    
    [_specailOfferImageView updateConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.customTitleLabel.centerY);
        make.left.mas_equalTo(self.customTitleLabel.right).with.offset(GET_SCAlE_LENGTH(10));
        make.size.mas_equalTo(CGSizeMake(GET_SCAlE_LENGTH(15), GET_SCAlE_LENGTH(15)));
    }];
    _specailOfferImageView.hidden = YES;
}



-(void)cellForHoelSuppListVC:(BOOL)flag
{
    if (flag) {
    }
}

- (void)cellShowSpecialSymbol:(BOOL)isShow
{
    if (isShow) {
        _specailOfferImageView.hidden = NO;
    }else{
        _specailOfferImageView.hidden = YES;
    }
}

// 用于求高度或宽度
- (CGSize) sizeForText:(NSString *)text WithMaxSize:(CGSize)maxSize AndWithFontSize:(CGFloat)fontSize
{
    CGRect rect = [text boundingRectWithSize: maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize: fontSize]} context:nil];
    
    return rect.size;
}

@end










