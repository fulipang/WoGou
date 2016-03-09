//
//  AppInformationSingleton.m
//  HomeShopping
//
//  Created by Administrator on 15/12/9.
//  Copyright (c) 2015年 Administrator. All rights reserved.
//

#import "AppInformationSingleton.h"
#import "MapCoordinateTransformation.h"
#import "ProductDetail.h"
#import "HotelDetailModel.h"

#define GETCITYLIST @"cityList"
#define PORT @"8901"
typedef void (^locationHandler)(CLLocation *currentLocation);
@interface AppInformationSingleton()<CLLocationManagerDelegate>
{
    
    locationHandler _locationHandler;
    locationInfomation _locationInfomation;
    CLLocationManager *_locationManager;
    NSString *_locationDominIP;
}
//@property (nonatomic,strong)locationHandler locationHandler;
@end

static AppInformationSingleton *_singleton = NULL;

@implementation AppInformationSingleton

+ (AppInformationSingleton *)shareAppInfomationSingleton{
    if (nil == _singleton)
    {
        _singleton = [[self alloc] init];
        
    }
    return _singleton;
}

+ (id)alloc {
    
    @synchronized (self) {
        
        if (nil == _singleton) {
            _singleton = [super alloc];
        }
    }
    return _singleton;
}

#pragma mark -

-(void)setUserID:(NSString *)userId
{
    @synchronized(self){
        if (nil == _saveDataDic) {
            _saveDataDic = [[NSMutableDictionary alloc] initWithCapacity:1];
        }
        
        if ([userId isKindOfClass:[NSString class]]) {
            NSDate *effectiveDate = [[NSDate alloc] initWithTimeIntervalSinceNow:(60 * 60 * 24 * 30)];
            NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
            [user setObject:effectiveDate forKey:@"CODEEFFECTIVEDATE"];
            
            [user setObject:userId forKey:@"USERID"];
            [user synchronize];
            [_saveDataDic setObject:userId forKey:@"USERID"];
            
        }
    }
}

-(NSString *)getUserID
{
    NSString *userId;
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    @synchronized(self){
        NSDate *currentDate = [NSDate date];
        NSDate *effectiveDate = [user objectForKey:@"CODEEFFECTIVEDATE"];
        if ([effectiveDate isEqualToDate:[currentDate laterDate:effectiveDate]]) {
            userId = [user objectForKey:@"USERID"];
            return userId;
            
        }else{
            //            USERID无效
            [user removeObjectForKey:@"USERID"];
            [user removeObjectForKey:@"CODEEFFECTIVEDATE"];
            [user synchronize];
            return nil;
            
        }
        return userId;
    }
}

- (void)setLoginCode:(NSString *)code{
    @synchronized(self){
        if (nil == _saveDataDic) {
            _saveDataDic = [[NSMutableDictionary alloc] initWithCapacity:1];
        }
        
        if ([code isKindOfClass:[NSString class]]) {
            NSDate *effectiveDate = [[NSDate alloc] initWithTimeIntervalSinceNow:(60 * 60 * 24 * 30)];
            NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
            [user setObject:effectiveDate forKey:@"CODEEFFECTIVEDATE"];
            
            [user setObject:code forKey:@"CODE"];
            [user synchronize];
            [_saveDataDic setObject:code forKey:@"CODE"];
            
        }
    }
}

//获取登录后的code
- (NSString *)getLoginCode{
    
    NSString *codeSrt;
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    @synchronized(self){
        NSDate *currentDate = [NSDate date];
        NSDate *effectiveDate = [user objectForKey:@"CODEEFFECTIVEDATE"];
        if ([effectiveDate isEqualToDate:[currentDate laterDate:effectiveDate]]) {
            //            有效时间靠后，说明code有效
            codeSrt = [user objectForKey:@"CODE"];
            return codeSrt;
            
        }else{
            //            code无效
            [user removeObjectForKey:@"CODE"];
            [user removeObjectForKey:@"CODEEFFECTIVEDATE"];
            [user synchronize];
            return nil;
            
        }
        return codeSrt;
    }
}

- (void)logOutUser
{
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    [user removeObjectForKey:@"CODE"];
    [user removeObjectForKey:@"USERID"];
    [user synchronize];
}

#pragma mark - 历史记录

