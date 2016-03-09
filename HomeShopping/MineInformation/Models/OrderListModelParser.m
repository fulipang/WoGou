//
//  OrderListModelParser.m
//
//  Created by sooncong  on 16/1/21
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "OrderListModelParser.h"


NSString *const kOrderListModelParserOrderListModel = @"body";


@interface OrderListModelParser ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation OrderListModelParser

@synthesize orderListModel = _orderListModel;


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
            self.orderListModel = [OrderListModel modelObjectWithDictionary:[dict objectForKey:kOrderListModelParserOrderListModel]];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[self.orderListModel dictionaryRepresentation] forKey:kOrderListModelParserOrderListModel];

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

    self.orderListModel = [aDecoder decodeObjectForKey:kOrderListModelParserOrderListModel];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_orderListModel forKey:kOrderListModelParserOrderListModel];
}

- (id)copyWithZone:(NSZone *)zone
{
    OrderListModelParser *copy = [[OrderListModelParser alloc] init];
    
    if (copy) {

        copy.orderListModel = [self.orderListModel copyWithZone:zone];
    }
    
    return copy;
}


@end
