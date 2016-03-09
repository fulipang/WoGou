//
//  ProductSelectedView.m
//  HomeShopping
//
//  Created by sooncong on 16/1/2.
//  Copyright © 2016年 Administrator. All rights reserved.
//

#import "ProductSelectedView.h"

@implementation ProductSelectedView
{
    //选定数量
    NSInteger _count;
    
    //数量标签
    UILabel * _numberLabel;
    
    //回调block
    SelectedCallBackBlock _callBackBlock;
    
    //回传字典
    NSMutableDictionary * _callBackDictionary;
    
    //数据源
    NSArray * _dataSource;
    
    //记录当前操作类型
    OperationType _currentType;
}

-(instancetype)initWithFrame:(CGRect)frame withDataArray:(NSArray *)dataArray
{
    self = [super initWithFrame:frame];
    
    if (self) {
        _dataSource = dataArray;
        _currentType = kNone;
        [self loadCustomView];
        _count = 1;
    }
    
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame WithDataArry:(NSArray *)dataArry CallBackBlock:(SelectedCallBackBlock)block
{
    self = [super initWithFrame:frame];
    
    if (self) {
        _dataSource = dataArry;
        _currentType = kNone;
        [self loadCustomView];
        _count = 1;
        _callBackBlock = block;
    }
    
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        _currentType = kNone;
        [self loadCustomView];
        _count = 1;
    }
    
    return self;
}