- (void)deleteBrowseHistoryAtIndex:(NSInteger)index
{
    @synchronized(self){
        
        NSString *rootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES) objectAtIndex:0];
        
        NSString *plistPath = [rootPath stringByAppendingPathComponent:@"BrowseHistoryData.plist"];
        
        if (!_commodityHistory) {
            
            //        将浏览历史写入沙盒中
            
            NSArray *tempArr = [self returnListWithDataPath:plistPath];
            
            if ([tempArr isKindOfClass:[NSArray class]]) {
                if (tempArr.count > 0) {
                    
                    _commodityHistory = [[NSMutableArray alloc] initWithArray:tempArr];
                    
                }
            }
        }
        
        NSFileManager *fileManager = [NSFileManager defaultManager];
        if ([fileManager fileExistsAtPath:plistPath]) {
            
            [fileManager removeItemAtPath:plistPath error:nil];
        }
        if (_commodityHistory) {

            [_commodityHistory removeObjectAtIndex:index];
            
            NSData *historyData = [self returnDataWithList:_commodityHistory];
            if (historyData) {
                [historyData writeToFile:plistPath atomically:YES];
                
            }
        }
    }
    
}

-(void)deleteAllBrowseHistory
{
    @synchronized(self) {
        
        NSString *rootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES) objectAtIndex:0];
        
        NSString *plistPath = [rootPath stringByAppendingPathComponent:@"BrowseHistoryData.plist"];
        
        if (!_commodityHistory) {
            
            //        将浏览历史写入沙盒中
            
            NSArray *tempArr = [self returnListWithDataPath:plistPath];
            
            if ([tempArr isKindOfClass:[NSArray class]]) {
                if (tempArr.count > 0) {
                    
                    _commodityHistory = [[NSMutableArray alloc] initWithArray:tempArr];
                    
                }
            }
        }
        
        NSFileManager *fileManager = [NSFileManager defaultManager];
        if ([fileManager fileExistsAtPath:plistPath]) {
            
            [fileManager removeItemAtPath:plistPath error:nil];
        }
        if (_commodityHistory) {
            
            [_commodityHistory removeAllObjects];
            
            NSData *historyData = [self returnDataWithList:_commodityHistory];
            if (historyData) {
                [historyData writeToFile:plistPath atomically:YES];
                
            }
        }
    }
}

-(NSDictionary *)getCityCodeList
{
    
        NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
        
        NSDictionary * citycodeList = [user objectForKey:@"CITYCODELIST"];
        
        if (citycodeList) {
            return citycodeList;
        }else{
            return [[NSDictionary alloc] init];
        }
}

- (void)setCityCodeListWithDictionary:(NSDictionary *)cityCodeDic
{
            NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
            
            [user setObject:cityCodeDic forKey:@"CITYCODELIST"];
            [user synchronize];

}

