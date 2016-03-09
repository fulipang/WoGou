//
//  HotelModelParser.m
//
//  Created by sooncong  on 16/1/18
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "HotelModelParser.h"


NSString *const kHotelModelParserHotelModel = @"body";


@interface HotelModelParser ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation HotelModelParser

@synthesize hotelModel = _hotelModel;


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
            self.hotelModel = [HotelModel modelObjectWithDictionary:[dict objectForKey:kHotelModelParserHotelModel]];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[self.hotelModel dictionaryRepresentation] forKey:kHotelModelParserHotelModel];

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

    self.hotelModel = [aDecoder decodeObjectForKey:kHotelModelParserHotelModel];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_hotelModel forKey:kHotelModelParserHotelModel];
}

- (id)copyWithZone:(NSZone *)zone
{
    HotelModelParser *copy = [[HotelModelParser alloc] init];
    
    if (copy) {

        copy.hotelModel = [self.hotelModel copyWithZone:zone];
    }
    
    return copy;
}


@end
