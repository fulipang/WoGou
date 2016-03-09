//
//  AppInformationSingleton.h
//  HomeShopping
//
//  Created by Administrator on 15/12/9.
//  Copyright (c) 2015年 Administrator. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MKReverseGeocoder.h>
#import <CoreLocation/CoreLocation.h>
#import "HSProduct.h"

typedef void (^locationInfomation)(NSDictionary *locationDictionary);
typedef void (^cityInformation)(NSDictionary *locationDictionary);

@interface AppInformationSingleton : NSObject
{
    
    /**
     * 保存单例中数据字典
     */
    NSMutableDictionary *_saveDataDic;
    /**
     * 保存商品浏览历史
     */
    NSMutableArray *_commodityHistory;

    NSMutableArray * _cityCodeList;
}



#pragma mark - 用户相关

/**
 *  设置但李忠保存的userid 存到本地
 *
 *  @param userId
 */
- (void)setUserID:(NSString *)userId;

/**
 *  获取登陆后存储的用户id
 *
 *  @return useId
 */
- (NSString *)getUserID;


/**
 * @brief : 在单例中保存用户登录后获取的token值，并实例化到本地
 * @param : 用户登录后获取的token
 * @return: 无
 */
- (void)setLoginCode:(NSString *)code;

/**
 * @brief : 获取单例中登录后存储的token
 * @param : 无
 * @return: 单例中持有的用户token
 */
- (NSString *)getLoginCode;

/**
 *  用户登出
 */
- (void)logOutUser;

#pragma mark - 历史浏览

/**
 * @brief : 将浏览的商品存入浏览历史
 * @param : 参数为商品信息字典
 * @return: 无
 */
- (void)setBrowseHistory:(id)shopInfo;

/**
 *  删除某个历史记录
 *
 *  @param index 下标
 */
- (void)deleteBrowseHistoryAtIndex:(NSInteger)index;

/**
 *  删除所有历史浏览记录
 */
- (void)deleteAllBrowseHistory;

/**
 * @brief : 获取商家浏览历史,最多十条
 * @param : 无
 * @return: 商家浏览历史,最多十条
 */
- (NSArray *)getBrowseHistory;

#pragma mark -

/**
 *  存储定位信息
 */
- (void)setLocationInfoWithCityName:(NSString *)cityName CityCode:(NSString *)cityCode Longitude:(NSString *)longitude Latitude:(NSString *)latitude;

/**
 *  获取定位信息
 *
 *  @return 定位信息字典
 */
- (NSDictionary *)getLocationInfo;

/**
 *  把用于获取citydode的数组
 */
- (void)setCityCodeListWithDictionary:(NSDictionary *)cityCodeDic;

/**
 *  获取citycode列表文件
 *
 *  @return 用于查询城市代码的数组
 */
- (NSDictionary *)getCityCodeList;

#pragma mark -

- (void)setSelctedCityName:(NSString *)cityName CityCode:(NSString *)cityCode;

- (NSDictionary *)getSelectedCityNameAndCityCode;


#pragma mark -

/**
 * @brief : 获取单例的实例化对象
 * @param : 无
 * @return: 单例类的实例化对象
 */
+ (AppInformationSingleton *)shareAppInfomationSingleton;

///**
// * @brief : 通过调用系统定位获取location的详细信息
// * @param : 回调Block
// * @return: 无
// */
//- (void)getLocation:(locationInfomation)locationInfo;
//
///**
// * @brief : 获取本地序列化的定位location信息
// * @param : 无
// * @return: 本地序列化的定位location信息
// */
//- (NSDictionary *)getPositionLocation;
//
///**
// * @brief : 根据所给定的城市名称，区名，街道名 反向解析出经纬度
// * @param : city 城市名称 subLocality 区名 thoroughfare 街道名 CityInformation 回调Block
// * @return: 无
// */
//- (void)getLocationWithCity:(NSString *)city WithSubLocality:(NSString *)subLocality WithThoroughfare:(NSString *)thoroughfare WithCallBack:(cityInformation)CityInformation;
//
///**
// * @brief : 获取当前单例中存储的用户手动选择的地理位置信息
// * @param : 无
// * @return：当前单例中存储的用户手动选择的地理位置信息
// */
//- (NSDictionary *)getKeepLocationInfo;



@end
