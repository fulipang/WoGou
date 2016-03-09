//
//  CityModel.m
//
//  Created by sooncong  on 16/1/15
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "CityModel.h"


NSString *const kCityModelTitle = @"title";
NSString *const kCityModelLetter = @"letter";
NSString *const kCityModelCode = @"code";


@interface CityModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation CityModel

@synthesize title = _title;
@synthesize letter = _letter;
@synthesize code = _code;


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
            self.title = [self objectOrNilForKey:kCityModelTitle fromDictionary:dict];
            self.letter = [self objectOrNilForKey:kCityModelLetter fromDictionary:dict];
            self.code = [self objectOrNilForKey:kCityModelCode fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.title forKey:kCityModelTitle];
    [mutableDict setValue:self.letter forKey:kCityModelLetter];
    [mutableDict setValue:self.code forKey:kCityModelCode];

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

    self.title = [aDecoder decodeObjectForKey:kCityModelTitle];
    self.letter = [aDecoder decodeObjectForKey:kCityModelLetter];
    self.code = [aDecoder decodeObjectForKey:kCityModelCode];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_title forKey:kCityModelTitle];
    [aCoder encodeObject:_letter forKey:kCityModelLetter];
    [aCoder encodeObject:_code forKey:kCityModelCode];
}

- (id)copyWithZone:(NSZone *)zone
{
    CityModel *copy = [[CityModel alloc] init];
    
    if (copy) {

        copy.title = [self.title copyWithZone:zone];
        copy.letter = [self.letter copyWithZone:zone];
        copy.code = [self.code copyWithZone:zone];
    }
    
    return copy;
}


@end
