//
//  HSProduct.m
//
//  Created by sooncong  on 15/12/24
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "HSProduct.h"


NSString *const kHSProductTurnover = @"turnover";
NSString *const kHSProductProductid = @"productid";
NSString *const kHSProductSellername = @"sellername";
NSString *const kHSProductProducttype = @"producttype";
NSString *const kHSProductStarlevel = @"starlevel";
NSString *const kHSProductCityname = @"cityname";
NSString *const kHSProductTitle = @"title";
NSString *const kHSProductPrice = @"price";
NSString *const kHSProductAddress = @"address";
NSString *const kHSProductLogo = @"logo";
NSString *const kHSProductCitycode = @"citycode";
NSString *const kHSProductCoinreturn = @"coinreturn";
NSString *const kHSProductSellerid = @"sellerid";
NSString *const kHSProductIsspecial = @"isspecial";
NSString *const kHSProductDistance = @"distance";
NSString *const kHSProductIsneedbook = @"isneedbook";
NSString *const kHSProductCoinprice = @"coinprice";
NSString *const kHSProductScore = @"score";


@interface HSProduct ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation HSProduct

@synthesize turnover = _turnover;
@synthesize productid = _productid;
@synthesize sellername = _sellername;
@synthesize producttype = _producttype;
@synthesize starlevel = _starlevel;
@synthesize cityname = _cityname;
@synthesize title = _title;
@synthesize price = _price;
@synthesize address = _address;
@synthesize logo = _logo;
@synthesize citycode = _citycode;
@synthesize coinreturn = _coinreturn;
@synthesize sellerid = _sellerid;
@synthesize isspecial = _isspecial;
@synthesize distance = _distance;
@synthesize isneedbook = _isneedbook;
@synthesize coinprice = _coinprice;
@synthesize score = _score;


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
            self.turnover = [self objectOrNilForKey:kHSProductTurnover fromDictionary:dict];
            self.productid = [self objectOrNilForKey:kHSProductProductid fromDictionary:dict];
            self.sellername = [self objectOrNilForKey:kHSProductSellername fromDictionary:dict];
            self.producttype = [self objectOrNilForKey:kHSProductProducttype fromDictionary:dict];
            self.starlevel = [self objectOrNilForKey:kHSProductStarlevel fromDictionary:dict];
            self.cityname = [self objectOrNilForKey:kHSProductCityname fromDictionary:dict];
            self.title = [self objectOrNilForKey:kHSProductTitle fromDictionary:dict];
            self.price = [self objectOrNilForKey:kHSProductPrice fromDictionary:dict];
            self.address = [self objectOrNilForKey:kHSProductAddress fromDictionary:dict];
            self.logo = [self objectOrNilForKey:kHSProductLogo fromDictionary:dict];
            self.citycode = [self objectOrNilForKey:kHSProductCitycode fromDictionary:dict];
            self.coinreturn = [self objectOrNilForKey:kHSProductCoinreturn fromDictionary:dict];
            self.sellerid = [self objectOrNilForKey:kHSProductSellerid fromDictionary:dict];
            self.isspecial = [self objectOrNilForKey:kHSProductIsspecial fromDictionary:dict];
            self.distance = [self objectOrNilForKey:kHSProductDistance fromDictionary:dict];
            self.isneedbook = [self objectOrNilForKey:kHSProductIsneedbook fromDictionary:dict];
            self.coinprice = [self objectOrNilForKey:kHSProductCoinprice fromDictionary:dict];
            self.score = [self objectOrNilForKey:kHSProductScore fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.turnover forKey:kHSProductTurnover];
    [mutableDict setValue:self.productid forKey:kHSProductProductid];
    [mutableDict setValue:self.sellername forKey:kHSProductSellername];
    [mutableDict setValue:self.producttype forKey:kHSProductProducttype];
    [mutableDict setValue:self.starlevel forKey:kHSProductStarlevel];
    [mutableDict setValue:self.cityname forKey:kHSProductCityname];
    [mutableDict setValue:self.title forKey:kHSProductTitle];
    [mutableDict setValue:self.price forKey:kHSProductPrice];
    [mutableDict setValue:self.address forKey:kHSProductAddress];
    [mutableDict setValue:self.logo forKey:kHSProductLogo];
    [mutableDict setValue:self.citycode forKey:kHSProductCitycode];
    [mutableDict setValue:self.coinreturn forKey:kHSProductCoinreturn];
    [mutableDict setValue:self.sellerid forKey:kHSProductSellerid];
    [mutableDict setValue:self.isspecial forKey:kHSProductIsspecial];
    [mutableDict setValue:self.distance forKey:kHSProductDistance];
    [mutableDict setValue:self.isneedbook forKey:kHSProductIsneedbook];
    [mutableDict setValue:self.coinprice forKey:kHSProductCoinprice];
    [mutableDict setValue:self.score forKey:kHSProductScore];

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

    self.turnover = [aDecoder decodeObjectForKey:kHSProductTurnover];
    self.productid = [aDecoder decodeObjectForKey:kHSProductProductid];
    self.sellername = [aDecoder decodeObjectForKey:kHSProductSellername];
    self.producttype = [aDecoder decodeObjectForKey:kHSProductProducttype];
    self.starlevel = [aDecoder decodeObjectForKey:kHSProductStarlevel];
    self.cityname = [aDecoder decodeObjectForKey:kHSProductCityname];
    self.title = [aDecoder decodeObjectForKey:kHSProductTitle];
    self.price = [aDecoder decodeObjectForKey:kHSProductPrice];
    self.address = [aDecoder decodeObjectForKey:kHSProductAddress];
    self.logo = [aDecoder decodeObjectForKey:kHSProductLogo];
    self.citycode = [aDecoder decodeObjectForKey:kHSProductCitycode];
    self.coinreturn = [aDecoder decodeObjectForKey:kHSProductCoinreturn];
    self.sellerid = [aDecoder decodeObjectForKey:kHSProductSellerid];
    self.isspecial = [aDecoder decodeObjectForKey:kHSProductIsspecial];
    self.distance = [aDecoder decodeObjectForKey:kHSProductDistance];
    self.isneedbook = [aDecoder decodeObjectForKey:kHSProductIsneedbook];
    self.coinprice = [aDecoder decodeObjectForKey:kHSProductCoinprice];
    self.score = [aDecoder decodeObjectForKey:kHSProductScore];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_turnover forKey:kHSProductTurnover];
    [aCoder encodeObject:_productid forKey:kHSProductProductid];
    [aCoder encodeObject:_sellername forKey:kHSProductSellername];
    [aCoder encodeObject:_producttype forKey:kHSProductProducttype];
    [aCoder encodeObject:_starlevel forKey:kHSProductStarlevel];
    [aCoder encodeObject:_cityname forKey:kHSProductCityname];
    [aCoder encodeObject:_title forKey:kHSProductTitle];
    [aCoder encodeObject:_price forKey:kHSProductPrice];
    [aCoder encodeObject:_address forKey:kHSProductAddress];
    [aCoder encodeObject:_logo forKey:kHSProductLogo];
    [aCoder encodeObject:_citycode forKey:kHSProductCitycode];
    [aCoder encodeObject:_coinreturn forKey:kHSProductCoinreturn];
    [aCoder encodeObject:_sellerid forKey:kHSProductSellerid];
    [aCoder encodeObject:_isspecial forKey:kHSProductIsspecial];
    [aCoder encodeObject:_distance forKey:kHSProductDistance];
    [aCoder encodeObject:_isneedbook forKey:kHSProductIsneedbook];
    [aCoder encodeObject:_coinprice forKey:kHSProductCoinprice];
    [aCoder encodeObject:_score forKey:kHSProductScore];
}

