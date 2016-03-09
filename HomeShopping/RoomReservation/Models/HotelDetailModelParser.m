//
//  HotelDetailModelParser.m
//
//  Created by sooncong  on 16/1/20
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "HotelDetailModelParser.h"


NSString *const kHotelDetailModelParserHotelDetailModel = @"body";


@interface HotelDetailModelParser ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation HotelDetailModelParser

@synthesize hotelDetailModel = _hotelDetailModel;


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
            self.hotelDetailModel = [HotelDetailModel modelObjectWithDictionary:[dict objectForKey:kHotelDetailModelParserHotelDetailModel]];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[self.hotelDetailModel dictionaryRepresentation] forKey:kHotelDetailModelParserHotelDetailModel];

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

    self.hotelDetailModel = [aDecoder decodeObjectForKey:kHotelDetailModelParserHotelDetailModel];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_hotelDetailModel forKey:kHotelDetailModelParserHotelDetailModel];
}

- (id)copyWithZone:(NSZone *)zone
{
    HotelDetailModelParser *copy = [[HotelDetailModelParser alloc] init];
    
    if (copy) {

        copy.hotelDetailModel = [self.hotelDetailModel copyWithZone:zone];
    }
    
    return copy;
}


@end
