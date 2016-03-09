//
//  HPAddsModel.m
//
//  Created by sooncong  on 15/12/19
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "HPAddsModel.h"


NSString *const kHPAddsModelLinktype = @"linktype";
NSString *const kHPAddsModelTitle = @"title";
NSString *const kHPAddsModelLinkcontent = @"linkcontent";
NSString *const kHPAddsModelLogo = @"logo";
NSString *const kHPAddsModelProducttype = @"producttype";


@interface HPAddsModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation HPAddsModel

@synthesize linktype = _linktype;
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
            self.linktype = [self objectOrNilForKey:kHPAddsModelLinktype fromDictionary:dict];
            self.title = [self objectOrNilForKey:kHPAddsModelTitle fromDictionary:dict];
            self.linkcontent = [self objectOrNilForKey:kHPAddsModelLinkcontent fromDictionary:dict];
            self.logo = [self objectOrNilForKey:kHPAddsModelLogo fromDictionary:dict];
            self.producttype = [self objectOrNilForKey:kHPAddsModelProducttype fromDictionary:dict];


    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.linktype forKey:kHPAddsModelLinktype];
    [mutableDict setValue:self.title forKey:kHPAddsModelTitle];
    [mutableDict setValue:self.linkcontent forKey:kHPAddsModelLinkcontent];
    [mutableDict setValue:self.logo forKey:kHPAddsModelLogo];
    [mutableDict setValue:self.producttype forKey:kHPAddsModelProducttype];

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

    self.linktype = [aDecoder decodeObjectForKey:kHPAddsModelLinktype];
    self.title = [aDecoder decodeObjectForKey:kHPAddsModelTitle];
    self.linkcontent = [aDecoder decodeObjectForKey:kHPAddsModelLinkcontent];
    self.logo = [aDecoder decodeObjectForKey:kHPAddsModelLogo];
    self.producttype = [aDecoder decodeObjectForKey:kHPAddsModelProducttype];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_linktype forKey:kHPAddsModelLinktype];
    [aCoder encodeObject:_title forKey:kHPAddsModelTitle];
    [aCoder encodeObject:_linkcontent forKey:kHPAddsModelLinkcontent];
    [aCoder encodeObject:_logo forKey:kHPAddsModelLogo];
    [aCoder encodeObject:_logo forKey:kHPAddsModelProducttype];

}

- (id)copyWithZone:(NSZone *)zone
{
    HPAddsModel *copy = [[HPAddsModel alloc] init];
    
    if (copy) {

        copy.linktype = [self.linktype copyWithZone:zone];
        copy.title = [self.title copyWithZone:zone];
        copy.linkcontent = [self.linkcontent copyWithZone:zone];
        copy.logo = [self.logo copyWithZone:zone];
    }
    
    return copy;
}


@end
