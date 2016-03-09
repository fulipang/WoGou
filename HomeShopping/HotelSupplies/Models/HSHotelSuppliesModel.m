//
//  HSHotelSuppliesModel.m
//
//  Created by sooncong  on 15/12/22
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "HSHotelSuppliesModel.h"
#import "HSProducts.h"
#import "HSAdsLists.h"


NSString *const kHSHotelSuppliesModelProducts = @"categorys";
NSString *const kHSHotelSuppliesModelAdsLists = @"topadvs";
NSString *const kHSHotelSuppliesModelTotalcount = @"totalcount";


@interface HSHotelSuppliesModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation HSHotelSuppliesModel

@synthesize products = _products;
@synthesize adsLists = _adsLists;
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
    NSObject *receivedHSProducts = [dict objectForKey:kHSHotelSuppliesModelProducts];
    NSMutableArray *parsedHSProducts = [NSMutableArray array];
    if ([receivedHSProducts isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedHSProducts) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedHSProducts addObject:[HSProducts modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedHSProducts isKindOfClass:[NSDictionary class]]) {
       [parsedHSProducts addObject:[HSProducts modelObjectWithDictionary:(NSDictionary *)receivedHSProducts]];
    }

    self.products = [NSArray arrayWithArray:parsedHSProducts];
    NSObject *receivedHSAdsLists = [dict objectForKey:kHSHotelSuppliesModelAdsLists];
    NSMutableArray *parsedHSAdsLists = [NSMutableArray array];
    if ([receivedHSAdsLists isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedHSAdsLists) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedHSAdsLists addObject:[HSAdsLists modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedHSAdsLists isKindOfClass:[NSDictionary class]]) {
       [parsedHSAdsLists addObject:[HSAdsLists modelObjectWithDictionary:(NSDictionary *)receivedHSAdsLists]];
    }

    self.adsLists = [NSArray arrayWithArray:parsedHSAdsLists];
            self.totalcount = [self objectOrNilForKey:kHSHotelSuppliesModelTotalcount fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    NSMutableArray *tempArrayForProducts = [NSMutableArray array];
    for (NSObject *subArrayObject in self.products) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForProducts addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForProducts addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForProducts] forKey:kHSHotelSuppliesModelProducts];
    NSMutableArray *tempArrayForAdsLists = [NSMutableArray array];
    for (NSObject *subArrayObject in self.adsLists) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForAdsLists addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForAdsLists addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForAdsLists] forKey:kHSHotelSuppliesModelAdsLists];
    [mutableDict setValue:self.totalcount forKey:kHSHotelSuppliesModelTotalcount];

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

    self.products = [aDecoder decodeObjectForKey:kHSHotelSuppliesModelProducts];
    self.adsLists = [aDecoder decodeObjectForKey:kHSHotelSuppliesModelAdsLists];
    self.totalcount = [aDecoder decodeObjectForKey:kHSHotelSuppliesModelTotalcount];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_products forKey:kHSHotelSuppliesModelProducts];
    [aCoder encodeObject:_adsLists forKey:kHSHotelSuppliesModelAdsLists];
    [aCoder encodeObject:_totalcount forKey:kHSHotelSuppliesModelTotalcount];
}

- (id)copyWithZone:(NSZone *)zone
{
    HSHotelSuppliesModel *copy = [[HSHotelSuppliesModel alloc] init];
    
    if (copy) {

        copy.products = [self.products copyWithZone:zone];
        copy.adsLists = [self.adsLists copyWithZone:zone];
        copy.totalcount = [self.totalcount copyWithZone:zone];
    }
    
    return copy;
}


@end
