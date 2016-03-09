//
//  Hotels.m
//
//  Created by sooncong  on 16/1/20
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "Hotels.h"


NSString *const kHotelsScore = @"score";
NSString *const kHotelsTurnover = @"turnover";
NSString *const kHotelsCoordinatex = @"coordinatex";
NSString *const kHotelsIsneedbook = @"isneedbook";
NSString *const kHotelsCoordinatey = @"coordinatey";
NSString *const kHotelsStarlevel = @"starlevel";
NSString *const kHotelsSellername = @"sellername";
NSString *const kHotelsTitle = @"title";
NSString *const kHotelsPrice = @"price";
NSString *const kHotelsSellerid = @"sellerid";
NSString *const kHotelsLogo = @"logo";
NSString *const kHotelsCitycode = @"citycode";
NSString *const kHotelsAddress = @"address";
NSString *const kHotelsCoinreturn = @"coinreturn";
NSString *const kHotelsCoinprice = @"coinprice";
NSString *const kHotelsDistance = @"distance";
NSString *const kHotelsIsspecial = @"isspecial";
NSString *const kHotelsCityname = @"cityname";
NSString *const kHotelsServicephone = @"servicephone";


@interface Hotels ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation Hotels

@synthesize score = _score;
@synthesize turnover = _turnover;
@synthesize coordinatex = _coordinatex;
@synthesize isneedbook = _isneedbook;
@synthesize coordinatey = _coordinatey;
@synthesize starlevel = _starlevel;
@synthesize sellername = _sellername;
@synthesize title = _title;
@synthesize price = _price;
@synthesize sellerid = _sellerid;
@synthesize logo = _logo;
@synthesize citycode = _citycode;
@synthesize address = _address;
@synthesize coinreturn = _coinreturn;
@synthesize coinprice = _coinprice;
@synthesize distance = _distance;
@synthesize isspecial = _isspecial;
@synthesize cityname = _cityname;
@synthesize servicephone = _servicephone;


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
        self.score = [self objectOrNilForKey:kHotelsScore fromDictionary:dict];
        self.turnover = [self objectOrNilForKey:kHotelsTurnover fromDictionary:dict];
        self.coordinatex = [self objectOrNilForKey:kHotelsCoordinatex fromDictionary:dict];
        self.isneedbook = [self objectOrNilForKey:kHotelsIsneedbook fromDictionary:dict];
        self.coordinatey = [self objectOrNilForKey:kHotelsCoordinatey fromDictionary:dict];
        self.starlevel = [self objectOrNilForKey:kHotelsStarlevel fromDictionary:dict];
        self.sellername = [self objectOrNilForKey:kHotelsSellername fromDictionary:dict];
        self.title = [self objectOrNilForKey:kHotelsTitle fromDictionary:dict];
        self.price = [self objectOrNilForKey:kHotelsPrice fromDictionary:dict];
        self.sellerid = [self objectOrNilForKey:kHotelsSellerid fromDictionary:dict];
        self.logo = [self objectOrNilForKey:kHotelsLogo fromDictionary:dict];
        self.citycode = [self objectOrNilForKey:kHotelsCitycode fromDictionary:dict];
        self.address = [self objectOrNilForKey:kHotelsAddress fromDictionary:dict];
        self.coinreturn = [self objectOrNilForKey:kHotelsCoinreturn fromDictionary:dict];
        self.coinprice = [self objectOrNilForKey:kHotelsCoinprice fromDictionary:dict];
        self.distance = [self objectOrNilForKey:kHotelsDistance fromDictionary:dict];
        self.isspecial = [self objectOrNilForKey:kHotelsIsspecial fromDictionary:dict];
        self.cityname = [self objectOrNilForKey:kHotelsCityname fromDictionary:dict];
        self.servicephone = [self objectOrNilForKey:kHotelsServicephone fromDictionary:dict];
        
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.score forKey:kHotelsScore];
    [mutableDict setValue:self.turnover forKey:kHotelsTurnover];
    [mutableDict setValue:self.coordinatex forKey:kHotelsCoordinatex];
    [mutableDict setValue:self.isneedbook forKey:kHotelsIsneedbook];
    [mutableDict setValue:self.coordinatey forKey:kHotelsCoordinatey];
    [mutableDict setValue:self.starlevel forKey:kHotelsStarlevel];
    [mutableDict setValue:self.sellername forKey:kHotelsSellername];
    [mutableDict setValue:self.title forKey:kHotelsTitle];
    [mutableDict setValue:self.price forKey:kHotelsPrice];
    [mutableDict setValue:self.sellerid forKey:kHotelsSellerid];
    [mutableDict setValue:self.logo forKey:kHotelsLogo];
    [mutableDict setValue:self.citycode forKey:kHotelsCitycode];
    [mutableDict setValue:self.address forKey:kHotelsAddress];
    [mutableDict setValue:self.coinreturn forKey:kHotelsCoinreturn];
    [mutableDict setValue:self.coinprice forKey:kHotelsCoinprice];
    [mutableDict setValue:self.distance forKey:kHotelsDistance];
    [mutableDict setValue:self.isspecial forKey:kHotelsIsspecial];
    [mutableDict setValue:self.cityname forKey:kHotelsCityname];
    [mutableDict setValue:self.servicephone forKey:kHotelsServicephone];
    
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
    
    self.score = [aDecoder decodeObjectForKey:kHotelsScore];
    self.turnover = [aDecoder decodeObjectForKey:kHotelsTurnover];
    self.coordinatex = [aDecoder decodeObjectForKey:kHotelsCoordinatex];
    self.isneedbook = [aDecoder decodeObjectForKey:kHotelsIsneedbook];
    self.coordinatey = [aDecoder decodeObjectForKey:kHotelsCoordinatey];
    self.starlevel = [aDecoder decodeObjectForKey:kHotelsStarlevel];
    self.sellername = [aDecoder decodeObjectForKey:kHotelsSellername];
    self.title = [aDecoder decodeObjectForKey:kHotelsTitle];
    self.price = [aDecoder decodeObjectForKey:kHotelsPrice];
    self.sellerid = [aDecoder decodeObjectForKey:kHotelsSellerid];
    self.logo = [aDecoder decodeObjectForKey:kHotelsLogo];
    self.citycode = [aDecoder decodeObjectForKey:kHotelsCitycode];
    self.address = [aDecoder decodeObjectForKey:kHotelsAddress];
    self.coinreturn = [aDecoder decodeObjectForKey:kHotelsCoinreturn];
    self.coinprice = [aDecoder decodeObjectForKey:kHotelsCoinprice];
    self.distance = [aDecoder decodeObjectForKey:kHotelsDistance];
    self.isspecial = [aDecoder decodeObjectForKey:kHotelsIsspecial];
    self.cityname = [aDecoder decodeObjectForKey:kHotelsCityname];
    self.servicephone = [aDecoder decodeObjectForKey:kHotelsServicephone];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
    [aCoder encodeObject:_score forKey:kHotelsScore];
    [aCoder encodeObject:_turnover forKey:kHotelsTurnover];
    [aCoder encodeObject:_coordinatex forKey:kHotelsCoordinatex];
    [aCoder encodeObject:_isneedbook forKey:kHotelsIsneedbook];
    [aCoder encodeObject:_coordinatey forKey:kHotelsCoordinatey];
    [aCoder encodeObject:_starlevel forKey:kHotelsStarlevel];
    [aCoder encodeObject:_sellername forKey:kHotelsSellername];
    [aCoder encodeObject:_title forKey:kHotelsTitle];
    [aCoder encodeObject:_price forKey:kHotelsPrice];
    [aCoder encodeObject:_sellerid forKey:kHotelsSellerid];
    [aCoder encodeObject:_logo forKey:kHotelsLogo];
    [aCoder encodeObject:_citycode forKey:kHotelsCitycode];
    [aCoder encodeObject:_address forKey:kHotelsAddress];
    [aCoder encodeObject:_coinreturn forKey:kHotelsCoinreturn];
    [aCoder encodeObject:_coinprice forKey:kHotelsCoinprice];
    [aCoder encodeObject:_distance forKey:kHotelsDistance];
    [aCoder encodeObject:_isspecial forKey:kHotelsIsspecial];
    [aCoder encodeObject:_cityname forKey:kHotelsCityname];
    [aCoder encodeObject:_servicephone forKey:kHotelsServicephone];
}

