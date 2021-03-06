//
//  UIView+PFL.h
//  QianHaiWallet
//
//  Created by pfl on 15/11/23.
//  Copyright © 2015年 QianHai Electronic Pay. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (PFL)
/**
 *  原点x
 */
@property (nonatomic, readwrite, assign) CGFloat x;
/**
 *  原点y
 */
@property (nonatomic, readwrite, assign) CGFloat y;
/**
 *  最大左边
 */

@property (nonatomic, readwrite, assign) CGFloat leftX;
/**
 *  最大右边
 */
@property (nonatomic, readwrite, assign) CGFloat rightX;
/**
 *  控件宽
 */
@property (nonatomic, readwrite, assign) CGFloat widthX;
/**
 *  控件高
 */
@property (nonatomic, readwrite, assign) CGFloat heightY;
/**
 *  中点x
 */
@property (nonatomic, readwrite, assign) CGFloat centerX_;
/**
 *  中点Y
 */
@property (nonatomic, readwrite, assign) CGFloat centerY_;
/**
 *  中点
 */
@property (nonatomic, readwrite, assign) CGPoint center_;

/**
 *  顶部
 */
@property (nonatomic, readwrite, assign) CGFloat topY;

/**
 *  底部
 */
@property (nonatomic, readwrite, assign) CGFloat bottomY;

/**
 *  size
 */
@property (nonatomic, readwrite, assign) CGSize size;
/**
 *  原点
 */
@property (nonatomic, readwrite, assign) CGPoint origin;


@end














