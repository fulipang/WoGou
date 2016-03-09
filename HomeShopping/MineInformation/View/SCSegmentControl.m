//
//  SCSegmentControl.m
//  HomeShopping
//
//  Created by sooncong on 16/1/9.
//  Copyright © 2016年 Administrator. All rights reserved.
//

#import "SCSegmentControl.h"

@implementation SCSegmentControl
{
    
    SCSegmentCallBackBlock _callBackBlock;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.layer.borderWidth = 1;
        self.layer.borderColor = UIColorFromRGB(WHITECOLOR).CGColor;
        
        [self loadCustomView];
    }
    
    return self;
}

#pragma mark - 自定义视图

- (void)loadCustomView
{
    [self setUpBackView];
    
    [self setUpLeftView];
    
    [self setUpRightView];
}

- (void)setUpLeftView
{
    _leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:_leftButton];
    [_leftButton makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.and.bottom.mas_equalTo(self);
        make.size.mas_equalTo(CGSizeMake(self.frame.size.width/2.0, self.frame.size.height));
    }];
    [_leftButton.titleLabel setFont:[UIFont systemFontOfSize:TITLENAMEFONTSIZE]];
    [_leftButton setTitleColor:UIColorFromRGB(LIGHTBLUECOLOR) forState:UIControlStateNormal];
    [_leftButton setTitle:@"酒店用品" forState:UIControlStateNormal];
    [_leftButton addTarget:self action:@selector(segmentControlClicked:) forControlEvents:UIControlEventTouchUpInside];
    _leftButton.tag = 150;
    
}

- (void)setUpRightView
{
    _rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:_rightButton];
    [_rightButton makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.and.bottom.mas_equalTo(self);
        make.size.mas_equalTo(CGSizeMake(self.frame.size.width/2.0, self.frame.size.height));
    }];
    [_rightButton setTitle:@"订房" forState:UIControlStateNormal];
    [_rightButton.titleLabel setFont:[UIFont systemFontOfSize:TITLENAMEFONTSIZE]];
    [_rightButton setTitleColor:UIColorFromRGB(WHITECOLOR) forState:UIControlStateNormal];
    [_rightButton addTarget:self action:@selector(segmentControlClicked:) forControlEvents:UIControlEventTouchUpInside];
    _rightButton.tag = 151;
    
}

- (void)setUpBackView
{
    _backGroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width/2.0, self.frame.size.height)];
    [self addSubview:_backGroundView];
    [_backGroundView makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.and.bottom.mas_equalTo(self);
        make.size.mas_equalTo(CGSizeMake(self.frame.size.width/2.0, self.frame.size.height));
    }];
    _backGroundView.backgroundColor = UIColorFromRGB(WHITECOLOR);
}

#pragma mark - 事件

- (void)segmentControlClicked:(UIButton *)sender
{
    SCSegmentControlClickType type = sender.tag % 10;
    CGRect frame = _backGroundView.frame;
    
    switch (type) {
        case kSCSegClickLeft: {
            [_leftButton setTitleColor:UIColorFromRGB(LIGHTBLUECOLOR) forState:UIControlStateNormal];
            [_rightButton setTitleColor:UIColorFromRGB(WHITECOLOR) forState:UIControlStateNormal];
            frame.origin.x = 0;
            break;
        }
        case kSCSegClickRight: {
            [_leftButton setTitleColor:UIColorFromRGB(WHITECOLOR) forState:UIControlStateNormal];
            [_rightButton setTitleColor:UIColorFromRGB(LIGHTBLUECOLOR) forState:UIControlStateNormal];
            frame.origin.x = self.frame.size.width/2.0;
            break;
        }
    }
    
    
    [UIView animateWithDuration:0.3 animations:^{
        _backGroundView.frame = frame;        
    }];
    
    if (_callBackBlock) {
        _callBackBlock(type);
    }
    
}

-(void)callBackWithBlock:(SCSegmentCallBackBlock)callBackBlock
{
    _callBackBlock = callBackBlock;
}

@end