- (void)setBrowseHistory:(id)shopInfo{
    @synchronized(self){
        if ([shopInfo isKindOfClass:[shopInfo class]]) {
            
            NSString *rootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES) objectAtIndex:0];
            
            NSString *plistPath = [rootPath stringByAppendingPathComponent:@"BrowseHistoryData.plist"];
            
            if (!_commodityHistory) {
                
                //        将浏览历史写入沙盒中
                
                NSArray *tempArr = [self returnListWithDataPath:plistPath];
                
                if (tempArr) {
                    if ([tempArr isKindOfClass:[NSArray class]]) {
                        if (tempArr.count > 0) {
                            
                            _commodityHistory = [[NSMutableArray alloc] initWithArray:tempArr];
                        }
                    }
                }else{
                    _commodityHistory = [[NSMutableArray alloc] initWithCapacity:10];
                }
            }
            NSMutableDictionary *commodityDic = [[NSMutableDictionary alloc] initWithCapacity:1];
            
            
            //            if (_commodityHistory.count < 10) {
            //                [_commodityHistory insertObject:commodityDic atIndex:0];
            //            }else{
            //                [_commodityHistory removeObjectAtIndex:9];
            //                [_commodityHistory insertObject:commodityDic atIndex:0];
            //
            //            }
            if ([shopInfo isKindOfClass:[ProductDetail class]]) {
                
                ProductDetail * model = (ProductDetail *)shopInfo;
                commodityDic = (NSMutableDictionary *)[model dictionaryRepresentation];
                
                for (NSDictionary * product in _commodityHistory) {
                    if ([product isKindOfClass:[NSDictionary class]]) {
                        NSString *productID = [product objectForKey:@"productid"];
                        //                    该产品已在历史记录中存在；
                        if ([productID isEqualToString:model.productid]) {
                            
                            return;
                        }
                    }
                }
                
                [_commodityHistory insertObject:commodityDic atIndex:0];
            }else{
                HotelDetailModel * model = (HotelDetailModel *)shopInfo;
                commodityDic = (NSMutableDictionary *)[model dictionaryRepresentation];
                
                for (NSDictionary * product in _commodityHistory) {
                    if ([product isKindOfClass:[NSDictionary class]]) {
                        if (product.allKeys.count == 22) {
                            NSString *sellerID = [product objectForKey:@"sellerid"];
                            //                    该商家已在历史记录中存在；
                            if ([sellerID isEqualToString:model.sellerid]) {
                                
                                return;
                            }
                        }
                    }
                }
                
                [_commodityHistory insertObject:commodityDic atIndex:0];
            }
            
            NSFileManager *fileManager = [NSFileManager defaultManager];
            if ([fileManager fileExistsAtPath:plistPath]) {
                
                [fileManager removeItemAtPath:plistPath error:nil];
            }
            if (_commodityHistory) {
                
                NSData *historyData = [self returnDataWithList:_commodityHistory];
                if (historyData) {
                    [historyData writeToFile:plistPath atomically:YES];
                    
                }
            }
        }
    }
}

- (NSArray *)getBrowseHistory{
    @synchronized(self){
        if (_commodityHistory) {
            return [self conversionDicArray2ShopArray:_commodityHistory];
        }else{
            
            NSString *rootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES) objectAtIndex:0];
            
            NSString *plistPath = [rootPath stringByAppendingPathComponent:@"BrowseHistoryData.plist"];
            
            
            NSArray *tempArr = [self returnListWithDataPath:plistPath];
            if (tempArr) {
                if ([tempArr isKindOfClass:[NSArray class]]) {
                    if (tempArr.count > 0) {
                        
                        _commodityHistory = [[NSMutableArray alloc] initWithArray:tempArr];
                        return [self conversionDicArray2ShopArray:_commodityHistory];
                    }
                }
            }
        }
        return nil;
    }
}

- (NSArray *)conversionDicArray2ShopArray:(NSArray *)dicArray{
    NSMutableArray *temyArray = [[NSMutableArray alloc] initWithCapacity:1];
    for (NSDictionary *shopDic in dicArray) {
        if ([shopDic isKindOfClass:[NSDictionary class]]) {
            
            if ([shopDic objectForKey:@"producttype"] != nil) {
                ProductDetail * model = [ProductDetail modelObjectWithDictionary:shopDic];
                [temyArray addObject:model];
            }else{
                HotelDetailModel * model = [HotelDetailModel modelObjectWithDictionary:shopDic];
                [temyArray addObject:model];
            }
            
            //            ShopInfoModel *shopInfo = [ShopInfoModel shopInfoModelWithDictionary:shopDic];
            
            //            [temyArray addObject:shopInfo];
        }
        
    }
    
    return temyArray;
}

- (NSData*)returnDataWithList:(id)list
{
    NSMutableData* data = [[NSMutableData alloc] init];
    NSKeyedArchiver* archiver = [[NSKeyedArchiver alloc]initForWritingWithMutableData:data];
    [archiver encodeObject:list forKey:@"BrowseHistoryData"];
    [archiver finishEncoding];
    return data;
}

//路径文件转dictonary
- (id)returnListWithDataPath:(NSString*)path
{
    NSData* data = [[NSMutableData alloc] initWithContentsOfFile:path];
    
    NSKeyedUnarchiver* unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    NSDictionary* myDictionary = [unarchiver decodeObjectForKey:@"BrowseHistoryData"];
    [unarchiver finishDecoding];
    
    return myDictionary;
}

- (NSData*)returnCityDataListWithList:(id)list
{
    NSMutableData* data = [[NSMutableData alloc] init];
    NSKeyedArchiver* archiver = [[NSKeyedArchiver alloc]initForWritingWithMutableData:data];
    [archiver encodeObject:list forKey:@"CityCodeList"];
    [archiver finishEncoding];
    return data;
}


