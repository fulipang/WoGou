//
//  CityModelsParser.m
//
//  Created by sooncong  on 16/1/15
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "CityModelsParser.h"

NSString *const kCityModelsParserCityModels = @"body";


@interface CityModelsParser ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation CityModelsParser

@synthesize cityModels = _cityModels;


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
            self.cityModels = [CityModels modelObjectWithDictionary:[dict objectForKey:kCityModelsParserCityModels]];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[self.cityModels dictionaryRepresentation] forKey:kCityModelsParserCityModels];

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

    self.cityModels = [aDecoder decodeObjectForKey:kCityModelsParserCityModels];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_cityModels forKey:kCityModelsParserCityModels];
}

- (id)copyWithZone:(NSZone *)zone
{
    CityModelsParser *copy = [[CityModelsParser alloc] init];
    
    if (copy) {

        copy.cityModels = [self.cityModels copyWithZone:zone];
    }
    
    return copy;
}


@end
