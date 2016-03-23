//
//  ImageScrollView.m
//  aoyouHH
//
//  Created by jinzelu on 15/5/25.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import "ImageScrollView.h"
#import "UIImageView+WebCache.h"

/**
 *  高度宏定义
 */
#define IMAGESCROLLVIEWHEIGHT 200

@interface ImageScrollView ()<UIScrollViewDelegate>
{
    NSTimer *_timer;
    NSInteger _pageNumber;
    
    imageScrollViewCallBackBlock _block;
}

@end

@implementation ImageScrollView

-(ImageScrollView *)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        /**
         *  创建scrollview
         */
        [self loadUpScrollViewWithFrame:frame];
        
        /**
         *  配置pagecontrol
         */
        [self loadUpPagecontrolWithFrame:frame];
        
    }
    return self;
}

#pragma mark - 装载自定义视图

- (void)loadUpScrollViewWithFrame:(CGRect)frame
{
    self.scrollView                                = [[UIScrollView alloc] initWithFrame:frame];
    self.scrollView.contentSize                    = CGSizeMake(4 * SCREEN_WIDTH, frame.size.height);
    self.scrollView.pagingEnabled                  = YES;
    self.scrollView.delegate                       = self;
    self.scrollView.showsHorizontalScrollIndicator = NO;
}

- (void)loadUpPagecontrolWithFrame:(CGRect)frame
{
    /**
     *  初始化 _pageControl 并添加到父视图上
     */
    self.pageControl = [UIPageControl new];
    [self addSubview:self.pageControl];
    
    /**
     *  位置设置
     *
     */
    [self.pageControl makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.bottom.mas_equalTo(self.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 30));
    }];
    
    /**
     *  基本配置
     */
    self.pageControl.currentPage     = 0;
    self.pageControl.backgroundColor = [UIColor clearColor];
    
    /**
     *  添加事件
     */
    [self addTimer];
}

#pragma mark - !!! 必须调用的方法 !!!
/**
 *  设置scrollview 图片
 *
 *  @param imageArray 图片数组
 */

-(void)setImageArray:(NSArray *)imageArray{
    
    self.scrollView.contentSize    = CGSizeMake(imageArray.count * SCREEN_WIDTH, self.frame.size.height);
    self.pageControl.numberOfPages = imageArray.count;
    _pageNumber = imageArray.count;
    
    if (imageArray.count > 0) {
        
        /**
         *  添加图片
         */
        for(int i = 0 ; i < imageArray.count; i++){

            UIImageView *imageView           = [[UIImageView alloc] init];
            imageView.image                  = [UIImage imageNamed:@"banner"];
            imageView.frame                  = CGRectMake(i * SCREEN_WIDTH, 0, SCREEN_WIDTH, self.frame.size.height);
            imageView.tag                    = i+10;
            UITapGestureRecognizer *tap      = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(OnTapImage:)];
            imageView.userInteractionEnabled = YES;
            tap.delegate = self;
            [imageView addGestureRecognizer:tap];
            [self.scrollView addSubview:imageView];
            
            
            /**
             *  重置scrollview 的 contentview
             */
            self.scrollView.contentSize = CGSizeMake( imageArray.count * SCREEN_WIDTH,self.frame.size.height);
            
            //        NSLog(@"%@",imageName);
            
            /**
             *  设置图片
             */
            
            id model = imageArray[i];
            
            if ([model isKindOfClass:[HSAdsLists class]]) {
                HSAdsLists * ads = (HSAdsLists *)model;
                [imageView sd_setImageWithURL:[NSURL URLWithString:ads.logo] placeholderImage:[UIImage imageNamed:@"banner"]];
            }
            else if ([model isKindOfClass:[NSString class]])
            {
                [imageView sd_setImageWithURL:[NSURL URLWithString:imageArray[i]] placeholderImage:[UIImage imageNamed:@"banner"]];
            }
            else
            {
                HPAddsModel * ads = (HPAddsModel *)model;
                [imageView sd_setImageWithURL:[NSURL URLWithString:ads.logo] placeholderImage:[UIImage imageNamed:@"banner"]];
            }
            
        }
    }
    
    [self addSubview:self.scrollView];
    
    [self bringSubviewToFront:self.pageControl];
}

-(void)callBackWithBlock:(imageScrollViewCallBackBlock)block
{
    _block = block;
}

#pragma mark - 处理事件
/**
 *  滚动视图上的iamgeview被点击时的触发方法
 *
 *  @param sender
 */
-(void)OnTapImage:(UITapGestureRecognizer *)sender
{
    UIImageView *imageView = (UIImageView *)sender.view;
    int tag = (int)imageView.tag - 10;
    
    
    [self.delegate didSelectImageAtIndex:tag];
    if (_block) {
        _block(tag);
    }
}

/**
 *  添加计时器
 */

-(void)addTimer
{
    
    if (_timer == nil) {
        
        _timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(netxPage) userInfo:nil repeats:YES];
    }
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}

/**
 *  移除计时器
 */
-(void)removeTimer
{
    [_timer invalidate];
    
    _timer = nil;
}

/**
 *  下一页
 */
-(void)netxPage
{
    int page = (int)self.pageControl.currentPage;
    
    if (page == _pageNumber - 1) {
        page = 0;
    }else{
        page++;
    }
    //滚动scrollview
    CGFloat x = page * self.scrollView.frame.size.width;
    [self.scrollView setContentOffset:CGPointMake(x, 0) animated:NO];
}

#pragma mark - UIScrollViewDelegate

/**
 *  正在滑动时的代理方法
 *
 *  在此更改pagecontrol的当前页
 *
 *  @param scrollView
 */
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat scrollViewW = scrollView.frame.size.width;
    CGFloat x = scrollView.contentOffset.x;
    int page = (x + scrollViewW/2)/scrollViewW;
    self.pageControl.currentPage = page;
}

/**
 *  开始拖动的代理方法
 *
 *  @param scrollView
 */
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self removeTimer];
}

/**
 *  拖动结束的代理方法
 *
 *  @param scrollView
 *  @param decelerate
 */
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self addTimer];
}

-(void)dealloc{
    [self removeTimer];
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}


@end