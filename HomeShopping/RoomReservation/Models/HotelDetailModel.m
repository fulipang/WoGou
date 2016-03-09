//
//  HotelDetailModel.m
//
//  Created by sooncong  on 16/1/20
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "HotelDetailModel.h"


NSString *const kHotelDetailModelCityname = @"cityname";
NSString *const kHotelDetailModelCoinprice = @"coinprice";
NSString *const kHotelDetailModelTitle = @"title";
NSString *const kHotelDetailModelStarlevel = @"starlevel";
NSString *const kHotelDetailModelIshotel = @"ishotel";
NSString *const kHotelDetailModelScore = @"score";
NSString *const kHotelDetailModelSellername = @"sellername";
NSString *const kHotelDetailModelSellerintro = @"sellerintro";
NSString *const kHotelDetailModelSellerlogo = @"sellerlogo";
NSString *const kHotelDetailModelSellerscore = @"sellerscore";
NSString *const kHotelDetailModelIsneedbook = @"isneedbook";
NSString *const kHotelDetailModelTurnover = @"turnover";
NSString *const kHotelDetailModelDistance = @"distance";
NSString *const kHotelDetailModelCoordinatey = @"coordinatey";
NSString *const kHotelDetailModelCoordinatex = @"coordinatex";
NSString *const kHotelDetailModelSellerid = @"sellerid";
NSString *const kHotelDetailModelLogo = @"logo";
NSString *const kHotelDetailModelPrice = @"price";
NSString *const kHotelDetailModelCitycode = @"citycode";
NSString *const kHotelDetailModelAddress = @"address";
NSString *const kHotelDetailModelCoinreturn = @"coinreturn";
NSString *const kHotelDetailModelServicephone = @"servicephone";


@interface HotelDetailModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation HotelDetailModel

