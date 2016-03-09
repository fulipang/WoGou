//
//  ProductSortModelParser.m
//
//  Created by sooncong  on 16/1/5
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "ProductSortModelParser.h"

NSString *const kProductSortModelParserProductSortModel = @"body";


@interface ProductSortModelParser ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ProductSortModelParser

@synthesize productSortModel = _productSortModel;


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
            self.productSortModel = [ProductSortModel modelObjectWithDictionary:[dict objectForKey:kProductSortModelParserProductSortModel]];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[self.productSortModel dictionaryRepresentation] forKey:kProductSortModelParserProductSortModel];

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

    self.productSortModel = [aDecoder decodeObjectForKey:kProductSortModelParserProductSortModel];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_productSortModel forKey:kProductSortModelParserProductSortModel];
}

- (id)copyWithZone:(NSZone *)zone
{
    ProductSortModelParser *copy = [[ProductSortModelParser alloc] init];
    
    if (copy) {

        copy.productSortModel = [self.productSortModel copyWithZone:zone];
    }
    
    return copy;
}


@end
