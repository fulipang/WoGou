//
//  RoomReserVationDetailViewController.h
//  HomeShopping
//
//  Created by sooncong on 16/1/12.
//  Copyright © 2016年 Administrator. All rights reserved.
//

#import "UITableBaseViewController.h"
#import "HSProduct.h"
#import "Hotels.h"
#import "SegmentTapView.h"
#import "HPPossibleLikeModel.h"

@interface RoomReserVationDetailViewController : UITableBaseViewController

/**
 *  自定义分页控制器
 */
//@property (nonatomic, strong) SegmentTapView * segMentTapView;

/**
 *  左侧表视图
 */
@property (nonatomic, strong) UITableView * leftTableView;

/**
 *  入住日期标签
 */
@property (nonatomic, strong) UILabel * dayBeginLabel;


/**
 *  离店日期标签
 */
@property (nonatomic, strong) UILabel * datEndLabel;

/**
 *  显示一共住几日标签
 */
@property (nonatomic, strong) UILabel * totalDaysLabel;

/**
 *  初始化方法
 *
 *  @param product 商品模型
 *
 *  @return
 */
-(instancetype)initWithProduct:(id)product;

-(instancetype)initWithSellerID:(NSString *)sellerID;

-(instancetype)initWithHotelModel:(Hotels *)hotel;

@end
