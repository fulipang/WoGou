//
//  UIView+PFL.m
//  QianHaiWallet
//
//  Created by pfl on 15/11/23.
//  Copyright © 2015年 QianHai Electronic Pay. All rights reserved.
//

#import "UIView+PFL.h"

@implementation UIView (PFL)


- (void)setX:(CGFloat)x {
    self.frame = CGRectMake(x, self.y, self.widthX, self.heightY);
}

- (void)setY:(CGFloat)y {
    self.frame = CGRectMake(self.x, y, self.widthX, self.heightY);
}


- (CGFloat)x {
    return self.frame.origin.x;
}

- (CGFloat)y {
    return self.frame.origin.y;
}

- (void)setHeightY:(CGFloat)height {
    self.frame = CGRectMake(self.x, self.y, self.widthX, height);
}

- (void)setWidthX:(CGFloat)width {
    self.frame = CGRectMake(self.x, self.y, width,self.heightY);
}

- (CGFloat)widthX {
    return CGRectGetWidth(self.frame);
}

- (CGFloat)heightY {
    return CGRectGetHeight(self.frame);
}


- (void)setLeftX:(CGFloat)left {
    self.frame = CGRectMake(left, self.y, self.widthX, self.heightY);
}
- (CGFloat)leftX {
    return self.x;
}

- (void)setRightX:(CGFloat)right {
    self.frame = CGRectMake(right - self.widthX, self.y, self.widthX, self.heightY);
}
- (CGFloat)rightX {
    return self.x + self.widthX;
}

- (void)setBottomY:(CGFloat)bottom {
    self.frame = CGRectMake(self.x, bottom - self.heightY, self.widthX, self.heightY);
}

- (CGFloat)bottomY {
    return self.y + self.heightY;
}

- (void)setTopY:(CGFloat)top {
    [self setY:top];
}
- (CGFloat)topY {
    return self.y;
}

- (void)setCenterX_:(CGFloat)centerX {
    self.center = CGPointMake(centerX, self.centerY_);
}

- (CGFloat)centerX_ {
    return self.x + self.widthX/2;
}

- (void)setCenterY_:(CGFloat)centerY {
    self.center = CGPointMake(self.centerX_, centerY);
}

- (CGFloat)centerY_ {
    return self.y + self.heightY/2;
}

- (void)setCenter_:(CGPoint)center_ {
    self.center = center_;
}

- (CGPoint)center_ {
    return self.center;
}

- (void)setOrigin:(CGPoint)origin {
    self.frame = CGRectMake(origin.x, origin.y, self.widthX, self.heightY);
}

- (CGPoint)origin {
    return self.frame.origin;
}

- (void)setSize:(CGSize)size {
    self.frame = CGRectMake(self.x, self.y, size.width, size.height);
}

- (CGSize)size {
    return self.frame.size;
}






@end





