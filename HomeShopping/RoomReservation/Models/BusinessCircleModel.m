//
//  BusinessCircleModel.m
//
//  Created by sooncong  on 16/1/4
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "BusinessCircleModel.h"
#import "Areas.h"


NSString *const kBusinessCircleModelAreas = @"areas";
NSString *const kBusinessCircleModelTotalcount = @"totalcount";


@interface BusinessCircleModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation BusinessCircleModel

@synthesize areas = _areas;
@synthesize totalcount = _totalcount;


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
    NSObject *receivedAreas = [dict objectForKey:kBusinessCircleModelAreas];
    NSMutableArray *parsedAreas = [NSMutableArray array];
    if ([receivedAreas isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedAreas) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedAreas addObject:[Areas modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedAreas isKindOfClass:[NSDictionary class]]) {
       [parsedAreas addObject:[Areas modelObjectWithDictionary:(NSDictionary *)receivedAreas]];
    }

    self.areas = [NSArray arrayWithArray:parsedAreas];
            self.totalcount = [self objectOrNilForKey:kBusinessCircleModelTotalcount fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    NSMutableArray *tempArrayForAreas = [NSMutableArray array];
    for (NSObject *subArrayObject in self.areas) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForAreas addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForAreas addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForAreas] forKey:kBusinessCircleModelAreas];
    [mutableDict setValue:self.totalcount forKey:kBusinessCircleModelTotalcount];

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

    self.areas = [aDecoder decodeObjectForKey:kBusinessCircleModelAreas];
    self.totalcount = [aDecoder decodeObjectForKey:kBusinessCircleModelTotalcount];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_areas forKey:kBusinessCircleModelAreas];
    [aCoder encodeObject:_totalcount forKey:kBusinessCircleModelTotalcount];
}

- (id)copyWithZone:(NSZone *)zone
{
    BusinessCircleModel *copy = [[BusinessCircleModel alloc] init];
    
    if (copy) {

        copy.areas = [self.areas copyWithZone:zone];
        copy.totalcount = [self.totalcount copyWithZone:zone];
    }
    
    return copy;
}


@end
