//
//  ImageScrollCell.h
//  aoyouHH
//
//  Created by jinzelu on 15/5/25.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageScrollView.h"

typedef void(^imageScrollViewCallBackBlock)(NSInteger index);

@interface ImageScrollCell : UITableViewCell <ImageScrollViewDelegate>

/**
 *  滚动视图
 */
@property(nonatomic, strong) ImageScrollView *imageScrollView;

/**
 *  回调block
 */
@property (nonatomic, strong) imageScrollViewCallBackBlock callBackBlock;

/**
 *  设置scrollviewcell 的图片
 *
 *  @param imageArray 存储图片URL的数组
 */
-(void)setImageArray:(NSArray *)imageArray;

/**
 *  回调方法
 *
 *  @param block 回调块代码
 */
-(void)callBackMethod:(imageScrollViewCallBackBlock)block;

/**
 *  设置高度
 *
 *  @param height 
 */
- (void)setCellHeight:(CGFloat)height;

@end
