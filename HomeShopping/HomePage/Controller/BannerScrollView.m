//
//  BannerScrollView.m
//  HomeShopping
//
//  Created by dongbailan on 16/3/24.
//  Copyright © 2016年 Administrator. All rights reserved.
//

#import "BannerScrollView.h"
#import "HPAddsModel.h"
#import "HSAdsLists.h"


@interface BannerScrollView()<UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic, readwrite, strong) UICollectionView *collectionView;
@property (nonatomic, readwrite, strong) NSTimer *timer;
@property (nonatomic, readwrite, assign) NSInteger currentPage;
@property (nonatomic, readwrite, strong) UIPageControl *pageControl;
@end

@implementation BannerScrollView


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.collectionView];
        [self timer];
        [self addSubview:self.pageControl];
    }
    return self;
}

- (void)setDataSource:(NSArray *)dataSource {
    _dataSource = dataSource;
    self.pageControl.numberOfPages = dataSource.count;
    [self.collectionView setContentSize:CGSizeMake(dataSource.count*100*SCREEN_WIDTH, self.bounds.size.height)];
    [self.collectionView setContentOffset:CGPointMake(dataSource.count*49*SCREEN_WIDTH, 0)];
    [self.collectionView reloadData];
}

#pragma mark override

- (UIPageControl *)pageControl {
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectZero];
//        [self addSubview:_pageControl];

        _pageControl.autoresizingMask =  UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin;
        _pageControl.centerX_ = self.centerX_;
        _pageControl.bottomY = self.bounds.size.height-20;
        _pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
        _pageControl.pageIndicatorTintColor = [UIColor grayColor];
    }
    return _pageControl;
}

- (NSTimer*)timer {
    if (!_timer) {
        _timer = [NSTimer timerWithTimeInterval:5 target:self selector:@selector(autoPlay) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    }
    
    return _timer;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.minimumLineSpacing = 0.f;
        layout.minimumInteritemSpacing = 0.f;
        layout.itemSize = CGSizeMake(SCREEN_WIDTH, 200);
        _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.pagingEnabled = YES;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleHeight;


        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    }
    return _collectionView;
}


#pragma mark UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSource.count*100;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    
    UIImageView *imageView = [cell.contentView viewWithTag:100];
    if (!imageView) {
        imageView = [[UIImageView alloc] initWithFrame:cell.contentView.bounds];
        imageView.tag = 100;
        [cell.contentView addSubview:imageView];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.autoresizingMask = collectionView.autoresizingMask;
    }
    
    id model = self.dataSource[indexPath.row%self.dataSource.count];
    if ([model isKindOfClass:[HSAdsLists class]]) {
        HSAdsLists * ads = (HSAdsLists *)model;
        [imageView sd_setImageWithURL:[NSURL URLWithString:ads.logo] placeholderImage:[UIImage imageNamed:@"banner"]];
    }
    else if ([model isKindOfClass:[NSString class]])
    {
        [imageView sd_setImageWithURL:[NSURL URLWithString:self.dataSource[indexPath.row%self.dataSource.count]] placeholderImage:[UIImage imageNamed:@"banner"]];
    }
    else
    {
        HPAddsModel * ads = (HPAddsModel *)model;
        [imageView sd_setImageWithURL:[NSURL URLWithString:ads.logo] placeholderImage:[UIImage imageNamed:@"banner"]];
        
    }
    
    return cell;
}



#pragma mark Actions 

- (void)autoPlay {
    self.currentPage++;
    self.currentPage = MAX(0, self.currentPage);
    self.currentPage = MIN(self.currentPage, self.dataSource.count*100);
    self.pageControl.currentPage = self.currentPage%self.dataSource.count;
    [self.collectionView setContentOffset:CGPointMake(self.currentPage*SCREEN_WIDTH, 0) animated:YES];
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (_timer) {
        [_timer invalidate];
        self.timer = nil;
    }
    
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    self.currentPage = scrollView.contentOffset.x/SCREEN_WIDTH;
    self.pageControl.currentPage = self.currentPage%self.dataSource.count;
    [self timer];

}


@end







