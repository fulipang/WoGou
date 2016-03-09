//
//  HSSubcategory.m
//
//  Created by sooncong  on 15/12/22
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "HSSubcategory.h"


NSString *const kHSSubcategorySubisleaf = @"subisleaf";
NSString *const kHSSubcategoryProducttype = @"producttype";
NSString *const kHSSubcategorySubparentid = @"subparentid";
NSString *const kHSSubcategorySubtitle = @"subtitle";
NSString *const kHSSubcategorySubcategorylogo = @"subcategorylogo";
NSString *const kHSSubcategorySubcategoryid = @"subcategoryid";


@interface HSSubcategory ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation HSSubcategory

@synthesize subisleaf = _subisleaf;
@synthesize producttype = _producttype;
@synthesize subparentid = _subparentid;
@synthesize subtitle = _subtitle;
@synthesize subcategorylogo = _subcategorylogo;
@synthesize subcategoryid = _subcategoryid;


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
            self.subisleaf = [self objectOrNilForKey:kHSSubcategorySubisleaf fromDictionary:dict];
            self.producttype = [self objectOrNilForKey:kHSSubcategoryProducttype fromDictionary:dict];
            self.subparentid = [self objectOrNilForKey:kHSSubcategorySubparentid fromDictionary:dict];
            self.subtitle = [self objectOrNilForKey:kHSSubcategorySubtitle fromDictionary:dict];
            self.subcategorylogo = [self objectOrNilForKey:kHSSubcategorySubcategorylogo fromDictionary:dict];
            self.subcategoryid = [self objectOrNilForKey:kHSSubcategorySubcategoryid fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.subisleaf forKey:kHSSubcategorySubisleaf];
    [mutableDict setValue:self.producttype forKey:kHSSubcategoryProducttype];
    [mutableDict setValue:self.subparentid forKey:kHSSubcategorySubparentid];
    [mutableDict setValue:self.subtitle forKey:kHSSubcategorySubtitle];
    [mutableDict setValue:self.subcategorylogo forKey:kHSSubcategorySubcategorylogo];
    [mutableDict setValue:self.subcategoryid forKey:kHSSubcategorySubcategoryid];

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

    self.subisleaf = [aDecoder decodeObjectForKey:kHSSubcategorySubisleaf];
    self.producttype = [aDecoder decodeObjectForKey:kHSSubcategoryProducttype];
    self.subparentid = [aDecoder decodeObjectForKey:kHSSubcategorySubparentid];
    self.subtitle = [aDecoder decodeObjectForKey:kHSSubcategorySubtitle];
    self.subcategorylogo = [aDecoder decodeObjectForKey:kHSSubcategorySubcategorylogo];
    self.subcategoryid = [aDecoder decodeObjectForKey:kHSSubcategorySubcategoryid];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_subisleaf forKey:kHSSubcategorySubisleaf];
    [aCoder encodeObject:_producttype forKey:kHSSubcategoryProducttype];
    [aCoder encodeObject:_subparentid forKey:kHSSubcategorySubparentid];
    [aCoder encodeObject:_subtitle forKey:kHSSubcategorySubtitle];
    [aCoder encodeObject:_subcategorylogo forKey:kHSSubcategorySubcategorylogo];
    [aCoder encodeObject:_subcategoryid forKey:kHSSubcategorySubcategoryid];
}

- (id)copyWithZone:(NSZone *)zone
{
    HSSubcategory *copy = [[HSSubcategory alloc] init];
    
    if (copy) {

        copy.subisleaf = [self.subisleaf copyWithZone:zone];
        copy.producttype = [self.producttype copyWithZone:zone];
        copy.subparentid = [self.subparentid copyWithZone:zone];
        copy.subtitle = [self.subtitle copyWithZone:zone];
        copy.subcategorylogo = [self.subcategorylogo copyWithZone:zone];
        copy.subcategoryid = [self.subcategoryid copyWithZone:zone];
    }
    
    return copy;
}


@end
