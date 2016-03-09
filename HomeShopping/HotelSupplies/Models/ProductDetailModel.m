//
//  ProductDetailModel.m
//
//  Created by sooncong  on 15/12/30
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "ProductDetailModel.h"
#import "ProductDetail.h"


NSString *const kProductDetailModelProductDetail = @"product";


@interface ProductDetailModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ProductDetailModel

@synthesize productDetail = _productDetail;


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
            self.productDetail = [ProductDetail modelObjectWithDictionary:[dict objectForKey:kProductDetailModelProductDetail]];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[self.productDetail dictionaryRepresentation] forKey:kProductDetailModelProductDetail];

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

    self.productDetail = [aDecoder decodeObjectForKey:kProductDetailModelProductDetail];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_productDetail forKey:kProductDetailModelProductDetail];
}

- (id)copyWithZone:(NSZone *)zone
{
    ProductDetailModel *copy = [[ProductDetailModel alloc] init];
    
    if (copy) {

        copy.productDetail = [self.productDetail copyWithZone:zone];
    }
    
    return copy;
}


@end