- (id)returnListWithCityCodeListPath:(NSString*)path
{
    NSData* data = [[NSMutableData alloc] initWithContentsOfFile:path];
    
    NSKeyedUnarchiver* unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    NSDictionary* myDictionary = [unarchiver decodeObjectForKey:@"CityCodeList"];
    [unarchiver finishDecoding];
    
    return myDictionary;
}

-(void)setLocationInfoWithCityName:(NSString *)cityName CityCode:(NSString *)cityCode Longitude:(NSString *)longitude Latitude:(NSString *)latitude
{
    NSUserDefaults * userDfault = [NSUserDefaults standardUserDefaults];
    
    NSMutableDictionary * infoDictionary = [NSMutableDictionary dictionaryWithDictionary:[userDfault objectForKey:@"LOCATIONINFO"]];
    
    
    if (infoDictionary) {
        if (cityName) {
            [infoDictionary removeObjectForKey:@"CITYNAME"];
            [infoDictionary setObject:cityName forKey:@"CITYNAME"];
        }
        if (cityCode) {
            [infoDictionary setObject:cityCode forKey:@"CITYCODE"];
        }
        if (longitude) {
            [infoDictionary setObject:longitude forKey:@"LONGITUDE"];
        }
        if (latitude) {
            [infoDictionary setObject:latitude forKey:@"LATITUDE"];
        }
        [userDfault setObject:infoDictionary forKey:@"LOCATIONINFO"];
    }else{
        NSMutableDictionary * infoDic = [[NSMutableDictionary alloc] init];
        
        if (cityName) {
            [infoDic setObject:cityName forKey:@"CITYNAME"];
        }
        if (cityCode) {
            [infoDic setObject:cityCode forKey:@"CITYCODE"];
        }
        if (longitude) {
            [infoDic setObject:longitude forKey:@"LONGITUDE"];
        }
        if (latitude) {
            [infoDic setObject:latitude forKey:@"LATITUDE"];
        }
        
        [userDfault setObject:infoDic forKey:@"LOCATIONINFO"];
    }
    
    [userDfault synchronize];
}

-(NSDictionary *)getLocationInfo
{
    NSUserDefaults * userDefault = [NSUserDefaults standardUserDefaults];
    NSDictionary * infoDic = [userDefault objectForKey:@"LOCATIONINFO"];
    
    if (infoDic) {
        return infoDic;
    }else{
        return [[NSDictionary alloc] init];
    }
}

-(void)setSelctedCityName:(NSString *)cityName CityCode:(NSString *)cityCode
{
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    if (cityCode && cityCode) {
        [user setObject:cityCode forKey:@"citycode"];
        [user setObject:cityName forKey:@"cityname"];
    }
    [user synchronize];
}

-(NSDictionary *)getSelectedCityNameAndCityCode
{
    NSMutableDictionary * dic = [[NSMutableDictionary alloc] initWithCapacity:2];
    
    NSUserDefaults * user = [NSUserDefaults standardUserDefaults];
    NSString * cityCode = [user objectForKey:@"citycode"];
    NSString * cityName = [user objectForKey:@"cityname"];
    
    if (cityCode) {
        [dic setObject:cityCode forKey:@"citycode"];
    }
    if (cityName) {
        [dic setObject:cityName forKey:@"cityname"];
    }
    
    return dic;
}

#pragma mark -

