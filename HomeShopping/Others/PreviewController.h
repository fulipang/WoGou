//
//  PreviewController.h
//  HomeShopping
//
//  Created by pfl on 16/1/17.
//  Copyright © 2016年 Administrator. All rights reserved.
//

#import "UIBaseViewController.h"

@interface PreviewController : UIViewController

/// 预览的图片数组
@property (nonatomic, readwrite, copy) NSArray *imageArr;


/// 初始化控制器
- (instancetype)initWithParentViewController:(UIViewController*)parentViewController;

// 添加进父控制器
- (void)didMoveToParentViewController;

/// 移除出父控制器
//- (void)didRemoveFromParentViewController;

@end
