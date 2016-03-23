//
//  ImageScrollView.h
//  aoyouHH
//
//  Created by jinzelu on 15/5/25.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HSAdsLists.h"
#import "HPAddsModel.h"


typedef void(^imageScrollViewCallBackBlock)(NSInteger index);

@protocol ImageScrollViewDelegate <NSObject>

//@required
-(void)didSelectImageAtIndex:(NSInteger)index;

@end

@interface ImageScrollView : UIView<UIGestureRecognizerDelegate>

@property(nonatomic, strong) UIScrollView *scrollView;
@property(nonatomic, strong) UIPageControl *pageControl;
@property(nonatomic, strong) NSArray *imgArray;
@property(nonatomic, assign) id<ImageScrollViewDelegate> delegate;

-(void)setImageArray:(NSArray *)imageArray;

- (void)callBackWithBlock:(imageScrollViewCallBackBlock)block;


@end
