//
//  PreviewController.m
//  HomeShopping
//
//  Created by pfl on 16/1/17.
//  Copyright © 2016年 Administrator. All rights reserved.
//

#import "PreviewController.h"
#import "UIView+PFL.h"

@interface PreviewController ()<UIScrollViewDelegate>
@property (nonatomic, readwrite, weak) UIViewController *parentController;

/// 蒙版
@property (nonatomic, readwrite, strong) UIView *coverView;

/// 预览
@property (nonatomic, readwrite, strong) UIScrollView *scrollView;

/// 计数
@property (nonatomic, readwrite, strong) UILabel *countLabel;

/// 页数
@property (nonatomic, readwrite, copy) NSString *indexStr;

@end

@implementation PreviewController

- (instancetype)initWithParentViewController:(UIViewController *)parentViewController {
    if (self = [super initWithNibName:nil bundle:nil]) {
        _parentController = parentViewController;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupSubViews];
}


/// 添加进入父控制器
- (void)didMoveToParentViewController {
    [self.parentController addChildViewController:self];
    [self didMoveToParentViewController:self.parentController];
    [self.parentController.view addSubview:self.view];
}

/// 移除出父控制器
- (void)didRemoveFromParentViewController {
    [self.view removeFromSuperview];
    [self willMoveToParentViewController:self.parentController];
    [self removeFromParentViewController];
    
}


- (void)setupSubViews {
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:self.coverView];
    [self.coverView addSubview:self.countLabel];
    [self.coverView addSubview:self.scrollView];

}


- (UIView *)coverView {
    if (!_coverView) {
        _coverView = [[UIView alloc] initWithFrame:[[UIScreen mainScreen]bounds]];
        _coverView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.8];
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(10, 40, 40, 40)];
        [btn addTarget:self action:@selector(didRemoveFromParentViewController) forControlEvents:UIControlEventTouchUpInside];
        [btn setImage:[UIImage imageNamed:@"NavBar_Back"] forState:UIControlStateNormal];
        [_coverView addSubview:btn];
    }
    return _coverView;
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView  = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT/2)];
        _scrollView.centerY_ = self.coverView.heightY/2;
        [_scrollView setContentSize:CGSizeMake(SCREEN_WIDTH*self.imageArr.count, _scrollView.heightY)];
        _scrollView.delegate = self;
        _scrollView.pagingEnabled = YES;
        [self addImageViewToScrollView:_scrollView];
    }
    return _scrollView;
}

- (void)addImageViewToScrollView:(UIScrollView*)scrollView {
    for (int i = 0; i < self.imageArr.count; i++) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(scrollView.widthX*i, 0, scrollView.widthX, scrollView.heightY)];
        
        NSString * str = [self.imageArr[i] stringByReplacingOccurrencesOfString:@" " withString:@""];
        
        [imageView sd_setImageWithURL:[NSURL URLWithString:str] placeholderImage:[UIImage imageNamed:@"headimage"]];
        [scrollView addSubview:imageView];
    }
}

- (UILabel *)countLabel {
    if (!_countLabel) {
        _countLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.coverView.widthX, 44)];
        _countLabel.bottomY = self.coverView.heightY;
        _countLabel.text = [NSString stringWithFormat:@"1/%ld",self.imageArr.count];
        _countLabel.textAlignment = NSTextAlignmentRight;
        _countLabel.font = [UIFont systemFontOfSize:16];
        _countLabel.textColor = [UIColor whiteColor];
        _countLabel.backgroundColor = [UIColor blackColor];
    }
    return _countLabel;
}

- (void)setIndexStr:(NSString *)indexStr {
    if (_indexStr != indexStr) {
        _indexStr = indexStr;
        self.countLabel.text = [[indexStr stringByAppendingString:@"/"] stringByAppendingString:@(self.imageArr.count).stringValue];
    }
}

#pragma mark UIScrollViewDelegate 

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger index = scrollView.contentOffset.x / scrollView.widthX;
    self.indexStr = @(index+1).stringValue;
    
}





@end











