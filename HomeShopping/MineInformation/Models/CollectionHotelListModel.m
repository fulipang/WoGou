//
//  CollectionHotelListModel.m
//
//  Created by sooncong  on 16/1/20
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "CollectionHotelListModel.h"
#import "Sellers.h"


NSString *const kCollectionHotelListModelSellers = @"sellers";
NSString *const kCollectionHotelListModelTotalpage = @"totalpage";
NSString *const kCollectionHotelListModelTotalcount = @"totalcount";


@interface CollectionHotelListModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation CollectionHotelListModel

@synthesize sellers = _sellers;
@synthesize totalpage = _totalpage;
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
    NSObject *receivedSellers = [dict objectForKey:kCollectionHotelListModelSellers];
    NSMutableArray *parsedSellers = [NSMutableArray array];
    if ([receivedSellers isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedSellers) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedSellers addObject:[Sellers modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedSellers isKindOfClass:[NSDictionary class]]) {
       [parsedSellers addObject:[Sellers modelObjectWithDictionary:(NSDictionary *)receivedSellers]];
    }

    self.sellers = [NSArray arrayWithArray:parsedSellers];
            self.totalpage = [self objectOrNilForKey:kCollectionHotelListModelTotalpage fromDictionary:dict];
            self.totalcount = [self objectOrNilForKey:kCollectionHotelListModelTotalcount fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    NSMutableArray *tempArrayForSellers = [NSMutableArray array];
    for (NSObject *subArrayObject in self.sellers) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForSellers addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForSellers addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForSellers] forKey:kCollectionHotelListModelSellers];
    [mutableDict setValue:self.totalpage forKey:kCollectionHotelListModelTotalpage];
    [mutableDict setValue:self.totalcount forKey:kCollectionHotelListModelTotalcount];

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

    self.sellers = [aDecoder decodeObjectForKey:kCollectionHotelListModelSellers];
    self.totalpage = [aDecoder decodeObjectForKey:kCollectionHotelListModelTotalpage];
    self.totalcount = [aDecoder decodeObjectForKey:kCollectionHotelListModelTotalcount];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_sellers forKey:kCollectionHotelListModelSellers];
    [aCoder encodeObject:_totalpage forKey:kCollectionHotelListModelTotalpage];
    [aCoder encodeObject:_totalcount forKey:kCollectionHotelListModelTotalcount];
}

- (id)copyWithZone:(NSZone *)zone
{
    CollectionHotelListModel *copy = [[CollectionHotelListModel alloc] init];
    
    if (copy) {

        copy.sellers = [self.sellers copyWithZone:zone];
        copy.totalpage = [self.totalpage copyWithZone:zone];
        copy.totalcount = [self.totalcount copyWithZone:zone];
    }
    
    return copy;
}


@end
