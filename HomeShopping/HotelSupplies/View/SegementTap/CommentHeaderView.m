//
//  CommentHeaderView.m
//  HomeShopping
//
//  Created by sooncong on 16/1/2.
//  Copyright © 2016年 Administrator. All rights reserved.
//

#import "CommentHeaderView.h"

@interface CommentHeaderView ()

@property (nonatomic, strong)NSMutableArray *buttonsArray;

@property (nonatomic, strong)UIImageView *lineImageView;

@end

@implementation CommentHeaderView

-(instancetype)initWithFrame:(CGRect)frame withDataArray:(NSArray *)dataArray withFont:(CGFloat)font {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.frame             = frame;
        self.backgroundColor   = [UIColor whiteColor];
        _buttonsArray          = [[NSMutableArray alloc] init];
        _dataArray             = dataArray;
        _titleFont             = font;
        
        //默认
        self.textNomalColor    = UIColorFromRGB(GRAYFONTCOLOR);
        self.textSelectedColor = UIColorFromRGB(LIGHTBLUECOLOR);
        self.lineColor         = UIColorFromRGB(LIGHTBLUECOLOR);
        
        self.clipsToBounds = YES;
        
        [self addSubSegmentView];
    }
    return self;
}

-(void)addSubSegmentView
{
    float width = self.frame.size.width / _dataArray.count;
    
    self.lineImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.frame.size.height-4, width, 1)];
    self.lineImageView.backgroundColor = _lineColor;
    [self addSubview:self.lineImageView];
    
    for (int i = 0 ; i < _dataArray.count ; i++) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(i * width, 0, width, self.frame.size.height)];
        button.tag = i+1;
        button.backgroundColor = [UIColor clearColor];
        [button setTitle:[_dataArray objectAtIndex:i] forState:UIControlStateNormal];
        [button setTitleColor:self.textNomalColor    forState:UIControlStateNormal];
        [button setTitleColor:self.textSelectedColor forState:UIControlStateSelected];
        button.titleLabel.font = [UIFont systemFontOfSize:_titleFont];
        button.titleEdgeInsets = UIEdgeInsetsMake(-20, 0, 0, 0);
        [button addTarget:self action:@selector(tapAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];

        UILabel * numberLabel = [UILabel new];
        [self addSubview:numberLabel];
        [numberLabel makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(button.titleLabel.bottom).with.offset(GET_SCAlE_HEIGHT(5));
            make.centerX.mas_equalTo(button.centerX).with.offset(0);
        }];
        numberLabel.textColor = UIColorFromRGB(GRAYFONTCOLOR);
        numberLabel.font      = [UIFont systemFontOfSize:11];
        numberLabel.tag       = 201 + i;
        
        //默认第一个选中
        if (i == 0) {
            button.selected = YES;
            numberLabel.textColor = UIColorFromRGB(LIGHTBLUECOLOR);
        }
        else{
            button.selected = NO;
        }
        
        [self.buttonsArray addObject:button];
        
        
        
//        if (i != _dataArray.count || i != 0) {
//            UILabel *line = [[UILabel alloc ] initWithFrame:CGRectMake(i * width , 0, 0.45, 40)];
//            line.backgroundColor = [UIColor whiteColor];
//            [self bringSubviewToFront:line];
//            [self addSubview:line];
//        }
    }
}

-(void)tapAction:(id)sender{
    
    UIButton *button = (UIButton *)sender;
    
    [UIView animateWithDuration:0.2 animations:^{
        
        CGRect frame = self.lineImageView.frame;
        frame.origin.x = button.frame.origin.x;
        self.lineImageView.frame = frame;
        
    }];
    
    for (UIButton *subButton in self.buttonsArray) {
        
        if (button == subButton) {
            subButton.selected = YES;
            UILabel * numberLabel = [self viewWithTag:subButton.tag + 200];
            numberLabel.textColor = UIColorFromRGB(LIGHTBLUECOLOR);
        }
        else{
            subButton.selected = NO;
            UILabel * numberLabel = [self viewWithTag:subButton.tag + 200];
            numberLabel.textColor = UIColorFromRGB(GRAYFONTCOLOR);
        }
    }
    if ([self.delegate respondsToSelector:@selector(selectedIndex:)]) {
        [self.delegate selectedIndex:button.tag -1];
    }
}
-(void)selectIndex:(NSInteger)index
{
    for (UIButton *subButton in self.buttonsArray) {
        if (index != subButton.tag) {
            subButton.selected = NO;
        }
        else{
            subButton.selected = YES;
            [UIView animateWithDuration:0.2 animations:^{
                
                CGRect frame = self.lineImageView.frame;
                frame.origin.x = subButton.frame.origin.x;
                self.lineImageView.frame = frame;
                [self sendSubviewToBack:self.lineImageView];
                
            }];
        }
    }
}

#pragma mark - 自定义方法

-(void)setTextColor:(UIColor *)normalColor SelectedColor:(UIColor *)selectedColor NoticeViewColor:(UIColor *)noticeViewColor
{
    self.textNomalColor = normalColor;
    self.textSelectedColor = selectedColor;
    self.lineColor = noticeViewColor;
}

-(void)setNoticeType:(NoticeViewType)noticeViewType
{
    switch (noticeViewType) {
            
        case kNoticeTypeLine: {
            
            break;
        }
        case kNoticeTypeBackground: {
            
            CGRect frame = self.lineImageView.frame;
            frame.size.height = self.frame.size.height;
            frame.origin.y -= self.frame.size.height - 1;
            self.lineImageView.frame = frame;
            
            break;
        }
        default: {
            break;
        }
    }
}


#pragma mark - set
-(void)setLineColor:(UIColor *)lineColor{
    if (_lineColor != lineColor) {
        self.lineImageView.backgroundColor = lineColor;
        _lineColor = lineColor;
    }
}
-(void)setTextNomalColor:(UIColor *)textNomalColor{
    if (_textNomalColor != textNomalColor) {
        for (UIButton *subButton in self.buttonsArray){
            [subButton setTitleColor:textNomalColor forState:UIControlStateNormal];
        }
        _textNomalColor = textNomalColor;
    }
}
-(void)setTextSelectedColor:(UIColor *)textSelectedColor{
    if (_textSelectedColor != textSelectedColor) {
        for (UIButton *subButton in self.buttonsArray){
            [subButton setTitleColor:textSelectedColor forState:UIControlStateSelected];
        }
        _textSelectedColor = textSelectedColor;
    }
}
-(void)setTitleFont:(CGFloat)titleFont{
    if (_titleFont != titleFont) {
        for (UIButton *subButton in self.buttonsArray){
            subButton.titleLabel.font = [UIFont systemFontOfSize:titleFont] ;
        }
        _titleFont = titleFont;
    }
}

- (void)setCellwithNumberArr:(NSArray *)dataArray
{
    if (dataArray.count > 0) {
        for (NSInteger i = 0; i <_dataArray.count; i++) {
            if (dataArray.count <= _dataArray.count) {
                NSString * number = dataArray[i];
                UILabel * lab = [self viewWithTag:(201 + i)];
                lab.text = [NSString stringWithFormat:@"(%ld)",[number integerValue]];
            }
        }
    }else{
        for (NSInteger i = 0; i <_dataArray.count; i++) {

            UILabel * lab = [self viewWithTag:(201 + i)];
            lab.text = @"(0)";
        }
    }
}

@end
