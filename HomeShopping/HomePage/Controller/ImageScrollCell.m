//
//  ImageScrollCell.m
//  aoyouHH
//
//  Created by jinzelu on 15/5/25.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import "ImageScrollCell.h"

#define BANNERSCROLLHEIGHT 200

@implementation ImageScrollCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        self.imageScrollView = [[ImageScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, BANNERSCROLLHEIGHT)];
                
        [self.contentView addSubview:self.imageScrollView];
        
        //设置代理
        self.imageScrollView.delegate = self;
        
        self.contentView.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

#pragma mark - 事件

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

-(void)setImageArray:(NSArray *)imageArray{
    [self.imageScrollView setImageArray:imageArray];
}

- (void)setCellHeight:(CGFloat)height
{
    CGRect frame = self.imageScrollView.frame;
    frame.size.height = height;
    self.imageScrollView.frame = frame;
}

#pragma mark - 回调

-(void)callBackMethod:(imageScrollViewCallBackBlock)block
{
    self.callBackBlock = block;
}

-(void)didSelectImageAtIndex:(NSInteger)index
{
    NSLog(@"%s",__func__);
    
    if (self.callBackBlock) {
        self.callBackBlock(index);
    }
}

@end
