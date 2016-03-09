//
//  HotelModel.m
//
//  Created by sooncong  on 16/1/18
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "HotelModel.h"
#import "Hotels.h"
#import "HSAdsLists.h"


NSString *const kHotelModelTotalcount = @"totalcount";
NSString *const kHotelModelHotels = @"hotels";
NSString *const kHotelModelTopadvs = @"topadvs";
NSString *const kHotelModelTotalpage = @"totalpage";


@interface HotelModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation HotelModel

@synthesize totalcount = _totalcount;
@synthesize hotels = _hotels;
@synthesize topadvs = _topadvs;
@synthesize totalpage = _totalpage;


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
            self.totalcount = [self objectOrNilForKey:kHotelModelTotalcount fromDictionary:dict];
    NSObject *receivedHotels = [dict objectForKey:kHotelModelHotels];
    NSMutableArray *parsedHotels = [NSMutableArray array];
    if ([receivedHotels isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedHotels) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedHotels addObject:[Hotels modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedHotels isKindOfClass:[NSDictionary class]]) {
       [parsedHotels addObject:[Hotels modelObjectWithDictionary:(NSDictionary *)receivedHotels]];
    }

    self.hotels = [NSArray arrayWithArray:parsedHotels];
    NSObject *receivedTopadvs = [dict objectForKey:kHotelModelTopadvs];
    NSMutableArray *parsedTopadvs = [NSMutableArray array];
    if ([receivedTopadvs isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedTopadvs) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedTopadvs addObject:[HSAdsLists modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedTopadvs isKindOfClass:[NSDictionary class]]) {
       [parsedTopadvs addObject:[HSAdsLists modelObjectWithDictionary:(NSDictionary *)receivedTopadvs]];
    }

    self.topadvs = [NSArray arrayWithArray:parsedTopadvs];
            self.totalpage = [self objectOrNilForKey:kHotelModelTotalpage fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.totalcount forKey:kHotelModelTotalcount];
    NSMutableArray *tempArrayForHotels = [NSMutableArray array];
    for (NSObject *subArrayObject in self.hotels) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForHotels addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForHotels addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForHotels] forKey:kHotelModelHotels];
    NSMutableArray *tempArrayForTopadvs = [NSMutableArray array];
    for (NSObject *subArrayObject in self.topadvs) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForTopadvs addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForTopadvs addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForTopadvs] forKey:kHotelModelTopadvs];
    [mutableDict setValue:self.totalpage forKey:kHotelModelTotalpage];

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

    self.totalcount = [aDecoder decodeObjectForKey:kHotelModelTotalcount];
    self.hotels = [aDecoder decodeObjectForKey:kHotelModelHotels];
    self.topadvs = [aDecoder decodeObjectForKey:kHotelModelTopadvs];
    self.totalpage = [aDecoder decodeObjectForKey:kHotelModelTotalpage];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_totalcount forKey:kHotelModelTotalcount];
    [aCoder encodeObject:_hotels forKey:kHotelModelHotels];
    [aCoder encodeObject:_topadvs forKey:kHotelModelTopadvs];
    [aCoder encodeObject:_totalpage forKey:kHotelModelTotalpage];
}

- (id)copyWithZone:(NSZone *)zone
{
    HotelModel *copy = [[HotelModel alloc] init];
    
    if (copy) {

        copy.totalcount = [self.totalcount copyWithZone:zone];
        copy.hotels = [self.hotels copyWithZone:zone];
        copy.topadvs = [self.topadvs copyWithZone:zone];
        copy.totalpage = [self.totalpage copyWithZone:zone];
    }
    
    return copy;
}


@end
