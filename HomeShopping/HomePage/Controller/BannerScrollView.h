//
//  BannerScrollView.h
//  HomeShopping
//
//  Created by dongbailan on 16/3/24.
//  Copyright © 2016年 Administrator. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BannerScrollView : UIView
@property (nonatomic, readonly, strong) UICollectionView *collectionView;
@property (nonatomic, readonly, strong) NSTimer *timer;
@property (nonatomic, readwrite, copy) NSArray *dataSource;
@end
