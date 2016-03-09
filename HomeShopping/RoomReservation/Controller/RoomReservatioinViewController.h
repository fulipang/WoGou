//
//  RoomReservatioinViewController.h
//  HomeShopping
//
//  Created by sooncong on 15/12/28.
//  Copyright © 2015年 Administrator. All rights reserved.
//

#import "UITableBaseViewController.h"
#import "SegmentTapView.h"
#import "SCTableSlectionView.h"
#import "SCSingleTableSelcetionView.h"

@class ImageScrollView;

/**
 *  订房首页segment点击类型
 */
typedef NS_ENUM(NSInteger, RoomReservationTapType) {
    /**
     *  默认排序
     */
    kTapDefaultSort = 0,
    /**
     *  商圈
     */
    kTapBusinessCircle,
    /**
     *  全部
     */
    kTapAll,
    /**
     *  帅选
     */
    kTapSort,
};


@interface RoomReservatioinViewController : UITableBaseViewController<UITableViewDataSource,UITableViewDelegate,SegmentTapViewDelegate,SCTableSelectionViewDelegate,SCSingleTableSelcetionViewDelegate>

@property (nonatomic, strong) ImageScrollView *topImageScrollView;

@end
