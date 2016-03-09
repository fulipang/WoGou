//
//  Hotellikes.m
//
//  Created by sooncong  on 16/1/20
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "Hotellikes.h"


NSString *const kHotellikesIsspecial = @"isspecial";
NSString *const kHotellikesCityname = @"cityname";
NSString *const kHotellikesCoordinatex = @"coordinatex";
NSString *const kHotellikesServicephone = @"servicephone";
NSString *const kHotellikesCoordinatey = @"coordinatey";
NSString *const kHotellikesStarlevel = @"starlevel";
NSString *const kHotellikesSellername = @"sellername";
NSString *const kHotellikesSellerid = @"sellerid";
NSString *const kHotellikesPrice = @"price";
NSString *const kHotellikesTitle = @"title";
NSString *const kHotellikesLogo = @"logo";
NSString *const kHotellikesCitycode = @"citycode";
NSString *const kHotellikesAddress = @"address";
NSString *const kHotellikesCoinreturn = @"coinreturn";
NSString *const kHotellikesCoinprice = @"coinprice";
NSString *const kHotellikesDistance = @"distance";
NSString *const kHotellikesScore = @"score";
NSString *const kHotellikesTurnover = @"turnover";
NSString *const kHotellikesIsneedbook = @"isneedbook";


@interface Hotellikes ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation Hotellikes

@synthesize isspecial = _isspecial;
@synthesize cityname = _cityname;
@synthesize coordinatex = _coordinatex;
@synthesize servicephone = _servicephone;
@synthesize coordinatey = _coordinatey;
@synthesize starlevel = _starlevel;
@synthesize sellername = _sellername;
@synthesize sellerid = _sellerid;
@synthesize price = _price;
@synthesize title = _title;
@synthesize logo = _logo;
@synthesize citycode = _citycode;
@synthesize address = _address;
@synthesize coinreturn = _coinreturn;
@synthesize coinprice = _coinprice;
@synthesize distance = _distance;
@synthesize score = _score;
@synthesize turnover = _turnover;
@synthesize isneedbook = _isneedbook;


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
            self.isspecial = [self objectOrNilForKey:kHotellikesIsspecial fromDictionary:dict];
            self.cityname = [self objectOrNilForKey:kHotellikesCityname fromDictionary:dict];
            self.coordinatex = [self objectOrNilForKey:kHotellikesCoordinatex fromDictionary:dict];
            self.servicephone = [self objectOrNilForKey:kHotellikesServicephone fromDictionary:dict];
            self.coordinatey = [self objectOrNilForKey:kHotellikesCoordinatey fromDictionary:dict];
            self.starlevel = [self objectOrNilForKey:kHotellikesStarlevel fromDictionary:dict];
            self.sellername = [self objectOrNilForKey:kHotellikesSellername fromDictionary:dict];
            self.sellerid = [self objectOrNilForKey:kHotellikesSellerid fromDictionary:dict];
            self.price = [self objectOrNilForKey:kHotellikesPrice fromDictionary:dict];
            self.title = [self objectOrNilForKey:kHotellikesTitle fromDictionary:dict];
            self.logo = [self objectOrNilForKey:kHotellikesLogo fromDictionary:dict];
            self.citycode = [self objectOrNilForKey:kHotellikesCitycode fromDictionary:dict];
            self.address = [self objectOrNilForKey:kHotellikesAddress fromDictionary:dict];
            self.coinreturn = [self objectOrNilForKey:kHotellikesCoinreturn fromDictionary:dict];
            self.coinprice = [self objectOrNilForKey:kHotellikesCoinprice fromDictionary:dict];
            self.distance = [self objectOrNilForKey:kHotellikesDistance fromDictionary:dict];
            self.score = [self objectOrNilForKey:kHotellikesScore fromDictionary:dict];
            self.turnover = [self objectOrNilForKey:kHotellikesTurnover fromDictionary:dict];
            self.isneedbook = [self objectOrNilForKey:kHotellikesIsneedbook fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.isspecial forKey:kHotellikesIsspecial];
    [mutableDict setValue:self.cityname forKey:kHotellikesCityname];
    [mutableDict setValue:self.coordinatex forKey:kHotellikesCoordinatex];
    [mutableDict setValue:self.servicephone forKey:kHotellikesServicephone];
    [mutableDict setValue:self.coordinatey forKey:kHotellikesCoordinatey];
    [mutableDict setValue:self.starlevel forKey:kHotellikesStarlevel];
    [mutableDict setValue:self.sellername forKey:kHotellikesSellername];
    [mutableDict setValue:self.sellerid forKey:kHotellikesSellerid];
    [mutableDict setValue:self.price forKey:kHotellikesPrice];
    [mutableDict setValue:self.title forKey:kHotellikesTitle];
    [mutableDict setValue:self.logo forKey:kHotellikesLogo];
    [mutableDict setValue:self.citycode forKey:kHotellikesCitycode];
    [mutableDict setValue:self.address forKey:kHotellikesAddress];
    [mutableDict setValue:self.coinreturn forKey:kHotellikesCoinreturn];
    [mutableDict setValue:self.coinprice forKey:kHotellikesCoinprice];
    [mutableDict setValue:self.distance forKey:kHotellikesDistance];
    [mutableDict setValue:self.score forKey:kHotellikesScore];
    [mutableDict setValue:self.turnover forKey:kHotellikesTurnover];
    [mutableDict setValue:self.isneedbook forKey:kHotellikesIsneedbook];

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

    self.isspecial = [aDecoder decodeObjectForKey:kHotellikesIsspecial];
    self.cityname = [aDecoder decodeObjectForKey:kHotellikesCityname];
    self.coordinatex = [aDecoder decodeObjectForKey:kHotellikesCoordinatex];
    self.servicephone = [aDecoder decodeObjectForKey:kHotellikesServicephone];
    self.coordinatey = [aDecoder decodeObjectForKey:kHotellikesCoordinatey];
    self.starlevel = [aDecoder decodeObjectForKey:kHotellikesStarlevel];
    self.sellername = [aDecoder decodeObjectForKey:kHotellikesSellername];
    self.sellerid = [aDecoder decodeObjectForKey:kHotellikesSellerid];
    self.price = [aDecoder decodeObjectForKey:kHotellikesPrice];
    self.title = [aDecoder decodeObjectForKey:kHotellikesTitle];
    self.logo = [aDecoder decodeObjectForKey:kHotellikesLogo];
    self.citycode = [aDecoder decodeObjectForKey:kHotellikesCitycode];
    self.address = [aDecoder decodeObjectForKey:kHotellikesAddress];
    self.coinreturn = [aDecoder decodeObjectForKey:kHotellikesCoinreturn];
    self.coinprice = [aDecoder decodeObjectForKey:kHotellikesCoinprice];
    self.distance = [aDecoder decodeObjectForKey:kHotellikesDistance];
    self.score = [aDecoder decodeObjectForKey:kHotellikesScore];
    self.turnover = [aDecoder decodeObjectForKey:kHotellikesTurnover];
    self.isneedbook = [aDecoder decodeObjectForKey:kHotellikesIsneedbook];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_isspecial forKey:kHotellikesIsspecial];
    [aCoder encodeObject:_cityname forKey:kHotellikesCityname];
    [aCoder encodeObject:_coordinatex forKey:kHotellikesCoordinatex];
    [aCoder encodeObject:_servicephone forKey:kHotellikesServicephone];
    [aCoder encodeObject:_coordinatey forKey:kHotellikesCoordinatey];
    [aCoder encodeObject:_starlevel forKey:kHotellikesStarlevel];
    [aCoder encodeObject:_sellername forKey:kHotellikesSellername];
    [aCoder encodeObject:_sellerid forKey:kHotellikesSellerid];
    [aCoder encodeObject:_price forKey:kHotellikesPrice];
    [aCoder encodeObject:_title forKey:kHotellikesTitle];
    [aCoder encodeObject:_logo forKey:kHotellikesLogo];
    [aCoder encodeObject:_citycode forKey:kHotellikesCitycode];
    [aCoder encodeObject:_address forKey:kHotellikesAddress];
    [aCoder encodeObject:_coinreturn forKey:kHotellikesCoinreturn];
    [aCoder encodeObject:_coinprice forKey:kHotellikesCoinprice];
    [aCoder encodeObject:_distance forKey:kHotellikesDistance];
    [aCoder encodeObject:_score forKey:kHotellikesScore];
    [aCoder encodeObject:_turnover forKey:kHotellikesTurnover];
    [aCoder encodeObject:_isneedbook forKey:kHotellikesIsneedbook];
}

