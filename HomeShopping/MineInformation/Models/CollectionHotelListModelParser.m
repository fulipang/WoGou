//
//  CollectionHotelListModelParser.m
//
//  Created by sooncong  on 16/1/20
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "CollectionHotelListModelParser.h"


NSString *const kCollectionHotelListModelParserCollectionHotelListModel = @"body";


@interface CollectionHotelListModelParser ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation CollectionHotelListModelParser

@synthesize collectionHotelListModel = _collectionHotelListModel;


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
            self.collectionHotelListModel = [CollectionHotelListModel modelObjectWithDictionary:[dict objectForKey:kCollectionHotelListModelParserCollectionHotelListModel]];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[self.collectionHotelListModel dictionaryRepresentation] forKey:kCollectionHotelListModelParserCollectionHotelListModel];

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

    self.collectionHotelListModel = [aDecoder decodeObjectForKey:kCollectionHotelListModelParserCollectionHotelListModel];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_collectionHotelListModel forKey:kCollectionHotelListModelParserCollectionHotelListModel];
}

- (id)copyWithZone:(NSZone *)zone
{
    CollectionHotelListModelParser *copy = [[CollectionHotelListModelParser alloc] init];
    
    if (copy) {

        copy.collectionHotelListModel = [self.collectionHotelListModel copyWithZone:zone];
    }
    
    return copy;
}


@end
