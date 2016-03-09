//
//  OrderListModel.m
//
//  Created by sooncong  on 16/1/21
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "OrderListModel.h"
#import "Orders.h"


NSString *const kOrderListModelTotalpage = @"totalpage";
NSString *const kOrderListModelOrders = @"orders";
NSString *const kOrderListModelTotalcount = @"totalcount";


@interface OrderListModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation OrderListModel

@synthesize totalpage = _totalpage;
@synthesize orders = _orders;
@synthesize totalcount = _totalcount;


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
            self.totalpage = [self objectOrNilForKey:kOrderListModelTotalpage fromDictionary:dict];
    NSObject *receivedOrders = [dict objectForKey:kOrderListModelOrders];
    NSMutableArray *parsedOrders = [NSMutableArray array];
    if ([receivedOrders isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedOrders) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedOrders addObject:[Orders modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedOrders isKindOfClass:[NSDictionary class]]) {
       [parsedOrders addObject:[Orders modelObjectWithDictionary:(NSDictionary *)receivedOrders]];
    }

    self.orders = [NSArray arrayWithArray:parsedOrders];
            self.totalcount = [self objectOrNilForKey:kOrderListModelTotalcount fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.totalpage forKey:kOrderListModelTotalpage];
    NSMutableArray *tempArrayForOrders = [NSMutableArray array];
    for (NSObject *subArrayObject in self.orders) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForOrders addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForOrders addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForOrders] forKey:kOrderListModelOrders];
    [mutableDict setValue:self.totalcount forKey:kOrderListModelTotalcount];

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

    self.totalpage = [aDecoder decodeObjectForKey:kOrderListModelTotalpage];
    self.orders = [aDecoder decodeObjectForKey:kOrderListModelOrders];
    self.totalcount = [aDecoder decodeObjectForKey:kOrderListModelTotalcount];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_totalpage forKey:kOrderListModelTotalpage];
    [aCoder encodeObject:_orders forKey:kOrderListModelOrders];
    [aCoder encodeObject:_totalcount forKey:kOrderListModelTotalcount];
}

- (id)copyWithZone:(NSZone *)zone
{
    OrderListModel *copy = [[OrderListModel alloc] init];
    
    if (copy) {

        copy.totalpage = [self.totalpage copyWithZone:zone];
        copy.orders = [self.orders copyWithZone:zone];
        copy.totalcount = [self.totalcount copyWithZone:zone];
    }
    
    return copy;
}


@end
