//
//  HSAdsLists.m
//
//  Created by sooncong  on 15/12/22
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "HSAdsLists.h"


NSString *const kHSAdsListsLinktype = @"linktype";
NSString *const kHSAdsListsProducttype = @"producttype";
NSString *const kHSAdsListsTitle = @"title";
NSString *const kHSAdsListsLinkcontent = @"linkcontent";
NSString *const kHSAdsListsLogo = @"logo";


@interface HSAdsLists ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation HSAdsLists

@synthesize linktype = _linktype;
@synthesize producttype = _producttype;
@synthesize title = _title;
@synthesize linkcontent = _linkcontent;
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
            self.linktype = [self objectOrNilForKey:kHSAdsListsLinktype fromDictionary:dict];
            self.producttype = [self objectOrNilForKey:kHSAdsListsProducttype fromDictionary:dict];
            self.title = [self objectOrNilForKey:kHSAdsListsTitle fromDictionary:dict];
            self.linkcontent = [self objectOrNilForKey:kHSAdsListsLinkcontent fromDictionary:dict];
            self.logo = [self objectOrNilForKey:kHSAdsListsLogo fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.linktype forKey:kHSAdsListsLinktype];
    [mutableDict setValue:self.producttype forKey:kHSAdsListsProducttype];
    [mutableDict setValue:self.title forKey:kHSAdsListsTitle];
    [mutableDict setValue:self.linkcontent forKey:kHSAdsListsLinkcontent];
    [mutableDict setValue:self.logo forKey:kHSAdsListsLogo];

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

    self.linktype = [aDecoder decodeObjectForKey:kHSAdsListsLinktype];
    self.producttype = [aDecoder decodeObjectForKey:kHSAdsListsProducttype];
    self.title = [aDecoder decodeObjectForKey:kHSAdsListsTitle];
    self.linkcontent = [aDecoder decodeObjectForKey:kHSAdsListsLinkcontent];
    self.logo = [aDecoder decodeObjectForKey:kHSAdsListsLogo];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_linktype forKey:kHSAdsListsLinktype];
    [aCoder encodeObject:_producttype forKey:kHSAdsListsProducttype];
    [aCoder encodeObject:_title forKey:kHSAdsListsTitle];
    [aCoder encodeObject:_linkcontent forKey:kHSAdsListsLinkcontent];
    [aCoder encodeObject:_logo forKey:kHSAdsListsLogo];
}

- (id)copyWithZone:(NSZone *)zone
{
    HSAdsLists *copy = [[HSAdsLists alloc] init];
    
    if (copy) {

        copy.linktype = [self.linktype copyWithZone:zone];
        copy.producttype = [self.producttype copyWithZone:zone];
        copy.title = [self.title copyWithZone:zone];
        copy.linkcontent = [self.linkcontent copyWithZone:zone];
        copy.logo = [self.logo copyWithZone:zone];
    }
    
    return copy;
}


@end
