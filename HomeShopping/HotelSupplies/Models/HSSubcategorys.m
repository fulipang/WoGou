//
//  HSSubcategorys.m
//
//  Created by sooncong  on 15/12/22
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "HSSubcategorys.h"
#import "HSSubcategory.h"


NSString *const kHSSubcategorysSubparentid = @"subparentid";
NSString *const kHSSubcategorysSubtitle = @"subtitle";
NSString *const kHSSubcategorysProducttype = @"producttype";
NSString *const kHSSubcategorysSubcategoryid = @"subcategoryid";
NSString *const kHSSubcategorysSubcategorylogo = @"subcategorylogo";
NSString *const kHSSubcategorysSubisleaf = @"subisleaf";
NSString *const kHSSubcategorysSubcategory = @"subcategory";


@interface HSSubcategorys ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation HSSubcategorys

@synthesize subparentid = _subparentid;
@synthesize subtitle = _subtitle;
@synthesize producttype = _producttype;
@synthesize subcategoryid = _subcategoryid;
@synthesize subcategorylogo = _subcategorylogo;
@synthesize subisleaf = _subisleaf;
@synthesize subcategory = _subcategory;


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
            self.subparentid = [self objectOrNilForKey:kHSSubcategorysSubparentid fromDictionary:dict];
            self.subtitle = [self objectOrNilForKey:kHSSubcategorysSubtitle fromDictionary:dict];
            self.producttype = [self objectOrNilForKey:kHSSubcategorysProducttype fromDictionary:dict];
            self.subcategoryid = [self objectOrNilForKey:kHSSubcategorysSubcategoryid fromDictionary:dict];
            self.subcategorylogo = [self objectOrNilForKey:kHSSubcategorysSubcategorylogo fromDictionary:dict];
            self.subisleaf = [self objectOrNilForKey:kHSSubcategorysSubisleaf fromDictionary:dict];
            self.subcategory = [HSSubcategory modelObjectWithDictionary:[dict objectForKey:kHSSubcategorysSubcategory]];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.subparentid forKey:kHSSubcategorysSubparentid];
    [mutableDict setValue:self.subtitle forKey:kHSSubcategorysSubtitle];
    [mutableDict setValue:self.producttype forKey:kHSSubcategorysProducttype];
    [mutableDict setValue:self.subcategoryid forKey:kHSSubcategorysSubcategoryid];
    [mutableDict setValue:self.subcategorylogo forKey:kHSSubcategorysSubcategorylogo];
    [mutableDict setValue:self.subisleaf forKey:kHSSubcategorysSubisleaf];
    [mutableDict setValue:[self.subcategory dictionaryRepresentation] forKey:kHSSubcategorysSubcategory];

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

    self.subparentid = [aDecoder decodeObjectForKey:kHSSubcategorysSubparentid];
    self.subtitle = [aDecoder decodeObjectForKey:kHSSubcategorysSubtitle];
    self.producttype = [aDecoder decodeObjectForKey:kHSSubcategorysProducttype];
    self.subcategoryid = [aDecoder decodeObjectForKey:kHSSubcategorysSubcategoryid];
    self.subcategorylogo = [aDecoder decodeObjectForKey:kHSSubcategorysSubcategorylogo];
    self.subisleaf = [aDecoder decodeObjectForKey:kHSSubcategorysSubisleaf];
    self.subcategory = [aDecoder decodeObjectForKey:kHSSubcategorysSubcategory];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_subparentid forKey:kHSSubcategorysSubparentid];
    [aCoder encodeObject:_subtitle forKey:kHSSubcategorysSubtitle];
    [aCoder encodeObject:_producttype forKey:kHSSubcategorysProducttype];
    [aCoder encodeObject:_subcategoryid forKey:kHSSubcategorysSubcategoryid];
    [aCoder encodeObject:_subcategorylogo forKey:kHSSubcategorysSubcategorylogo];
    [aCoder encodeObject:_subisleaf forKey:kHSSubcategorysSubisleaf];
    [aCoder encodeObject:_subcategory forKey:kHSSubcategorysSubcategory];
}

- (id)copyWithZone:(NSZone *)zone
{
    HSSubcategorys *copy = [[HSSubcategorys alloc] init];
    
    if (copy) {

        copy.subparentid = [self.subparentid copyWithZone:zone];
        copy.subtitle = [self.subtitle copyWithZone:zone];
        copy.producttype = [self.producttype copyWithZone:zone];
        copy.subcategoryid = [self.subcategoryid copyWithZone:zone];
        copy.subcategorylogo = [self.subcategorylogo copyWithZone:zone];
        copy.subisleaf = [self.subisleaf copyWithZone:zone];
        copy.subcategory = [self.subcategory copyWithZone:zone];
    }
    
    return copy;
}


@end
