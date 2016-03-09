//
//  ProductDetailTabbar.m
//  HomeShopping
//
//  Created by sooncong on 15/12/31.
//  Copyright © 2015年 Administrator. All rights reserved.
//

#import "ProductDetailTabbar2.h"

@implementation ProductDetailTabbar2
{
    //回调block
    productTabCallBackBlock _callBackBlock;
}

-(instancetype)initWithFrame:(CGRect)frame callBackBlock:(productTabCallBackBlock)callBackBlock
{
    self = [super initWithFrame:frame];
    
    if (self) {
        _callBackBlock = callBackBlock;
        [self loadCustomViewWithFrame:frame];
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self loadCustomViewWithFrame:frame];
    }
    
    return self;
}

- (void)loadCustomViewWithFrame:(CGRect)frame
{
    //客服按钮
    _GuestclothingButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:_GuestclothingButton];
    [_GuestclothingButton makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.top);
        make.left.mas_equalTo(self.left);
        make.size.mas_equalTo(CGSizeMake((103/2.0), frame.size.height));
    }];
    [_GuestclothingButton setImage:[UIImage imageNamed:@"Product_tabbar_guest"] forState:UIControlStateNormal];
    [_GuestclothingButton setImage:[UIImage imageNamed:@"Product_tabbar_guest_d"] forState:UIControlStateHighlighted];
    [_GuestclothingButton.titleLabel setFont:[UIFont systemFontOfSize:10]];
    [_GuestclothingButton setTitleColor:UIColorFromRGB(GRAYFONTCOLOR) forState:UIControlStateNormal];
    _GuestclothingButton.backgroundColor = [UIColor whiteColor];
    _GuestclothingButton.tag = 11;
    
    //电话按钮
    _telPhoneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:_telPhoneButton];
    [_telPhoneButton makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_GuestclothingButton.right);
        make.bottom.mas_equalTo(self.bottom);
        make.size.mas_equalTo(CGSizeMake((103/2.0), frame.size.height));
    }];
    [_telPhoneButton setImage:[UIImage imageNamed:@"Product_tabbar_tel"] forState:UIControlStateNormal];
    [_telPhoneButton setImage:[UIImage imageNamed:@"Product_tabbar_tel_d"] forState:UIControlStateHighlighted];
    [_telPhoneButton.titleLabel setFont:[UIFont systemFontOfSize:10]];
    [_telPhoneButton setTitleColor:UIColorFromRGB(GRAYFONTCOLOR) forState:UIControlStateNormal];
    _telPhoneButton.backgroundColor = [UIColor whiteColor];
    _telPhoneButton.tag = 12;
    
    //收藏按钮
//    _collectionButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [self addSubview:_collectionButton];
//    [_collectionButton makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(_telPhoneButton.right);
//        make.bottom.mas_equalTo(self.bottom);
//        make.size.mas_equalTo(CGSizeMake((103/2.0), frame.size.height));
//    }];
////    [_collectionButton setTitle:@"收藏" forState:UIControlStateNormal];
//    [_collectionButton setImage:[UIImage imageNamed:@"Product_tabbar_collection"] forState:UIControlStateNormal];
//    [_collectionButton setImage:[UIImage imageNamed:@"Product_tabbar_collection_d"] forState:UIControlStateHighlighted];
//    [_collectionButton.titleLabel setFont:[UIFont systemFontOfSize:10]];
//    [_collectionButton setTitleColor:UIColorFromRGB(GRAYFONTCOLOR) forState:UIControlStateNormal];
//    _collectionButton.tag = 13;
    
    //购物车按钮
    _ShoppingCartButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:_ShoppingCartButton];
    [_ShoppingCartButton makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_telPhoneButton.right);
        make.bottom.mas_equalTo(self.bottom);
        make.size.mas_equalTo(CGSizeMake((((SCREEN_WIDTH - 103 * 2/2)/2)), frame.size.height));
    }];
    [_ShoppingCartButton setTitle:@"加入购物车" forState:UIControlStateNormal];
    [_ShoppingCartButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [_ShoppingCartButton setTitleColor:UIColorFromRGB(WHITECOLOR) forState:UIControlStateNormal];
    _ShoppingCartButton.backgroundColor = [UIColor orangeColor];
    _ShoppingCartButton.tag = 14;
    
    //购买按钮
    _buyButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:_buyButton];
    [_buyButton makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_ShoppingCartButton.right);
        make.right.mas_equalTo(self.right);
        make.bottom.mas_equalTo(self.bottom);
        make.height.mas_equalTo(@(frame.size.height));
    }];
    [_buyButton setTitle:@"立即购买" forState:UIControlStateNormal];
    [_buyButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [_buyButton setTitleColor:UIColorFromRGB(WHITECOLOR) forState:UIControlStateNormal];
    _buyButton.backgroundColor = [UIColor redColor];
    _buyButton.tag = 15;
    
    //添加时间
    [self addTargetWithButton:_GuestclothingButton];
    [self addTargetWithButton:_telPhoneButton];
    [self addTargetWithButton:_collectionButton];
    [self addTargetWithButton:_ShoppingCartButton];
    [self addTargetWithButton:_buyButton];
    
}

- (void)addTargetWithButton:(UIButton *)sender
{
    [sender addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)buttonClicked:(UIButton *)sender
{
    _callBackBlock(sender.tag %10);
}

-(void)callBakcWithBlock:(productTabCallBackBlock)callBackBlock
{
    _callBackBlock = callBackBlock;
}

@end