@synthesize cityname = _cityname;
@synthesize coinprice = _coinprice;
@synthesize title = _title;
@synthesize starlevel = _starlevel;
@synthesize ishotel = _ishotel;
@synthesize score = _score;
@synthesize sellername = _sellername;
@synthesize sellerintro = _sellerintro;
@synthesize sellerlogo = _sellerlogo;
@synthesize sellerscore = _sellerscore;
@synthesize isneedbook = _isneedbook;
@synthesize turnover = _turnover;
@synthesize distance = _distance;
@synthesize coordinatey = _coordinatey;
@synthesize coordinatex = _coordinatex;
@synthesize sellerid = _sellerid;
@synthesize logo = _logo;
@synthesize price = _price;
@synthesize citycode = _citycode;
@synthesize address = _address;
@synthesize coinreturn = _coinreturn;
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
            self.cityname = [self objectOrNilForKey:kHotelDetailModelCityname fromDictionary:dict];
            self.coinprice = [self objectOrNilForKey:kHotelDetailModelCoinprice fromDictionary:dict];
            self.title = [self objectOrNilForKey:kHotelDetailModelTitle fromDictionary:dict];
            self.starlevel = [self objectOrNilForKey:kHotelDetailModelStarlevel fromDictionary:dict];
            self.ishotel = [self objectOrNilForKey:kHotelDetailModelIshotel fromDictionary:dict];
            self.score = [self objectOrNilForKey:kHotelDetailModelScore fromDictionary:dict];
            self.sellername = [self objectOrNilForKey:kHotelDetailModelSellername fromDictionary:dict];
            self.sellerintro = [self objectOrNilForKey:kHotelDetailModelSellerintro fromDictionary:dict];
            self.sellerlogo = [self objectOrNilForKey:kHotelDetailModelSellerlogo fromDictionary:dict];
            self.sellerscore = [self objectOrNilForKey:kHotelDetailModelSellerscore fromDictionary:dict];
            self.isneedbook = [self objectOrNilForKey:kHotelDetailModelIsneedbook fromDictionary:dict];
            self.turnover = [self objectOrNilForKey:kHotelDetailModelTurnover fromDictionary:dict];
            self.distance = [self objectOrNilForKey:kHotelDetailModelDistance fromDictionary:dict];
            self.coordinatey = [self objectOrNilForKey:kHotelDetailModelCoordinatey fromDictionary:dict];
            self.coordinatex = [self objectOrNilForKey:kHotelDetailModelCoordinatex fromDictionary:dict];
            self.sellerid = [self objectOrNilForKey:kHotelDetailModelSellerid fromDictionary:dict];
            self.logo = [self objectOrNilForKey:kHotelDetailModelLogo fromDictionary:dict];
            self.price = [self objectOrNilForKey:kHotelDetailModelPrice fromDictionary:dict];
            self.citycode = [self objectOrNilForKey:kHotelDetailModelCitycode fromDictionary:dict];
            self.address = [self objectOrNilForKey:kHotelDetailModelAddress fromDictionary:dict];
            self.coinreturn = [self objectOrNilForKey:kHotelDetailModelCoinreturn fromDictionary:dict];
            self.servicephone = [self objectOrNilForKey:kHotelDetailModelServicephone fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.cityname forKey:kHotelDetailModelCityname];
    [mutableDict setValue:self.coinprice forKey:kHotelDetailModelCoinprice];
    [mutableDict setValue:self.title forKey:kHotelDetailModelTitle];
    [mutableDict setValue:self.starlevel forKey:kHotelDetailModelStarlevel];
    [mutableDict setValue:self.ishotel forKey:kHotelDetailModelIshotel];
    [mutableDict setValue:self.score forKey:kHotelDetailModelScore];
    [mutableDict setValue:self.sellername forKey:kHotelDetailModelSellername];
    [mutableDict setValue:self.sellerintro forKey:kHotelDetailModelSellerintro];
    [mutableDict setValue:self.sellerlogo forKey:kHotelDetailModelSellerlogo];
    [mutableDict setValue:self.sellerscore forKey:kHotelDetailModelSellerscore];
    [mutableDict setValue:self.isneedbook forKey:kHotelDetailModelIsneedbook];
    [mutableDict setValue:self.turnover forKey:kHotelDetailModelTurnover];
    [mutableDict setValue:self.distance forKey:kHotelDetailModelDistance];
    [mutableDict setValue:self.coordinatey forKey:kHotelDetailModelCoordinatey];
    [mutableDict setValue:self.coordinatex forKey:kHotelDetailModelCoordinatex];
    [mutableDict setValue:self.sellerid forKey:kHotelDetailModelSellerid];
    [mutableDict setValue:self.logo forKey:kHotelDetailModelLogo];
    [mutableDict setValue:self.price forKey:kHotelDetailModelPrice];
    [mutableDict setValue:self.citycode forKey:kHotelDetailModelCitycode];
    [mutableDict setValue:self.address forKey:kHotelDetailModelAddress];
    [mutableDict setValue:self.coinreturn forKey:kHotelDetailModelCoinreturn];
    [mutableDict setValue:self.servicephone forKey:kHotelDetailModelServicephone];


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

    self.cityname = [aDecoder decodeObjectForKey:kHotelDetailModelCityname];
    self.coinprice = [aDecoder decodeObjectForKey:kHotelDetailModelCoinprice];
    self.title = [aDecoder decodeObjectForKey:kHotelDetailModelTitle];
    self.starlevel = [aDecoder decodeObjectForKey:kHotelDetailModelStarlevel];
    self.ishotel = [aDecoder decodeObjectForKey:kHotelDetailModelIshotel];
    self.score = [aDecoder decodeObjectForKey:kHotelDetailModelScore];
    self.sellername = [aDecoder decodeObjectForKey:kHotelDetailModelSellername];
    self.sellerintro = [aDecoder decodeObjectForKey:kHotelDetailModelSellerintro];
    self.sellerlogo = [aDecoder decodeObjectForKey:kHotelDetailModelSellerlogo];
    self.sellerscore = [aDecoder decodeObjectForKey:kHotelDetailModelSellerscore];
    self.isneedbook = [aDecoder decodeObjectForKey:kHotelDetailModelIsneedbook];
    self.turnover = [aDecoder decodeObjectForKey:kHotelDetailModelTurnover];
    self.distance = [aDecoder decodeObjectForKey:kHotelDetailModelDistance];
    self.coordinatey = [aDecoder decodeObjectForKey:kHotelDetailModelCoordinatey];
    self.coordinatex = [aDecoder decodeObjectForKey:kHotelDetailModelCoordinatex];
    self.sellerid = [aDecoder decodeObjectForKey:kHotelDetailModelSellerid];
    self.logo = [aDecoder decodeObjectForKey:kHotelDetailModelLogo];
    self.price = [aDecoder decodeObjectForKey:kHotelDetailModelPrice];
    self.citycode = [aDecoder decodeObjectForKey:kHotelDetailModelCitycode];
    self.address = [aDecoder decodeObjectForKey:kHotelDetailModelAddress];
    self.coinreturn = [aDecoder decodeObjectForKey:kHotelDetailModelCoinreturn];
    self.servicephone = [aDecoder decodeObjectForKey:kHotelDetailModelServicephone];

    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_cityname forKey:kHotelDetailModelCityname];
    [aCoder encodeObject:_coinprice forKey:kHotelDetailModelCoinprice];
    [aCoder encodeObject:_title forKey:kHotelDetailModelTitle];
    [aCoder encodeObject:_starlevel forKey:kHotelDetailModelStarlevel];
    [aCoder encodeObject:_ishotel forKey:kHotelDetailModelIshotel];
    [aCoder encodeObject:_score forKey:kHotelDetailModelScore];
    [aCoder encodeObject:_sellername forKey:kHotelDetailModelSellername];
    [aCoder encodeObject:_sellerintro forKey:kHotelDetailModelSellerintro];
    [aCoder encodeObject:_sellerlogo forKey:kHotelDetailModelSellerlogo];
    [aCoder encodeObject:_sellerscore forKey:kHotelDetailModelSellerscore];
    [aCoder encodeObject:_isneedbook forKey:kHotelDetailModelIsneedbook];
    [aCoder encodeObject:_turnover forKey:kHotelDetailModelTurnover];
    [aCoder encodeObject:_distance forKey:kHotelDetailModelDistance];
    [aCoder encodeObject:_coordinatey forKey:kHotelDetailModelCoordinatey];
    [aCoder encodeObject:_coordinatex forKey:kHotelDetailModelCoordinatex];
    [aCoder encodeObject:_sellerid forKey:kHotelDetailModelSellerid];
    [aCoder encodeObject:_logo forKey:kHotelDetailModelLogo];
    [aCoder encodeObject:_price forKey:kHotelDetailModelPrice];
    [aCoder encodeObject:_citycode forKey:kHotelDetailModelCitycode];
    [aCoder encodeObject:_address forKey:kHotelDetailModelAddress];
    [aCoder encodeObject:_coinreturn forKey:kHotelDetailModelCoinreturn];
    [aCoder encodeObject:_servicephone forKey:kHotelDetailModelServicephone];

}

