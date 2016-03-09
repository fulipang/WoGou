//
//  CCLocationManager.h
//  CoreLocationExample
//
//  Created by Saucheong Ye on 1/14/16.
//  Copyright © 2016 Saucheong Ye. All rights reserved.
//  Reference: http://code.cocoachina.com/view/126000
//


#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

#define  CCLastLongitude @"CCLastLongitude"
#define  CCLastLatitude  @"CCLastLatitude"
#define  CCLastCity      @"CCLastCity"
#define  CCLastAddress   @"CCLastAddress"

typedef void(^currentLocationCoordinateBlock)(CLLocationCoordinate2D locationCorrdinate);
typedef void(^locationErrorBlock)(NSError *error);
typedef void(^currentProvinceBlock)(NSString *province);
typedef void(^currentCityBlock)(NSString *city);
typedef void(^currentAddressBlock)(NSString *address);


@interface CCLocationManager : NSObject


@property (nonatomic, assign)float latitude;
@property (nonatomic, assign)float longitude;
@property (nonatomic, copy) NSString *currentCity;
@property (nonatomic, copy) NSString *currentAddress;
@property (nonatomic, strong) CLLocationManager *manager;
@property (nonatomic) CLLocationCoordinate2D coordinate;



+ (instancetype)sharedManager;

- (BOOL)userAllowedLocation;

- (void)currentCity:(currentCityBlock)cityBlock;

- (void)currentAddress:(currentAddressBlock)addressBlock;

- (void)currentLocationCoordinate:(currentLocationCoordinateBlock)coordinateBlock;

- (void)currentLocationCoordinate:(currentLocationCoordinateBlock)coordinateBlock
                      address:(currentAddressBlock)addressBlock;

//- (void)startLocation;

//- (void)endLocation;

//- (void)currentProvice:(currentProvinceBlock)proviceBlock;

@end
