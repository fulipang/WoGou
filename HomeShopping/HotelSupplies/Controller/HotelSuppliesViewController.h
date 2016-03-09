//
//  HotelSuppliesViewController.h
//  HomeShopping
//
//  Created by sooncong on 15/12/11.
//  Copyright © 2015年 Administrator. All rights reserved.
//

#import "UIBaseViewController.h"

@class ImageScrollView;

@interface HotelSuppliesViewController : UIBaseViewController<UICollectionViewDataSource,UICollectionViewDelegate,UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate>

/**
 *  导航条搜索栏
 */
@property (nonatomic, strong) UISearchBar * searchBar;

@property(nonatomic,assign)NSInteger choice;

/**
 *  上面滚动视图
 */
@property (nonatomic,strong) ImageScrollView * topImageScrollView;

/**
 *  左侧tableview
 */
@property (nonatomic,strong) UITableView * leftTableView;

//左侧滚动视图
@property(nonatomic, strong)UIScrollView* leftScrollView;
@property(nonatomic, retain)NSMutableArray* leftViewCellArray;
@property(nonatomic,retain)NSArray* leftDataArray;//左侧数据

//右侧种类视图
@property(nonatomic, strong)UICollectionView* collectionView;

#pragma mark -

@property(nonatomic,retain)NSMutableArray* productArray;
@property(nonatomic,retain)UIImageView* scanView;//扫描视图

@property(nonatomic,retain)UIImageView* baseView;

@end
