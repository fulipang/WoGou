//
//  Coupons.m
//
//  Created by sooncong  on 16/1/21
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "Coupons.h"


NSString *const kCouponsIsused = @"isused";
NSString *const kCouponsCouponcode = @"couponcode";


@interface Coupons ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation Coupons

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
            self.isused = [self objectOrNilForKey:kCouponsIsused fromDictionary:dict];
            self.couponcode = [self objectOrNilForKey:kCouponsCouponcode fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.isused forKey:kCouponsIsused];
    [mutableDict setValue:self.couponcode forKey:kCouponsCouponcode];

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

    self.isused = [aDecoder decodeObjectForKey:kCouponsIsused];
    self.couponcode = [aDecoder decodeObjectForKey:kCouponsCouponcode];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_isused forKey:kCouponsIsused];
    [aCoder encodeObject:_couponcode forKey:kCouponsCouponcode];
}

- (id)copyWithZone:(NSZone *)zone
{
    Coupons *copy = [[Coupons alloc] init];
    
    if (copy) {

        copy.isused = [self.isused copyWithZone:zone];
        copy.couponcode = [self.couponcode copyWithZone:zone];
    }
    
    return copy;
}


@end
