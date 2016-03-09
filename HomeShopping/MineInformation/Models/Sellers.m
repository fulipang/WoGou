//
//  Sellers.m
//
//  Created by sooncong  on 16/1/20
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "Sellers.h"


NSString *const kSellersIsneedbook = @"isneedbook";
NSString *const kSellersSellertag = @"sellertag";
NSString *const kSellersStarlevel = @"starlevel";
NSString *const kSellersSellername = @"sellername";
NSString *const kSellersCityname = @"cityname";
NSString *const kSellersPrice = @"price";
NSString *const kSellersAddress = @"address";
NSString *const kSellersSellerid = @"sellerid";
NSString *const kSellersCitycode = @"citycode";
NSString *const kSellersSellertitle = @"sellertitle";
NSString *const kSellersCoinreturn = @"coinreturn";
NSString *const kSellersSellerlogo = @"sellerlogo";
NSString *const kSellersDistance = @"distance";
NSString *const kSellersScore = @"score";
NSString *const kSellersCoinprice = @"coinprice";
NSString *const kSellersTurnover = @"turnover";


@interface Sellers ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation Sellers

@synthesize isneedbook = _isneedbook;
@synthesize sellertag = _sellertag;
@synthesize starlevel = _starlevel;
@synthesize sellername = _sellername;
@synthesize cityname = _cityname;
@synthesize price = _price;
@synthesize address = _address;
@synthesize sellerid = _sellerid;
@synthesize citycode = _citycode;
@synthesize sellertitle = _sellertitle;
@synthesize coinreturn = _coinreturn;
@synthesize sellerlogo = _sellerlogo;
@synthesize distance = _distance;
@synthesize score = _score;
@synthesize coinprice = _coinprice;
@synthesize turnover = _turnover;


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
            self.isneedbook = [self objectOrNilForKey:kSellersIsneedbook fromDictionary:dict];
            self.sellertag = [self objectOrNilForKey:kSellersSellertag fromDictionary:dict];
            self.starlevel = [self objectOrNilForKey:kSellersStarlevel fromDictionary:dict];
            self.sellername = [self objectOrNilForKey:kSellersSellername fromDictionary:dict];
            self.cityname = [self objectOrNilForKey:kSellersCityname fromDictionary:dict];
            self.price = [self objectOrNilForKey:kSellersPrice fromDictionary:dict];
            self.address = [self objectOrNilForKey:kSellersAddress fromDictionary:dict];
            self.sellerid = [self objectOrNilForKey:kSellersSellerid fromDictionary:dict];
            self.citycode = [self objectOrNilForKey:kSellersCitycode fromDictionary:dict];
            self.sellertitle = [self objectOrNilForKey:kSellersSellertitle fromDictionary:dict];
            self.coinreturn = [self objectOrNilForKey:kSellersCoinreturn fromDictionary:dict];
            self.sellerlogo = [self objectOrNilForKey:kSellersSellerlogo fromDictionary:dict];
            self.distance = [self objectOrNilForKey:kSellersDistance fromDictionary:dict];
            self.score = [self objectOrNilForKey:kSellersScore fromDictionary:dict];
            self.coinprice = [self objectOrNilForKey:kSellersCoinprice fromDictionary:dict];
            self.turnover = [self objectOrNilForKey:kSellersTurnover fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.isneedbook forKey:kSellersIsneedbook];
    [mutableDict setValue:self.sellertag forKey:kSellersSellertag];
    [mutableDict setValue:self.starlevel forKey:kSellersStarlevel];
    [mutableDict setValue:self.sellername forKey:kSellersSellername];
    [mutableDict setValue:self.cityname forKey:kSellersCityname];
    [mutableDict setValue:self.price forKey:kSellersPrice];
    [mutableDict setValue:self.address forKey:kSellersAddress];
    [mutableDict setValue:self.sellerid forKey:kSellersSellerid];
    [mutableDict setValue:self.citycode forKey:kSellersCitycode];
    [mutableDict setValue:self.sellertitle forKey:kSellersSellertitle];
    [mutableDict setValue:self.coinreturn forKey:kSellersCoinreturn];
    [mutableDict setValue:self.sellerlogo forKey:kSellersSellerlogo];
    [mutableDict setValue:self.distance forKey:kSellersDistance];
    [mutableDict setValue:self.score forKey:kSellersScore];
    [mutableDict setValue:self.coinprice forKey:kSellersCoinprice];
    [mutableDict setValue:self.turnover forKey:kSellersTurnover];

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

    self.isneedbook = [aDecoder decodeObjectForKey:kSellersIsneedbook];
    self.sellertag = [aDecoder decodeObjectForKey:kSellersSellertag];
    self.starlevel = [aDecoder decodeObjectForKey:kSellersStarlevel];
    self.sellername = [aDecoder decodeObjectForKey:kSellersSellername];
    self.cityname = [aDecoder decodeObjectForKey:kSellersCityname];
    self.price = [aDecoder decodeObjectForKey:kSellersPrice];
    self.address = [aDecoder decodeObjectForKey:kSellersAddress];
    self.sellerid = [aDecoder decodeObjectForKey:kSellersSellerid];
    self.citycode = [aDecoder decodeObjectForKey:kSellersCitycode];
    self.sellertitle = [aDecoder decodeObjectForKey:kSellersSellertitle];
    self.coinreturn = [aDecoder decodeObjectForKey:kSellersCoinreturn];
    self.sellerlogo = [aDecoder decodeObjectForKey:kSellersSellerlogo];
    self.distance = [aDecoder decodeObjectForKey:kSellersDistance];
    self.score = [aDecoder decodeObjectForKey:kSellersScore];
    self.coinprice = [aDecoder decodeObjectForKey:kSellersCoinprice];
    self.turnover = [aDecoder decodeObjectForKey:kSellersTurnover];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_isneedbook forKey:kSellersIsneedbook];
    [aCoder encodeObject:_sellertag forKey:kSellersSellertag];
    [aCoder encodeObject:_starlevel forKey:kSellersStarlevel];
    [aCoder encodeObject:_sellername forKey:kSellersSellername];
    [aCoder encodeObject:_cityname forKey:kSellersCityname];
    [aCoder encodeObject:_price forKey:kSellersPrice];
    [aCoder encodeObject:_address forKey:kSellersAddress];
    [aCoder encodeObject:_sellerid forKey:kSellersSellerid];
    [aCoder encodeObject:_citycode forKey:kSellersCitycode];
    [aCoder encodeObject:_sellertitle forKey:kSellersSellertitle];
    [aCoder encodeObject:_coinreturn forKey:kSellersCoinreturn];
    [aCoder encodeObject:_sellerlogo forKey:kSellersSellerlogo];
    [aCoder encodeObject:_distance forKey:kSellersDistance];
    [aCoder encodeObject:_score forKey:kSellersScore];
    [aCoder encodeObject:_coinprice forKey:kSellersCoinprice];
    [aCoder encodeObject:_turnover forKey:kSellersTurnover];
}

- (id)copyWithZone:(NSZone *)zone
{
    Sellers *copy = [[Sellers alloc] init];
    
    if (copy) {

        copy.isneedbook = [self.isneedbook copyWithZone:zone];
        copy.sellertag = [self.sellertag copyWithZone:zone];
        copy.starlevel = [self.starlevel copyWithZone:zone];
        copy.sellername = [self.sellername copyWithZone:zone];
        copy.cityname = [self.cityname copyWithZone:zone];
        copy.price = [self.price copyWithZone:zone];
        copy.address = [self.address copyWithZone:zone];
        copy.sellerid = [self.sellerid copyWithZone:zone];
        copy.citycode = [self.citycode copyWithZone:zone];
        copy.sellertitle = [self.sellertitle copyWithZone:zone];
        copy.coinreturn = [self.coinreturn copyWithZone:zone];
        copy.sellerlogo = [self.sellerlogo copyWithZone:zone];
        copy.distance = [self.distance copyWithZone:zone];
        copy.score = [self.score copyWithZone:zone];
        copy.coinprice = [self.coinprice copyWithZone:zone];
        copy.turnover = [self.turnover copyWithZone:zone];
    }
    
    return copy;
}


@end
