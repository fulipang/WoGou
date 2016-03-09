//
//  AddrCell.m
//  HomeShopping
//
//  Created by sooncong on 16/1/8.
//  Copyright © 2016年 Administrator. All rights reserved.
//

#import "AddrCell.h"

@implementation AddrCell
{
    AddrCallBackBlock _callBackBlock;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self loadCustomView];
        
    }
    
    return self;
}

#pragma mark - 自定义视图

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
    
    _userNameLabel  = [UILabel new];
    [self addSubview:_userNameLabel];
    [_userNameLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.top).with.offset(GET_SCAlE_HEIGHT(10));
        make.left.mas_equalTo(self.left).with.offset(GET_SCAlE_LENGTH(15));
    }];
    _userNameLabel.textColor = UIColorFromRGB(BLACKFONTCOLOR);
    _userNameLabel.font = [UIFont systemFontOfSize:TITLENAMEFONTSIZE];
    _userNameLabel.text = @"春阳";
    
    _telePhoneNumberLabel  = [UILabel new];
    [self addSubview:_telePhoneNumberLabel];
    [_telePhoneNumberLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_userNameLabel.centerY).with.offset(0);
        make.right.mas_equalTo(self.right).with.offset(GET_SCAlE_LENGTH(-15));
    }];
    _telePhoneNumberLabel.textColor = UIColorFromRGB(BLACKFONTCOLOR);
    _telePhoneNumberLabel.font = [UIFont systemFontOfSize:TITLENAMEFONTSIZE];
    _telePhoneNumberLabel.text = @"18617105521";
    
    _detailAddrLabel  = [UILabel new];
    [self addSubview:_detailAddrLabel];
    [_detailAddrLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_userNameLabel.bottom).with.offset(GET_SCAlE_HEIGHT(8));
        make.left.mas_equalTo(_userNameLabel.left).with.offset(0);
        make.right.mas_equalTo(_telePhoneNumberLabel.right);
    }];
    _detailAddrLabel.textColor = UIColorFromRGB(BLACKFONTCOLOR);
    _detailAddrLabel.font = [UIFont systemFontOfSize:NORMALFONTSIZE];
    _detailAddrLabel.text = @"黑龙江省牡丹江市宁安市通江路创建胡同0443号斯柯达法拉刷卡缴费的";
    
    _selectionButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:_selectionButton];
    [_selectionButton setBackgroundImage:[UIImage imageNamed:@"selected"] forState:UIControlStateNormal];
    [_selectionButton setBackgroundImage:[UIImage imageNamed:@"selected_d"] forState:UIControlStateSelected];
    [_selectionButton makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_detailAddrLabel.bottom).with.offset(GET_SCAlE_HEIGHT(8));
        make.left.mas_equalTo(_userNameLabel.left);
        make.size.mas_equalTo(CGSizeMake(GET_SCAlE_LENGTH(12), GET_SCAlE_LENGTH(12)));
    }];

//    _selectionButton.backgroundColor = [UIColor orangeColor];
    
    UILabel * label  = [UILabel new];
    [self addSubview:label];
    [label makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_selectionButton.centerY).with.offset(0);
        make.left.mas_equalTo(_selectionButton.right).with.offset(GET_SCAlE_LENGTH(5));
    }];
    label.textColor = UIColorFromRGB(GRAYFONTCOLOR);
    label.font = [UIFont systemFontOfSize:NORMALFONTSIZE];
    label.text = @"设为默认";
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectionButtonClicked)];
    [label addGestureRecognizer:tap];
    label.userInteractionEnabled = YES;
    
    //操作相关
    UIView * operationBaseView = [UIView new];
    [self addSubview:operationBaseView];
    [operationBaseView makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(label.centerY);
        make.right.mas_equalTo(_telePhoneNumberLabel.right);
        make.size.mas_equalTo(CGSizeMake(GET_SCAlE_LENGTH(70), GET_SCAlE_HEIGHT(15)));
    }];
    
    UIButton * EditButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [operationBaseView addSubview:EditButton];
    [EditButton makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(operationBaseView.centerY);
        make.left.mas_equalTo(operationBaseView.left);
        make.size.mas_equalTo(CGSizeMake(GET_SCAlE_LENGTH(34), GET_SCAlE_HEIGHT(15)));
    }];
    [EditButton setTitle:@"编辑" forState:UIControlStateNormal];
    [EditButton.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [EditButton setTitleColor:UIColorFromRGB(BLACKCOLOR) forState:UIControlStateNormal];
    
    UIButton * deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [operationBaseView addSubview:deleteButton];
    [deleteButton makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(EditButton.centerY);
        make.right.mas_equalTo(operationBaseView.right);
        make.size.mas_equalTo(CGSizeMake(GET_SCAlE_LENGTH(34), GET_SCAlE_HEIGHT(15)));
    }];
    [deleteButton setTitle:@"删除" forState:UIControlStateNormal];
    [deleteButton.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [deleteButton setTitleColor:UIColorFromRGB(REDFONTCOLOR) forState:UIControlStateNormal];
    
    UILabel * line_s = [UILabel new];
    [operationBaseView addSubview:line_s];
    [line_s makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(operationBaseView.centerY);
        make.centerX.mas_equalTo(operationBaseView.centerX);
        make.size.mas_equalTo(CGSizeMake(1, GET_SCAlE_HEIGHT(12)));
    }];
    line_s.backgroundColor = UIColorFromRGB(LINECOLOR);
    
    //添加事件
    [_selectionButton addTarget:self action:@selector(selectionButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [EditButton addTarget:self action:@selector(editButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [deleteButton addTarget:self action:@selector(deleteButtonClicked) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - 事件

/**
 *  勾选按钮点击事件
 */
- (void)selectionButtonClicked
{
    if (_callBackBlock) {
        _callBackBlock(kAddrClickTypeSelection);
    }
}

/**
 *  编辑按钮点击事件
 */
- (void)editButtonClicked
{
//    NSLog(@"%s", __func__);
    _callBackBlock(kAddrClickTypeEdit);
}

/**
 *  删除按钮点击事件
 */
- (void)deleteButtonClicked
{
//    NSLog(@"%s", __func__);
    _callBackBlock(kAddrClickTypeDelete);
}

-(void)cellForRowWithModel:(Addresse *)address
{
    _userNameLabel.text = address.consignee;
    _telePhoneNumberLabel.text = address.consigneephone;
    _detailAddrLabel.text = [NSString stringWithFormat:@"%@%@",address.pca,address.consigneeaddress];
    // 北京,天津, 上海, 重庆
    NSString *tempAddress = nil;
    NSArray *fourCities = @[@"北京", @"天津", @"上海", @"重庆"];
    for (NSString *city in fourCities) {
        NSRange range = [address.pca rangeOfString:city];
        if (range.location != NSNotFound) {
            tempAddress = [address.pca stringByReplacingCharactersInRange:range withString:@""];
            break;
        }
    }
    if (tempAddress) {
        _detailAddrLabel.text = [[NSString stringWithFormat:@"%@",tempAddress] stringByAppendingString:address.consigneeaddress];
    }
//    _detailAddrLabel.text = address.consigneeaddress;
    BOOL selected = ([address.isdefault isEqualToString:@"1"]?YES:NO);
    _selectionButton.selected = selected;
}

#pragma mark - 外部方法

-(void)callBackWithBlock:(AddrCallBackBlock)callBackBlock
{
    _callBackBlock = callBackBlock;
}

@end
