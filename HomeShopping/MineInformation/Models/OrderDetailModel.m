//
//  OrderDetailModel.m
//
//  Created by sooncong  on 16/1/23
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "OrderDetailModel.h"
#import "OrderDetail.h"


NSString *const kOrderDetailModelOrderDetail = @"order";


@interface OrderDetailModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation OrderDetailModel

@synthesize orderDetail = _orderDetail;


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
            self.orderDetail = [OrderDetail modelObjectWithDictionary:[dict objectForKey:kOrderDetailModelOrderDetail]];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[self.orderDetail dictionaryRepresentation] forKey:kOrderDetailModelOrderDetail];

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

    self.orderDetail = [aDecoder decodeObjectForKey:kOrderDetailModelOrderDetail];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_orderDetail forKey:kOrderDetailModelOrderDetail];
}

- (id)copyWithZone:(NSZone *)zone
{
    OrderDetailModel *copy = [[OrderDetailModel alloc] init];
    
    if (copy) {

        copy.orderDetail = [self.orderDetail copyWithZone:zone];
    }
    
    return copy;
}


@end
