//
//  OrderDetailModelParser.m
//
//  Created by sooncong  on 16/1/23
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "OrderDetailModelParser.h"


NSString *const kOrderDetailModelParserOrderDetailModel = @"body";


@interface OrderDetailModelParser ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation OrderDetailModelParser

@synthesize orderDetailModel = _orderDetailModel;


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
            self.orderDetailModel = [OrderDetailModel modelObjectWithDictionary:[dict objectForKey:kOrderDetailModelParserOrderDetailModel]];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[self.orderDetailModel dictionaryRepresentation] forKey:kOrderDetailModelParserOrderDetailModel];

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

    self.orderDetailModel = [aDecoder decodeObjectForKey:kOrderDetailModelParserOrderDetailModel];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_orderDetailModel forKey:kOrderDetailModelParserOrderDetailModel];
}

- (id)copyWithZone:(NSZone *)zone
{
    OrderDetailModelParser *copy = [[OrderDetailModelParser alloc] init];
    
    if (copy) {

        copy.orderDetailModel = [self.orderDetailModel copyWithZone:zone];
    }
    
    return copy;
}


@end