- (id)copyWithZone:(NSZone *)zone
{
    HotelDetailModel *copy = [[HotelDetailModel alloc] init];
    
    if (copy) {

        copy.cityname = [self.cityname copyWithZone:zone];
        copy.coinprice = [self.coinprice copyWithZone:zone];
        copy.title = [self.title copyWithZone:zone];
        copy.starlevel = [self.starlevel copyWithZone:zone];
        copy.ishotel = [self.ishotel copyWithZone:zone];
        copy.score = [self.score copyWithZone:zone];
        copy.sellername = [self.sellername copyWithZone:zone];
        copy.sellerintro = [self.sellerintro copyWithZone:zone];
        copy.sellerlogo = [self.sellerlogo copyWithZone:zone];
        copy.sellerscore = [self.sellerscore copyWithZone:zone];
        copy.isneedbook = [self.isneedbook copyWithZone:zone];
        copy.turnover = [self.turnover copyWithZone:zone];
        copy.distance = [self.distance copyWithZone:zone];
        copy.coordinatey = [self.coordinatey copyWithZone:zone];
        copy.coordinatex = [self.coordinatex copyWithZone:zone];
        copy.sellerid = [self.sellerid copyWithZone:zone];
        copy.logo = [self.logo copyWithZone:zone];
        copy.price = [self.price copyWithZone:zone];
        copy.citycode = [self.citycode copyWithZone:zone];
        copy.address = [self.address copyWithZone:zone];
        copy.coinreturn = [self.coinreturn copyWithZone:zone];
        copy.servicephone = [self.servicephone copyWithZone:zone];
    }
    
    return copy;
}


@end
