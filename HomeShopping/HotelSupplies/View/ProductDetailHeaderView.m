//
//  ProductDetailHeaderView.m
//  HomeShopping
//
//  Created by sooncong on 15/12/31.
//  Copyright © 2015年 Administrator. All rights reserved.
//

#import "ProductDetailHeaderView.h"
#import "UIImageView+WebCache.h"
#import "ProductDetail.h"

@implementation ProductDetailHeaderView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        
        [self loadCutomViewWithFrame:frame];
    }
    
    return self;
}

- (void)loadCutomViewWithFrame:(CGRect)frame
{
    _baseView = [UIImageView new];
    [self addSubview:_baseView];
    [_baseView makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.mas_equalTo(self);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, frame.size.height));
    }];
//    _baseView.backgroundColor = [UIColor orangeColor];
    _baseView.image = [UIImage imageNamed:@"Product_sellerBG"];
    
    //头像
    _headImageView = [UIImageView new];
    [_baseView addSubview:_headImageView];
    [_headImageView makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_baseView.mas_centerY);
        make.left.mas_equalTo(_baseView.mas_left).with.offset(GET_SCAlE_LENGTH(35/2));
        make.size.mas_equalTo(CGSizeMake(GET_SCAlE_LENGTH(60), GET_SCAlE_LENGTH(60)));
    }];
    _headImageView.backgroundColor = [UIColor greenColor];
    _headImageView.layer.cornerRadius = GET_SCAlE_LENGTH(30);
    _headImageView.clipsToBounds = YES;
    
    //标题
    _titleLabel = [UILabel new];
    [_baseView addSubview:_titleLabel];
    [_titleLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_headImageView.mas_centerY).with.offset(GET_SCAlE_HEIGHT(-10));
        make.left.mas_equalTo(self.headImageView.right).with.offset(GET_SCAlE_LENGTH(15));
    }];
    _titleLabel.font = [UIFont systemFontOfSize:16];
    _titleLabel.textColor = UIColorFromRGB(WHITECOLOR);
//    _titleLabel.text = @"广州小米之家天河区";
    
    //评分
     _scoreLabel = [UILabel new];
    [_baseView addSubview:_scoreLabel];
    [_scoreLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLabel.left);
        make.top.mas_equalTo(self.titleLabel.bottom).with.offset(GET_SCAlE_HEIGHT(5));
    }];
    _scoreLabel.font = [UIFont systemFontOfSize:12];
    _scoreLabel.textColor = UIColorFromRGB(WHITECOLOR);
//    _scoreLabel.text = @"评分:9.8";
    
    //收藏
     _collectionLabel = [UILabel new];
    [_baseView addSubview:_collectionLabel];
    [_collectionLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_scoreLabel.top);
        make.right.mas_equalTo(_baseView.right).with.offset(GET_SCAlE_LENGTH(-10));
    }];
    _collectionLabel.font = [UIFont systemFontOfSize:12];
    _collectionLabel.textColor = UIColorFromRGB(WHITECOLOR);
//    _collectionLabel.text = @"555人收藏";
}

-(void)setParameterWithModel:(id)model
{
    if ([model isKindOfClass:[ProductDetail class]]) {
        ProductDetail * product = (ProductDetail *)model;
        _titleLabel.text = product.sellername;
        [_headImageView sd_setImageWithURL:[NSURL URLWithString:product.sellerlogo] placeholderImage:[UIImage imageNamed:@"Product_sellerhead_placehold"]];
        _scoreLabel.text = [NSString stringWithFormat:@"评分:%.1f",product.sellerscore.floatValue/10];
//        _collectionLabel.text = [NSString stringWithFormat:@"%@",product.]
    }
}

@end
