//
//  ProductDetailModelParser.m
//
//  Created by sooncong  on 15/12/30
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "ProductDetailModelParser.h"


NSString *const kProductDetailModelParserProductDetailModel = @"body";


@interface ProductDetailModelParser ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ProductDetailModelParser

@synthesize productDetailModel = _productDetailModel;


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
            self.productDetailModel = [ProductDetailModel modelObjectWithDictionary:[dict objectForKey:kProductDetailModelParserProductDetailModel]];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[self.productDetailModel dictionaryRepresentation] forKey:kProductDetailModelParserProductDetailModel];

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

    self.productDetailModel = [aDecoder decodeObjectForKey:kProductDetailModelParserProductDetailModel];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_productDetailModel forKey:kProductDetailModelParserProductDetailModel];
}

- (id)copyWithZone:(NSZone *)zone
{
    ProductDetailModelParser *copy = [[ProductDetailModelParser alloc] init];
    
    if (copy) {

        copy.productDetailModel = [self.productDetailModel copyWithZone:zone];
    }
    
    return copy;
}


@end
