//
//  Areas.m
//
//  Created by sooncong  on 16/1/4
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "Areas.h"
#import "Subareas.h"


NSString *const kAreasAreaid = @"areaid";
NSString *const kAreasTitle = @"title";
NSString *const kAreasIsleaf = @"isleaf";
NSString *const kAreasSubareas = @"subareas";
NSString *const kAreasParentid = @"parentid";


@interface Areas ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation Areas

@synthesize areaid = _areaid;
@synthesize title = _title;
@synthesize isleaf = _isleaf;
@synthesize subareas = _subareas;
@synthesize parentid = _parentid;


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
            self.areaid = [self objectOrNilForKey:kAreasAreaid fromDictionary:dict];
            self.title = [self objectOrNilForKey:kAreasTitle fromDictionary:dict];
            self.isleaf = [self objectOrNilForKey:kAreasIsleaf fromDictionary:dict];
    NSObject *receivedSubareas = [dict objectForKey:kAreasSubareas];
    NSMutableArray *parsedSubareas = [NSMutableArray array];
    if ([receivedSubareas isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedSubareas) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedSubareas addObject:[Subareas modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedSubareas isKindOfClass:[NSDictionary class]]) {
       [parsedSubareas addObject:[Subareas modelObjectWithDictionary:(NSDictionary *)receivedSubareas]];
    }

    self.subareas = [NSArray arrayWithArray:parsedSubareas];
            self.parentid = [self objectOrNilForKey:kAreasParentid fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.areaid forKey:kAreasAreaid];
    [mutableDict setValue:self.title forKey:kAreasTitle];
    [mutableDict setValue:self.isleaf forKey:kAreasIsleaf];
    NSMutableArray *tempArrayForSubareas = [NSMutableArray array];
    for (NSObject *subArrayObject in self.subareas) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForSubareas addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForSubareas addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForSubareas] forKey:kAreasSubareas];
    [mutableDict setValue:self.parentid forKey:kAreasParentid];

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

    self.areaid = [aDecoder decodeObjectForKey:kAreasAreaid];
    self.title = [aDecoder decodeObjectForKey:kAreasTitle];
    self.isleaf = [aDecoder decodeObjectForKey:kAreasIsleaf];
    self.subareas = [aDecoder decodeObjectForKey:kAreasSubareas];
    self.parentid = [aDecoder decodeObjectForKey:kAreasParentid];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_areaid forKey:kAreasAreaid];
    [aCoder encodeObject:_title forKey:kAreasTitle];
    [aCoder encodeObject:_isleaf forKey:kAreasIsleaf];
    [aCoder encodeObject:_subareas forKey:kAreasSubareas];
    [aCoder encodeObject:_parentid forKey:kAreasParentid];
}

- (id)copyWithZone:(NSZone *)zone
{
    Areas *copy = [[Areas alloc] init];
    
    if (copy) {

        copy.areaid = [self.areaid copyWithZone:zone];
        copy.title = [self.title copyWithZone:zone];
        copy.isleaf = [self.isleaf copyWithZone:zone];
        copy.subareas = [self.subareas copyWithZone:zone];
        copy.parentid = [self.parentid copyWithZone:zone];
    }
    
    return copy;
}


@end
