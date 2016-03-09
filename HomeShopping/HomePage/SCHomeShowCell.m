//
//  SCHomeShowCell.m
//  HomeShopping
//
//  Created by sooncong on 15/12/9.
//  Copyright © 2015年 Administrator. All rights reserved.
//

#import "SCHomeShowCell.h"
#import "HPCategorysModel.h"
#import "UIImageView+WebCache.h"

#define SHOWCELLHEIGHT GET_SCAlE_HEIGHT(170)

@implementation SCHomeShowCell
{
    HomeShowCallBackBlock _callBackBlock;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        [self loadUpCustomView];
        
        self.contentView.backgroundColor = UIColorFromRGB(GRAYBGCOLOR);
    }
    
    return self;
}

/**
 *  装载自定义视图
 */
- (void)loadUpCustomView
{
    for (NSInteger i = 0; i < 8; i++) {
        
        NSInteger line           = i % 4;
        NSInteger row            = i / 4;
        CGFloat width            = SCREEN_WIDTH/4;
        CGFloat height           = SHOWCELLHEIGHT/2;

        UIButton * button        = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag               = i + 100;
        button.frame             = CGRectMake(width * line, height * row, width, height);
//        button.layer.borderWidth = 0.5;
//        button.layer.borderColor = [[UIColor orangeColor] CGColor];
        button.titleLabel.font   = [UIFont systemFontOfSize:15];
        
        [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        /**
         *  自定义标题
         */
        UILabel * customeTitleLabel = [UILabel new];
        [button addSubview:customeTitleLabel];
        [customeTitleLabel makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(button);
            make.bottom.mas_equalTo(button.mas_bottom).with.offset(GET_SCAlE_HEIGHT(-7));
        }];
        customeTitleLabel.font = [UIFont systemFontOfSize:NORMALFONTSIZE];
        customeTitleLabel.text = self.buttonTitles[i];
        customeTitleLabel.textColor = UIColorFromRGB(GRAYFONTCOLOR);
        
        [button setImage:self.buttonImages[i] forState:UIControlStateNormal];
        [button setImageEdgeInsets:UIEdgeInsetsMake(-13, 0, 0, 0)];
        [button setTitleColor:UIColorFromRGB(BLACKFONTCOLOR) forState:UIControlStateNormal];
        
        [self addSubview:button];
        
    }
}


-(void)callBackWithBlock:(HomeShowCallBackBlock)callBackBlock
{
    _callBackBlock = callBackBlock;
}

#pragma mark - ControlEvent

/**
 *  监听按钮点击事件
 *
 *  @param sender 所点击的按钮
 */
- (void)buttonClicked:(UIButton *)sender
{
    
    NSInteger type = sender.tag - 100;
    
    _callBackBlock(type);
}

#pragma mark - lazyLoad

/**
 *  重写buttontitles Set方法
 *
 *  @return 存储按钮名字的数组
 */
-(NSMutableArray *)buttonTitles
{
    if (_buttonTitles == nil) {
        
        _buttonTitles = [NSMutableArray array];
        
        [_buttonTitles addObject:@"床上用品"];
        [_buttonTitles addObject:@"洗刷"];
        [_buttonTitles addObject:@"浴室"];
        [_buttonTitles addObject:@"灯饰"];
        [_buttonTitles addObject:@"一星酒店"];
        [_buttonTitles addObject:@"二星酒店"];
        [_buttonTitles addObject:@"三星酒店"];
        [_buttonTitles addObject:@"五星酒店"];
    }

    return _buttonTitles;
}

-(NSMutableArray *)buttonImages
{
    if (_buttonImages == nil) {
        
        _buttonImages = [NSMutableArray array];
        [_buttonImages addObject:[UIImage imageNamed:@"show_hotel_bedding"]];
        [_buttonImages addObject:[UIImage imageNamed:@"show_hotel_brush"]];
        [_buttonImages addObject:[UIImage imageNamed:@"show_hotel_bathroom"]];
        [_buttonImages addObject:[UIImage imageNamed:@"show_hotel_light"]];
        [_buttonImages addObject:[UIImage imageNamed:@"show_hotel_oneStar"]];
        [_buttonImages addObject:[UIImage imageNamed:@"show_hotel_twoStar"]];
        [_buttonImages addObject:[UIImage imageNamed:@"show_hotel_threeStar"]];
        [_buttonImages addObject:[UIImage imageNamed:@"show_hotel_fiveStar"]];
    }
    
    return _buttonImages;
}

- (void)setCellWithData:(NSArray *)categoryData
{
    for (UIButton * item in self.subviews) {
        if ([item isKindOfClass:[UIButton class]]) {
            [item removeFromSuperview];
        }
    }
    
    if (categoryData.count <=8) {
    
    for (NSInteger i = 0; i < 8; i++) {
        
        HPCategorysModel * category = categoryData[i];
        
        NSInteger line           = i % 4;
        NSInteger row            = i / 4;
        CGFloat width            = SCREEN_WIDTH/4;
        CGFloat height           = SHOWCELLHEIGHT/2;
        
        UIButton * button        = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag               = i + 100;
        button.frame             = CGRectMake(width * line, height * row, width, height);
        button.titleLabel.font   = [UIFont systemFontOfSize:15];
        
        [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        /**
         *  自定义标题
         */
        UILabel * customeTitleLabel = [UILabel new];
        [button addSubview:customeTitleLabel];
        [customeTitleLabel makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(button);
            make.bottom.mas_equalTo(button.mas_bottom).with.offset(GET_SCAlE_HEIGHT(-7));
        }];
        customeTitleLabel.font = [UIFont systemFontOfSize:NORMALFONTSIZE];
        customeTitleLabel.text = category.title;
        customeTitleLabel.textColor = UIColorFromRGB(GRAYFONTCOLOR);
        [button setImageEdgeInsets:UIEdgeInsetsMake(-13, 0, 0, 0)];
        [button setTitleColor:UIColorFromRGB(BLACKFONTCOLOR) forState:UIControlStateNormal];
        
        UIImageView * imageView = [UIImageView new];
        [imageView sd_setImageWithURL:[NSURL URLWithString:category.logo] placeholderImage:[UIImage imageNamed:@"headimage"]];
        [button addSubview:imageView];
        
        [self addSubview:button];
        [imageView makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(button.centerX);
            make.centerY.mas_equalTo(button.centerY).with.offset(GET_SCAlE_HEIGHT(-5));
            make.size.mas_equalTo(CGSizeMake(GET_SCAlE_LENGTH(45), GET_SCAlE_LENGTH(45)));
        }];
        imageView.layer.cornerRadius = 10;
        imageView.clipsToBounds = YES;
        
    }
    }
}


@end