//获取当前位置。
- (void)getLocation:(locationInfomation)locationInfo{
    __block BOOL isPositionSuccess = YES;
    //    判断定位功能是否可用以及用户授予的的定位权限
    if ([CLLocationManager locationServicesEnabled]&&
        ([CLLocationManager authorizationStatus] == (iOS8?kCLAuthorizationStatusAuthorizedWhenInUse:kCLAuthorizationStatusAuthorized)
         || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined)) {
            
            _locationInfomation = locationInfo;
            _locationManager = [[CLLocationManager alloc] init];
            _locationManager.delegate = self;
            _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
            //设置每隔100米更新位置
            _locationManager.distanceFilter = 100;
            
            [self getCurrentLocationWithCompletionHandler:^(CLLocation *location) {
                //               GPS坐标转高德坐标系算法
                CLLocation *currentLocation = [MapCoordinateTransformation transformToMars:location];
                NSString *latitude = [NSString stringWithFormat:@"%@",@(currentLocation.coordinate.latitude)];
                NSString *longitude = [NSString stringWithFormat:@"%@",@(currentLocation.coordinate.longitude)];
                
                //         获取当前所在的城市名
                CLGeocoder *geocoder = [[CLGeocoder alloc] init];
                [geocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *placemarks, NSError *error) {
                    NSMutableDictionary *locationDic = [[NSMutableDictionary alloc] initWithCapacity:1];
                    
                    if (placemarks.count > 0) {
                        CLPlacemark *placemark = [placemarks firstObject];
                        NSMutableDictionary *subLocationDic = [[NSMutableDictionary alloc] initWithDictionary:placemark.addressDictionary];
                        [subLocationDic setObject:latitude forKey:@"latitude"];
                        [subLocationDic setObject:longitude forKey:@"longitude"];
                        [locationDic setObject:subLocationDic forKey:@"location"];
                        [locationDic setObject:placemark.addressDictionary[@"City"] forKey:@"cityname"];
                        NSMutableDictionary *postDic = [[NSMutableDictionary alloc] initWithCapacity:1];
                        //                        [postDic setObject:@"2" forKey:@"clienttype"];
                        //                        [postDic setObject:APPVERSION forKey:@"version"];
                        //                        [postDic setObject:[self getSeriesNumber] forKey:@"series"];
                        if (locationDic[@"location"][@"longitude"] && locationDic[@"location"][@"latitude"]) {
                            [postDic setObject:locationDic[@"location"][@"longitude"] forKey:@"longitude"];
                            [postDic setObject:locationDic[@"location"][@"latitude"] forKey:@"latitude"];
                        }
                        
                        NSLog(@"result = %@",postDic);
                        //                        [WTRequestCenter postWithURL:[NSString stringWithFormat:@"%@/index/getLocaltionInfo.html",[[AppInformationSingleton shareAppInfomationSingleton] getDominNameWithInterfaceType:kHostAPI]] parameters:postDic withRequiredFields:YES finished:^(NSURLResponse *response, NSData *data) {
                        //
                        //                            if (data) {
                        //                                //                                    NSString *resultStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                        //                                NSDictionary *result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                        //                                if ([result isKindOfClass:[NSDictionary class]]) {
                        //                                    NSNumber *requestStatus = [result objectForKey:@"status"];
                        //                                    if (requestStatus.boolValue == true) {
                        //                                        NSDictionary *dataDic = [result objectForKey:@"data"];
                        //                                        if ([dataDic isKindOfClass:[NSDictionary class]]) {
                        //
                        //                                            NSString *areaId = [dataDic objectForKey:@"area_id"];
                        //                                            NSString *bid = [dataDic objectForKey:@"bid"];
                        //                                            NSString *cityId = [dataDic objectForKey:@"city_id"];
                        //                                            if (areaId && [areaId isKindOfClass:[NSString class]]) {
                        //                                                [locationDic setObject:areaId forKey:@"areaid"];
                        //                                            }
                        //                                            if (bid && [bid isKindOfClass:[NSString class]]) {
                        //                                                [locationDic setObject:bid forKey:@"bid"];
                        //                                            }
                        //                                            if (cityId && [cityId isKindOfClass:[NSString class]]) {
                        //                                                [locationDic setObject:cityId forKey:@"cityid"];
                        //                                            }else{
                        //                                                [locationDic setObject:@"1988" forKey:@"cityid"];
                        //                                            }
                        //                                            NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
                        //                                            [user setObject:locationDic forKey:@"LOCATIONINFO"];
                        //                                            [user synchronize];
                        //                                            locationInfo(locationDic);
                        //                                            [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshLocationNotification" object:locationDic];
                        //                                            isPositionSuccess = NO;
                        //                                        }
                        //                                    }
                        //                                }
                        //                            }
                        //
                        //                        } failed:^(NSURLResponse *response, NSError *error) {
                        //
                        //                        }];
                        
                    } else{
                        //                    定位失败
                        if (isPositionSuccess) {
                            NSDictionary *saveLocation = [[NSUserDefaults standardUserDefaults] objectForKey:@"LOCATIONINFO"];
                            if (saveLocation) {
                                if (locationInfo) {
                                    locationInfo(saveLocation);
                                }
                                
                            }else{
                                NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:@"getLocationFailed",@"status", nil];
                                if (locationInfo) {
                                    locationInfo(dic);
                                }
                            }
                            isPositionSuccess = NO;
                        }
                    }
                    
                }];
                
                
            }];
        }else{
            //        提示用户打开定位，并允许程序访问位置信息
            //         status:DeviceDisabled
            if (isPositionSuccess) {
                NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:@"DeviceDisabled",@"status", nil];
                locationInfo(dic);
                isPositionSuccess = NO;
            }
        }
}

