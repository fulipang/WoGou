//
//  Coupon.h
//
//  Created by sooncong  on 16/1/21
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface Coupon : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *isused;
@property (nonatomic, strong) NSString *couponcode;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