- (void)loadCustomView
{
    self.backgroundColor = UIColorFromRGB(WHITECOLOR);
    
    //初始化字典
    _callBackDictionary = [[NSMutableDictionary alloc] initWithCapacity:1];
    
    NSDictionary * dic = [_dataSource firstObject];
    NSString * normId = dic[@"normid"];
    NSString * normTitle = dic[@"normtitle"];
    [_callBackDictionary setObject:normId forKey:@"normid"];
    [_callBackDictionary setObject:normTitle forKey:@"normtitle"];
    [_callBackDictionary setObject:@"1" forKey:@"number"];
    
    //标题
    _titleLabel  = [UILabel new];
    [self addSubview:_titleLabel];
    [_titleLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.top).with.offset(GET_SCAlE_HEIGHT(15));
        make.left.mas_equalTo(self.left).with.offset(GET_SCAlE_LENGTH(15));
    }];
    _titleLabel.textColor = UIColorFromRGB(BLACKCOLOR);
    _titleLabel.font = [UIFont systemFontOfSize:TITLENAMEFONTSIZE];
    _titleLabel.text = @"颜色分类";
    _titleLabel.backgroundColor = [UIColor clearColor];
    
    //选择部分
    _selectedBaseView = [UIView new];
    [self addSubview:_selectedBaseView];
    [_selectedBaseView makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_titleLabel.bottom).with.offset(GET_SCAlE_HEIGHT(15));
        make.centerX.mas_equalTo(self.centerX);
        make.size.mas_equalTo(CGSizeMake(GET_SCAlE_LENGTH(290), GET_SCAlE_LENGTH(30)));
    }];
    
    for (NSInteger i = 0; i < _dataSource.count; i++) {
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        [_selectedBaseView addSubview:button];
        [button makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_selectedBaseView.top);
            make.left.mas_equalTo(_selectedBaseView.left).with.offset(i * (SCREEN_WIDTH - GET_SCAlE_LENGTH(30))/3);
            make.size.mas_equalTo(CGSizeMake((SCREEN_WIDTH - GET_SCAlE_LENGTH(30))/3, 30));
        }];
        if ([_dataSource[i][@"normtitle"] isKindOfClass:[NSString class]]) {
            NSString * titel = _dataSource[i][@"normtitle"];
            [button setTitle:titel forState:UIControlStateNormal];
        }
        [button.titleLabel setFont:[UIFont systemFontOfSize:NORMALFONTSIZE]];
        [button setTitleColor:UIColorFromRGB(BLACKFONTCOLOR) forState:UIControlStateNormal];
        button.tag = 100 + i;
        button.backgroundColor = [UIColor clearColor];
        button.layer.cornerRadius = 5;
        button.clipsToBounds = YES;
        [button addTarget:self action:@selector(seletedButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        if (i == 0) {
            button.backgroundColor = UIColorFromRGB(GRAYBGCOLOR);
        }
    }
    
    //数量部分
    _quantityBaseView = [UIView new];
    [self addSubview:_quantityBaseView];
    [_quantityBaseView makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_selectedBaseView.bottom).with.offset(GET_SCAlE_HEIGHT(15));
        make.centerX.mas_equalTo(self.centerX);
        make.size.mas_equalTo(CGSizeMake(GET_SCAlE_LENGTH(290), GET_SCAlE_HEIGHT(50)));
    }];
    
    UILabel * line_top = [UILabel new];
    [_quantityBaseView addSubview:line_top];
    [line_top makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_quantityBaseView.top);
        make.centerX.mas_equalTo(_quantityBaseView.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(GET_SCAlE_LENGTH(290), 0.5));
    }];
    line_top.backgroundColor = UIColorFromRGB(LINECOLOR);
    
    UILabel * line_bottom = [UILabel new];
    [_quantityBaseView addSubview:line_bottom];
    [line_bottom makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(_quantityBaseView.mas_bottom);
        make.centerX.mas_equalTo(_quantityBaseView.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(GET_SCAlE_LENGTH(290), 0.5));
    }];
    line_bottom.backgroundColor = UIColorFromRGB(LINECOLOR);
    
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
    _numberLabel.text = @"1";
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
    
    
    //底部按钮
    _bottomBaseView = [UIView new];
    [self addSubview:_bottomBaseView];
    [_bottomBaseView makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.bottom);
        make.centerX.mas_equalTo(self.centerX);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, GET_SCAlE_HEIGHT(95/2)));
    }];
    
    UIButton * shoppingCartButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_bottomBaseView addSubview:shoppingCartButton];
    [shoppingCartButton makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_bottomBaseView.centerY);
        make.left.mas_equalTo(_bottomBaseView.left);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH/2, GET_SCAlE_HEIGHT(95/2)));
    }];
    [shoppingCartButton setTitle:@"加入购物车" forState:UIControlStateNormal];
    [shoppingCartButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [shoppingCartButton setTitleColor:UIColorFromRGB(WHITECOLOR) forState:UIControlStateNormal];
    shoppingCartButton.backgroundColor = [UIColor orangeColor];
    shoppingCartButton.tag = 51;
    [shoppingCartButton addTarget:self action:@selector(bottomButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton * buyButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_bottomBaseView addSubview:buyButton];
    [buyButton makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_bottomBaseView.centerY);
        make.right.mas_equalTo(_bottomBaseView.right);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH/2, GET_SCAlE_HEIGHT(95/2)));
    }];
    [buyButton setTitle:@"立即购买" forState:UIControlStateNormal];
    [buyButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [buyButton setTitleColor:UIColorFromRGB(WHITECOLOR) forState:UIControlStateNormal];
    buyButton.backgroundColor = [self colorFromRed:244 Green:30 Blue:75];
    buyButton.tag = 52;
    [buyButton addTarget:self action:@selector(bottomButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    
}

- (UIColor *)colorFromRed:(CGFloat)red Green:(CGFloat)green Blue:(CGFloat)blue
{
    return [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:1];
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

#pragma mark - 事件

/**
 *  选择按钮点击事件
 *
 *  @param sender
 */
- (void)seletedButtonClicked:(UIButton *)sender
{
    for (UIButton * button in _selectedBaseView.subviews) {
        button.backgroundColor = [UIColor clearColor];
    }
    
    sender.backgroundColor = UIColorFromRGB(GRAYBGCOLOR);
    NSInteger position = sender.tag % 10;
    NSString * normId = _dataSource[position][@"normid"];
    NSString * normTitle = _dataSource[position][@"normtitle"];
    [_callBackDictionary setObject:normId forKey:@"normid"];
    [_callBackDictionary setObject:normTitle forKey:@"normtitle"];
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
    [_callBackDictionary setObject:[NSString stringWithFormat:@"%ld",_count] forKey:@"number"];
}

/**
 *  底部按钮点击事件
 *
 *  @param sender
 */
- (void)bottomButtonClicked:(UIButton *)sender
{
    OperationType type = sender.tag % 10;
    _currentType = type;
    _callBackBlock(_callBackDictionary,_currentType);
}

/**
 *  显示
 */
-(void)show
{
    CGRect oldFrame = self.frame;
    oldFrame.origin.y = SCREEN_HEIGHT - (self.frame.size.height);
    [UIView animateWithDuration:0.5 animations:^{
        self.frame = oldFrame;
    } completion:^(BOOL finished) {
        
    }];
}

/**
 *  隐藏
 */
-(void)hide
{
    //    if (_currentType == kNone) {
    //        _callBackBlock(_callBackDictionary,_currentType);
    //    }
    [self.delegate maskTapWithDictionary:_callBackDictionary OperationType:_currentType];
    
    CGRect oldFrame = self.frame;
    oldFrame.origin.y = SCREEN_HEIGHT;
    [UIView animateWithDuration:0.5 animations:^{
        self.frame = oldFrame;
    } completion:^(BOOL finished) {
        
        [self removeFromSuperview];
    }];
}

-(void)callBackWithBlock:(SelectedCallBackBlock)block
{
    _callBackBlock = block;
}



@end