#pragma mark - Location Manager Delegate
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    // pass the most recent location back in the location handler and stop updating locations
    _locationHandler(locations.lastObject);
    [_locationManager stopUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:@"DeviceDisabled",@"status", nil];
    _locationInfomation(dic);
}
- (void)getCurrentLocationWithCompletionHandler:(locationHandler)handler {
    
    _locationHandler = handler;
    
    if ([_locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
        [_locationManager requestWhenInUseAuthorization];
    }
    
    [_locationManager startUpdatingLocation];
    
    
}


- (NSDictionary *)getPositionLocation{
    @synchronized(self){
        NSDictionary *positionLocationDic = [[NSUserDefaults standardUserDefaults] objectForKey:@"LOCATIONINFO"];
        if (positionLocationDic) {
            
            return positionLocationDic;
        }else{
            return nil;
        }
    }
}

- (void)getLocationWithCity:(NSString *)city WithSubLocality:(NSString *)subLocality WithThoroughfare:(NSString *)thoroughfare WithCallBack:(cityInformation)CityInformation{
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    
    NSMutableDictionary *cityInfoDic = [[NSMutableDictionary alloc] initWithCapacity:1];
    if (city) {
        [cityInfoDic setValue:city forKey:@"City"];
        
    }
    if (subLocality) {
        [cityInfoDic setObject:subLocality forKey:@"SubLocality"];
        
    }
    if (thoroughfare) {
        
        [cityInfoDic setObject:thoroughfare forKey:@"Thoroughfare"];
    }
    
    [geocoder geocodeAddressDictionary:cityInfoDic completionHandler:^(NSArray *placemarks, NSError *error) {
        CLPlacemark *placemark = [placemarks objectAtIndex:0];
        if (placemark) {
            NSMutableDictionary *cityInfoDic = [[NSMutableDictionary alloc] initWithDictionary:placemark.addressDictionary];
            
            NSString *city = placemark.locality;
            if (!city) {
                //四大直辖市的城市信息无法通过locality获得，只能通过获取省份的方法来获得（如果city为空，则可知为直辖市）
                city = placemark.administrativeArea;
                [cityInfoDic setObject:city forKey:@"City"];
                
            }
            
            NSNumber *latTemp = @(placemark.location.coordinate.latitude);
            if (latTemp) {
                [cityInfoDic setObject:latTemp forKey:@"latitude"];
            }
            
            NSNumber *lonTemp = @(placemark.location.coordinate.longitude);
            if (lonTemp) {
                
                [cityInfoDic setObject:lonTemp forKey:@"longitude"];
            }
            //            存储反向编译的地理信息
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            [userDefaults setObject:cityInfoDic forKey:@"SELECTEDLOCATIONINFO"];
            [userDefaults synchronize];
            
            CityInformation(cityInfoDic);
        }else{
            //            反向地理编译失败
            
            NSDictionary *saveLocation = [[NSUserDefaults standardUserDefaults] objectForKey:@"SELECTEDLOCATIONINFO"];
            if (saveLocation) {
                CityInformation (saveLocation);
            }else{
                NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:@"getLocationFailed",@"status", nil];
                CityInformation(dic);
            }
        }
        
    }];
    
    
}
- (NSDictionary *)getKeepLocationInfo{
    @synchronized(self){
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        NSDictionary *keepLocationInfo = [userDefaults objectForKey:@"SELECTEDLOCATIONINFO"];
        if (keepLocationInfo) {
            
            return keepLocationInfo;
        }
        return nil;
    }
}


@end