- (id)copyWithZone:(NSZone *)zone
{
    Hotellikes *copy = [[Hotellikes alloc] init];
    
    if (copy) {

        copy.isspecial = [self.isspecial copyWithZone:zone];
        copy.cityname = [self.cityname copyWithZone:zone];
        copy.coordinatex = [self.coordinatex copyWithZone:zone];
        copy.servicephone = [self.servicephone copyWithZone:zone];
        copy.coordinatey = [self.coordinatey copyWithZone:zone];
        copy.starlevel = [self.starlevel copyWithZone:zone];
        copy.sellername = [self.sellername copyWithZone:zone];
        copy.sellerid = [self.sellerid copyWithZone:zone];
        copy.price = [self.price copyWithZone:zone];
        copy.title = [self.title copyWithZone:zone];
        copy.logo = [self.logo copyWithZone:zone];
        copy.citycode = [self.citycode copyWithZone:zone];
        copy.address = [self.address copyWithZone:zone];
        copy.coinreturn = [self.coinreturn copyWithZone:zone];
        copy.coinprice = [self.coinprice copyWithZone:zone];
        copy.distance = [self.distance copyWithZone:zone];
        copy.score = [self.score copyWithZone:zone];
        copy.turnover = [self.turnover copyWithZone:zone];
        copy.isneedbook = [self.isneedbook copyWithZone:zone];
    }
    
    return copy;
}


@end
