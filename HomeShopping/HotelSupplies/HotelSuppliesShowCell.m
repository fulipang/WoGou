//
//  HotelSuppliesShowCell.m
//  HomeShopping
//
//  Created by sooncong on 15/12/18.
//  Copyright © 2015年 Administrator. All rights reserved.
//

#import "HotelSuppliesShowCell.h"
#import "UIImageView+WebCache.h"

@implementation HotelSuppliesShowCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self loadCustomView];
        
    }
    
    return self;
}

/**
 *  装载自定义视图
 */
- (void)loadCustomView
{
    //图片
    self.imageView = [UIImageView new];
    self.imageView.image = [UIImage imageNamed:@"headimage"];
    [self.contentView addSubview:self.imageView];
//    self.imageView.backgroundColor = [UIColor orangeColor];
    [self.imageView makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView.centerY).with.offset(-15);
        make.centerX.mas_equalTo(self.contentView.centerX);
        make.size.mas_equalTo(CGSizeMake(GET_SCAlE_LENGTH(80), GET_SCAlE_HEIGHT(80)));
    }];
    
    //标题
    self.titleLabel = [UILabel new];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.titleLabel];
    [self.titleLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.imageView.mas_bottom).with.offset(10);
//        make.centerX.mas_equalTo(self.contentView.mas_centerX);
        make.left.and.right.mas_equalTo(self.contentView);
    }];
}

-(void)setCellWithModel:(HSSubcategory *)model
{
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:model.subcategorylogo] placeholderImage:[UIImage imageNamed:@"headimage"]];
    self.titleLabel.text = model.subtitle;
}

@end