- (id)copyWithZone:(NSZone *)zone
{
    HSProduct *copy = [[HSProduct alloc] init];
    
    if (copy) {

        copy.turnover = [self.turnover copyWithZone:zone];
        copy.productid = [self.productid copyWithZone:zone];
        copy.sellername = [self.sellername copyWithZone:zone];
        copy.producttype = [self.producttype copyWithZone:zone];
        copy.starlevel = [self.starlevel copyWithZone:zone];
        copy.cityname = [self.cityname copyWithZone:zone];
        copy.title = [self.title copyWithZone:zone];
        copy.price = [self.price copyWithZone:zone];
        copy.address = [self.address copyWithZone:zone];
        copy.logo = [self.logo copyWithZone:zone];
        copy.citycode = [self.citycode copyWithZone:zone];
        copy.coinreturn = [self.coinreturn copyWithZone:zone];
        copy.sellerid = [self.sellerid copyWithZone:zone];
        copy.isspecial = [self.isspecial copyWithZone:zone];
        copy.distance = [self.distance copyWithZone:zone];
        copy.isneedbook = [self.isneedbook copyWithZone:zone];
        copy.coinprice = [self.coinprice copyWithZone:zone];
        copy.score = [self.score copyWithZone:zone];
    }
    
    return copy;
}


@end
