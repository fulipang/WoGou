//
//  HPCategorysModel.m
//
//  Created by sooncong  on 15/12/19
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "HPCategorysModel.h"


NSString *const kHPCategorysModelCategoryid = @"categoryid";
NSString *const kHPCategorysModelProducttype = @"producttype";
NSString *const kHPCategorysModelTitle = @"title";
NSString *const kHPCategorysModelParentid = @"parentid";
NSString *const kHPCategorysModelLogo = @"logo";


@interface HPCategorysModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation HPCategorysModel

@synthesize categoryid = _categoryid;
@synthesize producttype = _producttype;
@synthesize title = _title;
@synthesize parentid = _parentid;
@synthesize logo = _logo;


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
            self.categoryid = [self objectOrNilForKey:kHPCategorysModelCategoryid fromDictionary:dict];
            self.producttype = [self objectOrNilForKey:kHPCategorysModelProducttype fromDictionary:dict];
            self.title = [self objectOrNilForKey:kHPCategorysModelTitle fromDictionary:dict];
            self.parentid = [self objectOrNilForKey:kHPCategorysModelParentid fromDictionary:dict];
            self.logo = [self objectOrNilForKey:kHPCategorysModelLogo fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.categoryid forKey:kHPCategorysModelCategoryid];
    [mutableDict setValue:self.producttype forKey:kHPCategorysModelProducttype];
    [mutableDict setValue:self.title forKey:kHPCategorysModelTitle];
    [mutableDict setValue:self.parentid forKey:kHPCategorysModelParentid];
    [mutableDict setValue:self.logo forKey:kHPCategorysModelLogo];

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

    self.categoryid = [aDecoder decodeObjectForKey:kHPCategorysModelCategoryid];
    self.producttype = [aDecoder decodeObjectForKey:kHPCategorysModelProducttype];
    self.title = [aDecoder decodeObjectForKey:kHPCategorysModelTitle];
    self.parentid = [aDecoder decodeObjectForKey:kHPCategorysModelParentid];
    self.logo = [aDecoder decodeObjectForKey:kHPCategorysModelLogo];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_categoryid forKey:kHPCategorysModelCategoryid];
    [aCoder encodeObject:_producttype forKey:kHPCategorysModelProducttype];
    [aCoder encodeObject:_title forKey:kHPCategorysModelTitle];
    [aCoder encodeObject:_parentid forKey:kHPCategorysModelParentid];
    [aCoder encodeObject:_logo forKey:kHPCategorysModelLogo];
}

- (id)copyWithZone:(NSZone *)zone
{
    HPCategorysModel *copy = [[HPCategorysModel alloc] init];
    
    if (copy) {

        copy.categoryid = [self.categoryid copyWithZone:zone];
        copy.producttype = [self.producttype copyWithZone:zone];
        copy.title = [self.title copyWithZone:zone];
        copy.parentid = [self.parentid copyWithZone:zone];
        copy.logo = [self.logo copyWithZone:zone];
    }
    
    return copy;
}


@end
