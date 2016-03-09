//
//  Coupon.m
//
//  Created by sooncong  on 16/1/21
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "Coupon.h"


NSString *const kCouponIsused = @"isused";
NSString *const kCouponCouponcode = @"couponcode";


@interface Coupon ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation Coupon

@synthesize isused = _isused;
@synthesize couponcode = _couponcode;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.isused = [self objectOrNilForKey:kCouponIsused fromDictionary:dict];
            self.couponcode = [self objectOrNilForKey:kCouponCouponcode fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.isused forKey:kCouponIsused];
    [mutableDict setValue:self.couponcode forKey:kCouponCouponcode];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description 
{
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}

#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}


#pragma mark - NSCoding Methods

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];

    self.isused = [aDecoder decodeObjectForKey:kCouponIsused];
    self.couponcode = [aDecoder decodeObjectForKey:kCouponCouponcode];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_isused forKey:kCouponIsused];
    [aCoder encodeObject:_couponcode forKey:kCouponCouponcode];
}

- (id)copyWithZone:(NSZone *)zone
{
    Coupon *copy = [[Coupon alloc] init];
    
    if (copy) {

        copy.isused = [self.isused copyWithZone:zone];
        copy.couponcode = [self.couponcode copyWithZone:zone];
    }
    
    return copy;
}


@end
