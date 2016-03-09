//
//  SCHomeShowCell.h
//  HomeShopping
//
//  Created by sooncong on 15/12/9.
//  Copyright © 2015年 Administrator. All rights reserved.
//

/**
 *
 *  首页分类展示使用
 *
 *  SHOWCELLHEIGHT 为cell高度定义的宏
 *
 */

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, HomeShowClickType)
{
    kClickBedding = 0,          //床上用品
    kClickToothBrush,           //洗刷用品
    kClickBathroom,             //浴室
    kClickLight,                //灯饰
    kClickHotelOneStar,         //一星酒店
    kClickHotelTwoStar,         //二星酒店
    kClickHotelThreeStar,       //三星酒店
    kClickHotelFiveStar,        //五星酒店
};

/**
 *  按钮点击回调
 *
 *  @param clickType 按钮点击类型
 */
typedef void(^HomeShowCallBackBlock)(HomeShowClickType clickType);

@interface SCHomeShowCell : UITableViewCell

/**
 *  按钮名称数组
 */
@property (nonatomic, strong) NSMutableArray * buttonTitles;

/**
 *  按钮图片数组
 */
@property (nonatomic, strong) NSMutableArray * buttonImages;

/**
 *  点击事件回调方法
 *
 *  @param callBackBlock 
 */
- (void)callBackWithBlock:(HomeShowCallBackBlock)callBackBlock;

/**
 *  设置cell方法
 *
 *  @param categoryData 栏目数据源
 */
- (void)setCellWithData:(NSArray *)categoryData;


@end
