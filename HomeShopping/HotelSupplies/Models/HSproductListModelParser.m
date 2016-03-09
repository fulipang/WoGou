//
//  HSproductListModelParser.m
//
//  Created by sooncong  on 15/12/24
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "HSproductListModelParser.h"


NSString *const kHSproductListModelParserProductListModel = @"body";


@interface HSproductListModelParser ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation HSproductListModelParser

@synthesize productListModel = _productListModel;


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
            self.productListModel = [HSProductListModel modelObjectWithDictionary:[dict objectForKey:kHSproductListModelParserProductListModel]];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[self.productListModel dictionaryRepresentation] forKey:kHSproductListModelParserProductListModel];

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

    self.productListModel = [aDecoder decodeObjectForKey:kHSproductListModelParserProductListModel];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_productListModel forKey:kHSproductListModelParserProductListModel];
}

- (id)copyWithZone:(NSZone *)zone
{
    HSproductListModelParser *copy = [[HSproductListModelParser alloc] init];
    
    if (copy) {

        copy.productListModel = [self.productListModel copyWithZone:zone];
    }
    
    return copy;
}


@end
