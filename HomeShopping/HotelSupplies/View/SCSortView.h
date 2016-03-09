//
//  SCSortView.h
//  HomeShopping
//
//  Created by sooncong on 16/1/5.
//  Copyright © 2016年 Administrator. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductSortModel.h"

/**
 *  回调block
 *
 *  @param diliverDictionary 用于储存筛选字段的字典
 */
typedef void(^SCSortCallBackBlock)(NSDictionary * diliverDictionary);

/**
 *  记录当前选中状态
 */
typedef NS_ENUM(NSInteger, currentSelected) {
    /**
     *  选中主表视图
     */
    kSelectedMain = 0,
    /**
     *  选中副表视图
     */
    kSelectedSub,
};

/**
 *  筛选类型
 */
typedef NS_ENUM(NSInteger, ProductSortType) {
    /**
     *  价格
     */
    kSortTypePrice = 0,
    /**
     *  返购逼
     */
    kSortTypeCoinReturn,
    /**
     *  品牌
     */
    kSortTypeProductBrand,
    /**
     *  换购积分
     */
    kSortTypeCoinPrice,
    
    kSortTypeNeedBook,
};

@protocol SCSortViewDlegate <NSObject>

@optional

/**
 *  回传筛选结果代理方法
 */
- (NSDictionary *)getSortDictionary;

@end

@interface SCSortView : UIView <UITableViewDataSource,UITableViewDelegate>

/**
 *  代理
 */
@property (nonatomic, assign) id<SCSortViewDlegate> delegate;

/**
 *  主表视图
 */
@property (nonatomic, strong) UITableView * mainTableView;

/**
 *  副表视图
 */
@property (nonatomic, strong) UITableView * subTableView;

///**
// *  回调block
// */
//@property (nonatomic, assign) SCSortCallBackBlock callBackBlock;

/**
 *  设置参数
 *
 *  @param model 筛选模型
 */
-(void)setParameterWithModle:(ProductSortModel *)model NeedBook:(BOOL)needBook;

/**
 *  回调方法
 *
 *  @param block 
 */
- (void)callBackWithBlock:(SCSortCallBackBlock)block;

@end
