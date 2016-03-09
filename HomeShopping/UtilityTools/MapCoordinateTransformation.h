//
//  MapCoordinateTransformation.h
//  XMNiao_Shop
//
//  Created by DH on 15/5/6.
//  Copyright (c) 2015年 Luo. All rights reserved.
//


/*
 *      地球坐标系转换到火星坐标系算法
 */
#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
@interface MapCoordinateTransformation : NSObject

+ (CLLocation *)transformToMars:(CLLocation *)location;

@end
