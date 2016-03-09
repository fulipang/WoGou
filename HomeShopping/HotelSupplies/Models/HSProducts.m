//
//  HSProducts.m
//
//  Created by sooncong  on 15/12/22
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "HSProducts.h"
#import "HSSubcategorys.h"


NSString *const kHSProductsIsleaf = @"isleaf";
NSString *const kHSProductsCategorylogo = @"categorylogo";
NSString *const kHSProductsParentid = @"parentid";
NSString *const kHSProductsCategoryid = @"categoryid";
NSString *const kHSProductsProducttype = @"producttype";
NSString *const kHSProductsTitle = @"title";
NSString *const kHSProductsSubcategorys = @"subcategorys";


@interface HSProducts ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation HSProducts

@synthesize isleaf = _isleaf;
@synthesize categorylogo = _categorylogo;
@synthesize parentid = _parentid;
@synthesize categoryid = _categoryid;
@synthesize producttype = _producttype;
@synthesize title = _title;
@synthesize subcategorys = _subcategorys;


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
            self.isleaf = [self objectOrNilForKey:kHSProductsIsleaf fromDictionary:dict];
            self.categorylogo = [self objectOrNilForKey:kHSProductsCategorylogo fromDictionary:dict];
            self.parentid = [self objectOrNilForKey:kHSProductsParentid fromDictionary:dict];
            self.categoryid = [self objectOrNilForKey:kHSProductsCategoryid fromDictionary:dict];
            self.producttype = [self objectOrNilForKey:kHSProductsProducttype fromDictionary:dict];
            self.title = [self objectOrNilForKey:kHSProductsTitle fromDictionary:dict];
    NSObject *receivedHSSubcategorys = [dict objectForKey:kHSProductsSubcategorys];
    NSMutableArray *parsedHSSubcategorys = [NSMutableArray array];
    if ([receivedHSSubcategorys isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedHSSubcategorys) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedHSSubcategorys addObject:[HSSubcategorys modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedHSSubcategorys isKindOfClass:[NSDictionary class]]) {
       [parsedHSSubcategorys addObject:[HSSubcategorys modelObjectWithDictionary:(NSDictionary *)receivedHSSubcategorys]];
    }

    self.subcategorys = [NSArray arrayWithArray:parsedHSSubcategorys];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.isleaf forKey:kHSProductsIsleaf];
    [mutableDict setValue:self.categorylogo forKey:kHSProductsCategorylogo];
    [mutableDict setValue:self.parentid forKey:kHSProductsParentid];
    [mutableDict setValue:self.categoryid forKey:kHSProductsCategoryid];
    [mutableDict setValue:self.producttype forKey:kHSProductsProducttype];
    [mutableDict setValue:self.title forKey:kHSProductsTitle];
    NSMutableArray *tempArrayForSubcategorys = [NSMutableArray array];
    for (NSObject *subArrayObject in self.subcategorys) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForSubcategorys addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForSubcategorys addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForSubcategorys] forKey:kHSProductsSubcategorys];

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

    self.isleaf = [aDecoder decodeObjectForKey:kHSProductsIsleaf];
    self.categorylogo = [aDecoder decodeObjectForKey:kHSProductsCategorylogo];
    self.parentid = [aDecoder decodeObjectForKey:kHSProductsParentid];
    self.categoryid = [aDecoder decodeObjectForKey:kHSProductsCategoryid];
    self.producttype = [aDecoder decodeObjectForKey:kHSProductsProducttype];
    self.title = [aDecoder decodeObjectForKey:kHSProductsTitle];
    self.subcategorys = [aDecoder decodeObjectForKey:kHSProductsSubcategorys];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_isleaf forKey:kHSProductsIsleaf];
    [aCoder encodeObject:_categorylogo forKey:kHSProductsCategorylogo];
    [aCoder encodeObject:_parentid forKey:kHSProductsParentid];
    [aCoder encodeObject:_categoryid forKey:kHSProductsCategoryid];
    [aCoder encodeObject:_producttype forKey:kHSProductsProducttype];
    [aCoder encodeObject:_title forKey:kHSProductsTitle];
    [aCoder encodeObject:_subcategorys forKey:kHSProductsSubcategorys];
}

- (id)copyWithZone:(NSZone *)zone
{
    HSProducts *copy = [[HSProducts alloc] init];
    
    if (copy) {

        copy.isleaf = [self.isleaf copyWithZone:zone];
        copy.categorylogo = [self.categorylogo copyWithZone:zone];
        copy.parentid = [self.parentid copyWithZone:zone];
        copy.categoryid = [self.categoryid copyWithZone:zone];
        copy.producttype = [self.producttype copyWithZone:zone];
        copy.title = [self.title copyWithZone:zone];
        copy.subcategorys = [self.subcategorys copyWithZone:zone];
    }
    
    return copy;
}


@end
