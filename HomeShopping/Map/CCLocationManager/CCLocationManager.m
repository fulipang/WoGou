//
//  CCLocationManager.m
//  CoreLocationExample
//
//  Created by Saucheong Ye on 1/14/16.
//  Copyright © 2016 Saucheong Ye. All rights reserved.
//

#define kTipsAlert(_S_, ...)     [[[UIAlertView alloc] initWithTitle:@"提示" message:[NSString stringWithFormat:(_S_), ##__VA_ARGS__] delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil] show]


#import "CCLocationManager.h"
#import "CLLocation+YCLocation.h"

@interface CCLocationManager ()<CLLocationManagerDelegate>

@property (nonatomic, copy) currentLocationCoordinateBlock currentLocationCoordinateBlock;
@property (nonatomic, copy) locationErrorBlock locationErrorBlock;
@property (nonatomic, copy) currentProvinceBlock currentProvinceBlock;
@property (nonatomic, copy) currentCityBlock currentCityBlock;
@property (nonatomic, copy) currentAddressBlock currentAddressBlock;


@end

@implementation CCLocationManager

+ (instancetype)sharedManager{
    
    static CCLocationManager *manager= nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
    });
    
    return manager;
}

- (instancetype)init{
    self = [super init];
    
    if (self) {
        NSUserDefaults *d = [NSUserDefaults standardUserDefaults];
        
        float longitude = [d floatForKey:CCLastLongitude];
        float latitude = [d floatForKey:CCLastLatitude];
        self.longitude = longitude;
        self.latitude = latitude;
        self.coordinate = CLLocationCoordinate2DMake(longitude,latitude);
        self.currentCity = [d objectForKey:CCLastCity];
        self.currentAddress=[d objectForKey:CCLastAddress];

    }
    return self;
}



- (void)currentCity:(currentCityBlock)cityBlock{
    self.currentCityBlock = cityBlock;
    
    [self startLocation];
}

- (void)currentAddress:(currentAddressBlock)addressBlock{
    self.currentAddressBlock = addressBlock;
    [self startLocation];

}

- (void)currentLocationCoordinate:(currentLocationCoordinateBlock)coordinateBlock{
    self.currentLocationCoordinateBlock = coordinateBlock;
    [self startLocation];
}

- (void)currentLocationCoordinate:(currentLocationCoordinateBlock)coordinateBlock
                      address:(currentAddressBlock)addressBlock{
    self.currentLocationCoordinateBlock = coordinateBlock;
    self.currentAddressBlock = addressBlock;
    
    [self startLocation];
}

- (BOOL)userAllowedLocation{
    
    return ([CLLocationManager locationServicesEnabled] && [CLLocationManager authorizationStatus] != kCLAuthorizationStatusDenied)?YES:NO;
}

- (void)startLocation{
    
    if([self userAllowedLocation]){
        
        _manager = [[CLLocationManager alloc]init];
        _manager.delegate = self;
        _manager.desiredAccuracy = kCLLocationAccuracyBest;
        [_manager requestWhenInUseAuthorization];
        _manager.distanceFilter = 100;
        [_manager startUpdatingLocation];
        
    }else if([CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied){
        
        //前往 开启定位授权
        if (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_7_1) {
            
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请在iPhone的“设置->隐私->位置”中允许访问位置信息" delegate:self cancelButtonTitle:nil otherButtonTitles:@"取消", @"设置", nil];
            [alertView show];
            
        }else{
            kTipsAlert(@"请在iPhone的“设置->隐私->位置”中允许访问位置信息");
        }

    }
    
}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error{
    [self endLocation];
    
}

- (void)endLocation{
    
    _manager = nil;
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{

    if (buttonIndex == 1) {
        
        UIApplication *app = [UIApplication sharedApplication];
        NSURL *settingsURL = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        if ([app canOpenURL:settingsURL]) {
            [app openURL:settingsURL];
        }
    }
}
#pragma mark - CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation{
    
    NSUserDefaults *standard = [NSUserDefaults standardUserDefaults];
    CLLocation * location = [[CLLocation alloc]initWithLatitude:newLocation.coordinate.latitude longitude:newLocation.coordinate.longitude];
    CLLocation * marsLoction =  location;// [location locationBaiduFromMars];
    
    
    CLGeocoder *geocoder = [[CLGeocoder alloc]init];
    [geocoder reverseGeocodeLocation:marsLoction
                   completionHandler:^(NSArray *placemarks,NSError *error){
         if (placemarks.count > 0) {
             CLPlacemark *placemark = [placemarks objectAtIndex:0];
             _currentCity = placemark.locality;
             [standard setObject:_currentCity forKey:CCLastCity];//省市地址
//             NSLog(@"_currentCity%@",_currentCity);
             _currentAddress = placemark.name;
//             NSLog(@"_currentAddress%@",_currentAddress);
         }
         if (_currentCityBlock) {
             _currentCityBlock(_currentCity);
             _currentCityBlock = nil;
         }
         if (_currentAddressBlock) {
             _currentAddressBlock(_currentAddress);
             _currentAddressBlock = nil;
         }
    
     }];
    
    
    _coordinate = CLLocationCoordinate2DMake(marsLoction.coordinate.latitude ,marsLoction.coordinate.longitude);
    if (_currentLocationCoordinateBlock) {
        _currentLocationCoordinateBlock(_coordinate);
        _currentLocationCoordinateBlock = nil;
    }
    
    NSLog(@"%f--%f",marsLoction.coordinate.latitude,marsLoction.coordinate.longitude);
    [standard setObject:@(marsLoction.coordinate.latitude) forKey:CCLastLatitude];
    [standard setObject:@(marsLoction.coordinate.longitude) forKey:CCLastLongitude];
    
    [manager stopUpdatingLocation];
}


@end
