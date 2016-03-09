//
//  CollectionModel.m
//
//  Created by sooncong  on 16/1/17
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "CollectionModel.h"
#import "CollectionProduct.h"


NSString *const kCollectionModelTotalpage = @"totalpage";
NSString *const kCollectionModelCollectionProduct = @"products";
NSString *const kCollectionModelTotalcount = @"totalcount";


@interface CollectionModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation CollectionModel

@synthesize totalpage = _totalpage;
@synthesize collectionProduct = _collectionProduct;
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
            self.totalpage = [self objectOrNilForKey:kCollectionModelTotalpage fromDictionary:dict];
    NSObject *receivedCollectionProduct = [dict objectForKey:kCollectionModelCollectionProduct];
    NSMutableArray *parsedCollectionProduct = [NSMutableArray array];
    if ([receivedCollectionProduct isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedCollectionProduct) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedCollectionProduct addObject:[CollectionProduct modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedCollectionProduct isKindOfClass:[NSDictionary class]]) {
       [parsedCollectionProduct addObject:[CollectionProduct modelObjectWithDictionary:(NSDictionary *)receivedCollectionProduct]];
    }

    self.collectionProduct = [NSArray arrayWithArray:parsedCollectionProduct];
            self.totalcount = [self objectOrNilForKey:kCollectionModelTotalcount fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.totalpage forKey:kCollectionModelTotalpage];
    NSMutableArray *tempArrayForCollectionProduct = [NSMutableArray array];
    for (NSObject *subArrayObject in self.collectionProduct) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForCollectionProduct addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForCollectionProduct addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForCollectionProduct] forKey:kCollectionModelCollectionProduct];
    [mutableDict setValue:self.totalcount forKey:kCollectionModelTotalcount];

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

    self.totalpage = [aDecoder decodeObjectForKey:kCollectionModelTotalpage];
    self.collectionProduct = [aDecoder decodeObjectForKey:kCollectionModelCollectionProduct];
    self.totalcount = [aDecoder decodeObjectForKey:kCollectionModelTotalcount];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_totalpage forKey:kCollectionModelTotalpage];
    [aCoder encodeObject:_collectionProduct forKey:kCollectionModelCollectionProduct];
    [aCoder encodeObject:_totalcount forKey:kCollectionModelTotalcount];
}

- (id)copyWithZone:(NSZone *)zone
{
    CollectionModel *copy = [[CollectionModel alloc] init];
    
    if (copy) {

        copy.totalpage = [self.totalpage copyWithZone:zone];
        copy.collectionProduct = [self.collectionProduct copyWithZone:zone];
        copy.totalcount = [self.totalcount copyWithZone:zone];
    }
    
    return copy;
}


@end
