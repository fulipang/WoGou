//
//  MyCommentViewController.h
//  HomeShopping
//
//  Created by sooncong on 16/1/10.
//  Copyright © 2016年 Administrator. All rights reserved.
//

#import "UITableBaseViewController.h"
#import "SegmentTapView.h"

/**
 *  评论类型
 */
typedef NS_ENUM(NSInteger, CommentStatus) {
    /**
     *  全部
     */
    kCommentStatusAll = 0,
    /**
     *  待评价
     */
    kCommentStatusWait,
    /**
     *  已评价
     */
    kCommentStatusDone,
};

@interface MyCommentViewController : UITableBaseViewController<SegmentTapViewDelegate>

/**
 *  表头分段控制器
 */
@property (nonatomic, strong) SegmentTapView * segmentHeaderView;

@end
