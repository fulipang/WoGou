//
//  Subareas.m
//
//  Created by sooncong  on 16/1/4
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "Subareas.h"


NSString *const kSubareasSubisleaf = @"subisleaf";
NSString *const kSubareasSubparentid = @"subparentid";
NSString *const kSubareasSubtitle = @"subtitle";
NSString *const kSubareasSubareaid = @"subareaid";


@interface Subareas ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation Subareas

@synthesize subisleaf = _subisleaf;
@synthesize subparentid = _subparentid;
@synthesize subtitle = _subtitle;
@synthesize subareaid = _subareaid;


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
            self.subisleaf = [self objectOrNilForKey:kSubareasSubisleaf fromDictionary:dict];
            self.subparentid = [self objectOrNilForKey:kSubareasSubparentid fromDictionary:dict];
            self.subtitle = [self objectOrNilForKey:kSubareasSubtitle fromDictionary:dict];
            self.subareaid = [self objectOrNilForKey:kSubareasSubareaid fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.subisleaf forKey:kSubareasSubisleaf];
    [mutableDict setValue:self.subparentid forKey:kSubareasSubparentid];
    [mutableDict setValue:self.subtitle forKey:kSubareasSubtitle];
    [mutableDict setValue:self.subareaid forKey:kSubareasSubareaid];

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

    self.subisleaf = [aDecoder decodeObjectForKey:kSubareasSubisleaf];
    self.subparentid = [aDecoder decodeObjectForKey:kSubareasSubparentid];
    self.subtitle = [aDecoder decodeObjectForKey:kSubareasSubtitle];
    self.subareaid = [aDecoder decodeObjectForKey:kSubareasSubareaid];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_subisleaf forKey:kSubareasSubisleaf];
    [aCoder encodeObject:_subparentid forKey:kSubareasSubparentid];
    [aCoder encodeObject:_subtitle forKey:kSubareasSubtitle];
    [aCoder encodeObject:_subareaid forKey:kSubareasSubareaid];
}

- (id)copyWithZone:(NSZone *)zone
{
    Subareas *copy = [[Subareas alloc] init];
    
    if (copy) {

        copy.subisleaf = [self.subisleaf copyWithZone:zone];
        copy.subparentid = [self.subparentid copyWithZone:zone];
        copy.subtitle = [self.subtitle copyWithZone:zone];
        copy.subareaid = [self.subareaid copyWithZone:zone];
    }
    
    return copy;
}


@end
