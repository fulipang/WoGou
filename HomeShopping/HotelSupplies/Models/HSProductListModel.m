//
//  HSProductListModel.m
//
//  Created by sooncong  on 15/12/24
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "HSProductListModel.h"
#import "HSProduct.h"
//#import "HSTopadvs.h"
#import "HSAdsLists.h"


NSString *const kHSProductListModelTotalcount = @"totalcount";
NSString *const kHSProductListModelProduct = @"products";
NSString *const kHSProductListModelTopadvs = @"topadvs";
NSString *const kHSProductListModelTotalpage = @"totalpage";


@interface HSProductListModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation HSProductListModel

@synthesize totalcount = _totalcount;
@synthesize product = _product;
@synthesize topadvs = _topadvs;
@synthesize totalpage = _totalpage;


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
            self.totalcount = [self objectOrNilForKey:kHSProductListModelTotalcount fromDictionary:dict];
    NSObject *receivedHSProduct = [dict objectForKey:kHSProductListModelProduct];
    NSMutableArray *parsedHSProduct = [NSMutableArray array];
    if ([receivedHSProduct isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedHSProduct) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedHSProduct addObject:[HSProduct modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedHSProduct isKindOfClass:[NSDictionary class]]) {
       [parsedHSProduct addObject:[HSProduct modelObjectWithDictionary:(NSDictionary *)receivedHSProduct]];
    }

    self.product = [NSArray arrayWithArray:parsedHSProduct];
    NSObject *receivedHSTopadvs = [dict objectForKey:kHSProductListModelTopadvs];
    NSMutableArray *parsedHSTopadvs = [NSMutableArray array];
    if ([receivedHSTopadvs isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedHSTopadvs) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedHSTopadvs addObject:[HSAdsLists modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedHSTopadvs isKindOfClass:[NSDictionary class]]) {
       [parsedHSTopadvs addObject:[HSAdsLists modelObjectWithDictionary:(NSDictionary *)receivedHSTopadvs]];
    }

    self.topadvs = [NSArray arrayWithArray:parsedHSTopadvs];
            self.totalpage = [self objectOrNilForKey:kHSProductListModelTotalpage fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.totalcount forKey:kHSProductListModelTotalcount];
    NSMutableArray *tempArrayForProduct = [NSMutableArray array];
    for (NSObject *subArrayObject in self.product) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForProduct addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForProduct addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForProduct] forKey:kHSProductListModelProduct];
    NSMutableArray *tempArrayForTopadvs = [NSMutableArray array];
    for (NSObject *subArrayObject in self.topadvs) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForTopadvs addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForTopadvs addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForTopadvs] forKey:kHSProductListModelTopadvs];
    [mutableDict setValue:self.totalpage forKey:kHSProductListModelTotalpage];

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

    self.totalcount = [aDecoder decodeObjectForKey:kHSProductListModelTotalcount];
    self.product = [aDecoder decodeObjectForKey:kHSProductListModelProduct];
    self.topadvs = [aDecoder decodeObjectForKey:kHSProductListModelTopadvs];
    self.totalpage = [aDecoder decodeObjectForKey:kHSProductListModelTotalpage];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_totalcount forKey:kHSProductListModelTotalcount];
    [aCoder encodeObject:_product forKey:kHSProductListModelProduct];
    [aCoder encodeObject:_topadvs forKey:kHSProductListModelTopadvs];
    [aCoder encodeObject:_totalpage forKey:kHSProductListModelTotalpage];
}

- (id)copyWithZone:(NSZone *)zone
{
    HSProductListModel *copy = [[HSProductListModel alloc] init];
    
    if (copy) {

        copy.totalcount = [self.totalcount copyWithZone:zone];
        copy.product = [self.product copyWithZone:zone];
        copy.topadvs = [self.topadvs copyWithZone:zone];
        copy.totalpage = [self.totalpage copyWithZone:zone];
    }
    
    return copy;
}


@end
