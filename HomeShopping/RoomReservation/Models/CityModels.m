//
//  CityModels.m
//
//  Created by sooncong  on 16/1/15
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "CityModels.h"
#import "CityModel.h"


NSString *const kCityModelsCityModel = @"citys";
NSString *const kCityModelsTotalpage = @"totalpage";
NSString *const kCityModelsTotalcount = @"totalcount";


@interface CityModels ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation CityModels

@synthesize cityModel = _cityModel;
@synthesize totalpage = _totalpage;
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
    NSObject *receivedCityModel = [dict objectForKey:kCityModelsCityModel];
    NSMutableArray *parsedCityModel = [NSMutableArray array];
    if ([receivedCityModel isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedCityModel) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedCityModel addObject:[CityModel modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedCityModel isKindOfClass:[NSDictionary class]]) {
       [parsedCityModel addObject:[CityModel modelObjectWithDictionary:(NSDictionary *)receivedCityModel]];
    }

    self.cityModel = [NSArray arrayWithArray:parsedCityModel];
            self.totalpage = [self objectOrNilForKey:kCityModelsTotalpage fromDictionary:dict];
            self.totalcount = [self objectOrNilForKey:kCityModelsTotalcount fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    NSMutableArray *tempArrayForCityModel = [NSMutableArray array];
    for (NSObject *subArrayObject in self.cityModel) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForCityModel addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForCityModel addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForCityModel] forKey:kCityModelsCityModel];
    [mutableDict setValue:self.totalpage forKey:kCityModelsTotalpage];
    [mutableDict setValue:self.totalcount forKey:kCityModelsTotalcount];

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

    self.cityModel = [aDecoder decodeObjectForKey:kCityModelsCityModel];
    self.totalpage = [aDecoder decodeObjectForKey:kCityModelsTotalpage];
    self.totalcount = [aDecoder decodeObjectForKey:kCityModelsTotalcount];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_cityModel forKey:kCityModelsCityModel];
    [aCoder encodeObject:_totalpage forKey:kCityModelsTotalpage];
    [aCoder encodeObject:_totalcount forKey:kCityModelsTotalcount];
}

- (id)copyWithZone:(NSZone *)zone
{
    CityModels *copy = [[CityModels alloc] init];
    
    if (copy) {

        copy.cityModel = [self.cityModel copyWithZone:zone];
        copy.totalpage = [self.totalpage copyWithZone:zone];
        copy.totalcount = [self.totalcount copyWithZone:zone];
    }
    
    return copy;
}


@end