- (id)copyWithZone:(NSZone *)zone
{
    Hotels *copy = [[Hotels alloc] init];
    
    if (copy) {
        
        copy.score = [self.score copyWithZone:zone];
        copy.turnover = [self.turnover copyWithZone:zone];
        copy.coordinatex = [self.coordinatex copyWithZone:zone];
        copy.isneedbook = [self.isneedbook copyWithZone:zone];
        copy.coordinatey = [self.coordinatey copyWithZone:zone];
        copy.starlevel = [self.starlevel copyWithZone:zone];
        copy.sellername = [self.sellername copyWithZone:zone];
        copy.title = [self.title copyWithZone:zone];
        copy.price = [self.price copyWithZone:zone];
        copy.sellerid = [self.sellerid copyWithZone:zone];
        copy.logo = [self.logo copyWithZone:zone];
        copy.citycode = [self.citycode copyWithZone:zone];
        copy.address = [self.address copyWithZone:zone];
        copy.coinreturn = [self.coinreturn copyWithZone:zone];
        copy.coinprice = [self.coinprice copyWithZone:zone];
        copy.distance = [self.distance copyWithZone:zone];
        copy.isspecial = [self.isspecial copyWithZone:zone];
        copy.cityname = [self.cityname copyWithZone:zone];
        copy.servicephone = [self.servicephone copyWithZone:zone];
    }
    
    return copy;
}


@end
