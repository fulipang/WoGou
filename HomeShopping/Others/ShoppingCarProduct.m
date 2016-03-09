//
//  ShoppingCarProduct.m
//
//  Created by sooncong  on 16/1/19
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "ShoppingCarProduct.h"


NSString *const kShoppingCarProductCityname = @"cityname";
NSString *const kShoppingCarProductCoinprice = @"coinprice";
NSString *const kShoppingCarProductTitle = @"title";
NSString *const kShoppingCarProductStarlevel = @"starlevel";
NSString *const kShoppingCarProductOutdate = @"outdate";
NSString *const kShoppingCarProductScore = @"score";
NSString *const kShoppingCarProductTag = @"tag";
NSString *const kShoppingCarProductNormtitle = @"normtitle";
NSString *const kShoppingCarProductIndate = @"indate";
NSString *const kShoppingCarProductSellername = @"sellername";
NSString *const kShoppingCarProductPricenow = @"pricenow";
NSString *const kShoppingCarProductIsneedbook = @"isneedbook";
NSString *const kShoppingCarProductProducttype = @"producttype";
NSString *const kShoppingCarProductTurnover = @"turnover";
NSString *const kShoppingCarProductIsspecial = @"isspecial";
NSString *const kShoppingCarProductProductid = @"productid";
NSString *const kShoppingCarProductDistance = @"distance";
NSString *const kShoppingCarProductSellerid = @"sellerid";
NSString *const kShoppingCarProductLogo = @"logo";
NSString *const kShoppingCarProductPrice = @"price";
NSString *const kShoppingCarProductBuycount = @"buycount";
NSString *const kShoppingCarProductCitycode = @"citycode";
NSString *const kShoppingCarProductAddress = @"address";
NSString *const kShoppingCarProductCoinreturn = @"coinreturn";


@interface ShoppingCarProduct ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ShoppingCarProduct

@synthesize cityname = _cityname;
@synthesize coinprice = _coinprice;
@synthesize title = _title;
@synthesize starlevel = _starlevel;
@synthesize outdate = _outdate;
@synthesize score = _score;
@synthesize tag = _tag;
@synthesize normtitle = _normtitle;
@synthesize indate = _indate;
@synthesize sellername = _sellername;
@synthesize pricenow = _pricenow;
@synthesize isneedbook = _isneedbook;
@synthesize producttype = _producttype;
@synthesize turnover = _turnover;
@synthesize isspecial = _isspecial;
@synthesize productid = _productid;
@synthesize distance = _distance;
@synthesize sellerid = _sellerid;
@synthesize logo = _logo;
@synthesize price = _price;
@synthesize buycount = _buycount;
@synthesize citycode = _citycode;
@synthesize address = _address;
@synthesize coinreturn = _coinreturn;


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
            self.cityname = [self objectOrNilForKey:kShoppingCarProductCityname fromDictionary:dict];
            self.coinprice = [self objectOrNilForKey:kShoppingCarProductCoinprice fromDictionary:dict];
            self.title = [self objectOrNilForKey:kShoppingCarProductTitle fromDictionary:dict];
            self.starlevel = [self objectOrNilForKey:kShoppingCarProductStarlevel fromDictionary:dict];
            self.outdate = [self objectOrNilForKey:kShoppingCarProductOutdate fromDictionary:dict];
            self.score = [self objectOrNilForKey:kShoppingCarProductScore fromDictionary:dict];
            self.tag = [self objectOrNilForKey:kShoppingCarProductTag fromDictionary:dict];
            self.normtitle = [self objectOrNilForKey:kShoppingCarProductNormtitle fromDictionary:dict];
            self.indate = [self objectOrNilForKey:kShoppingCarProductIndate fromDictionary:dict];
            self.sellername = [self objectOrNilForKey:kShoppingCarProductSellername fromDictionary:dict];
            self.pricenow = [self objectOrNilForKey:kShoppingCarProductPricenow fromDictionary:dict];
            self.isneedbook = [self objectOrNilForKey:kShoppingCarProductIsneedbook fromDictionary:dict];
            self.producttype = [self objectOrNilForKey:kShoppingCarProductProducttype fromDictionary:dict];
            self.turnover = [self objectOrNilForKey:kShoppingCarProductTurnover fromDictionary:dict];
            self.isspecial = [self objectOrNilForKey:kShoppingCarProductIsspecial fromDictionary:dict];
            self.productid = [self objectOrNilForKey:kShoppingCarProductProductid fromDictionary:dict];
            self.distance = [self objectOrNilForKey:kShoppingCarProductDistance fromDictionary:dict];
            self.sellerid = [self objectOrNilForKey:kShoppingCarProductSellerid fromDictionary:dict];
            self.logo = [self objectOrNilForKey:kShoppingCarProductLogo fromDictionary:dict];
            self.price = [self objectOrNilForKey:kShoppingCarProductPrice fromDictionary:dict];
            self.buycount = [self objectOrNilForKey:kShoppingCarProductBuycount fromDictionary:dict];
            self.citycode = [self objectOrNilForKey:kShoppingCarProductCitycode fromDictionary:dict];
            self.address = [self objectOrNilForKey:kShoppingCarProductAddress fromDictionary:dict];
            self.coinreturn = [self objectOrNilForKey:kShoppingCarProductCoinreturn fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.cityname forKey:kShoppingCarProductCityname];
    [mutableDict setValue:self.coinprice forKey:kShoppingCarProductCoinprice];
    [mutableDict setValue:self.title forKey:kShoppingCarProductTitle];
    [mutableDict setValue:self.starlevel forKey:kShoppingCarProductStarlevel];
    [mutableDict setValue:self.outdate forKey:kShoppingCarProductOutdate];
    [mutableDict setValue:self.score forKey:kShoppingCarProductScore];
    [mutableDict setValue:self.tag forKey:kShoppingCarProductTag];
    [mutableDict setValue:self.normtitle forKey:kShoppingCarProductNormtitle];
    [mutableDict setValue:self.indate forKey:kShoppingCarProductIndate];
    [mutableDict setValue:self.sellername forKey:kShoppingCarProductSellername];
    [mutableDict setValue:self.pricenow forKey:kShoppingCarProductPricenow];
    [mutableDict setValue:self.isneedbook forKey:kShoppingCarProductIsneedbook];
    [mutableDict setValue:self.producttype forKey:kShoppingCarProductProducttype];
    [mutableDict setValue:self.turnover forKey:kShoppingCarProductTurnover];
    [mutableDict setValue:self.isspecial forKey:kShoppingCarProductIsspecial];
    [mutableDict setValue:self.productid forKey:kShoppingCarProductProductid];
    [mutableDict setValue:self.distance forKey:kShoppingCarProductDistance];
    [mutableDict setValue:self.sellerid forKey:kShoppingCarProductSellerid];
    [mutableDict setValue:self.logo forKey:kShoppingCarProductLogo];
    [mutableDict setValue:self.price forKey:kShoppingCarProductPrice];
    [mutableDict setValue:self.buycount forKey:kShoppingCarProductBuycount];
    [mutableDict setValue:self.citycode forKey:kShoppingCarProductCitycode];
    [mutableDict setValue:self.address forKey:kShoppingCarProductAddress];
    [mutableDict setValue:self.coinreturn forKey:kShoppingCarProductCoinreturn];

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

    self.cityname = [aDecoder decodeObjectForKey:kShoppingCarProductCityname];
    self.coinprice = [aDecoder decodeObjectForKey:kShoppingCarProductCoinprice];
    self.title = [aDecoder decodeObjectForKey:kShoppingCarProductTitle];
    self.starlevel = [aDecoder decodeObjectForKey:kShoppingCarProductStarlevel];
    self.outdate = [aDecoder decodeObjectForKey:kShoppingCarProductOutdate];
    self.score = [aDecoder decodeObjectForKey:kShoppingCarProductScore];
    self.tag = [aDecoder decodeObjectForKey:kShoppingCarProductTag];
    self.normtitle = [aDecoder decodeObjectForKey:kShoppingCarProductNormtitle];
    self.indate = [aDecoder decodeObjectForKey:kShoppingCarProductIndate];
    self.sellername = [aDecoder decodeObjectForKey:kShoppingCarProductSellername];
    self.pricenow = [aDecoder decodeObjectForKey:kShoppingCarProductPricenow];
    self.isneedbook = [aDecoder decodeObjectForKey:kShoppingCarProductIsneedbook];
    self.producttype = [aDecoder decodeObjectForKey:kShoppingCarProductProducttype];
    self.turnover = [aDecoder decodeObjectForKey:kShoppingCarProductTurnover];
    self.isspecial = [aDecoder decodeObjectForKey:kShoppingCarProductIsspecial];
    self.productid = [aDecoder decodeObjectForKey:kShoppingCarProductProductid];
    self.distance = [aDecoder decodeObjectForKey:kShoppingCarProductDistance];
    self.sellerid = [aDecoder decodeObjectForKey:kShoppingCarProductSellerid];
    self.logo = [aDecoder decodeObjectForKey:kShoppingCarProductLogo];
    self.price = [aDecoder decodeObjectForKey:kShoppingCarProductPrice];
    self.buycount = [aDecoder decodeObjectForKey:kShoppingCarProductBuycount];
    self.citycode = [aDecoder decodeObjectForKey:kShoppingCarProductCitycode];
    self.address = [aDecoder decodeObjectForKey:kShoppingCarProductAddress];
    self.coinreturn = [aDecoder decodeObjectForKey:kShoppingCarProductCoinreturn];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_cityname forKey:kShoppingCarProductCityname];
    [aCoder encodeObject:_coinprice forKey:kShoppingCarProductCoinprice];
    [aCoder encodeObject:_title forKey:kShoppingCarProductTitle];
    [aCoder encodeObject:_starlevel forKey:kShoppingCarProductStarlevel];
    [aCoder encodeObject:_outdate forKey:kShoppingCarProductOutdate];
    [aCoder encodeObject:_score forKey:kShoppingCarProductScore];
    [aCoder encodeObject:_tag forKey:kShoppingCarProductTag];
    [aCoder encodeObject:_normtitle forKey:kShoppingCarProductNormtitle];
    [aCoder encodeObject:_indate forKey:kShoppingCarProductIndate];
    [aCoder encodeObject:_sellername forKey:kShoppingCarProductSellername];
    [aCoder encodeObject:_pricenow forKey:kShoppingCarProductPricenow];
    [aCoder encodeObject:_isneedbook forKey:kShoppingCarProductIsneedbook];
    [aCoder encodeObject:_producttype forKey:kShoppingCarProductProducttype];
    [aCoder encodeObject:_turnover forKey:kShoppingCarProductTurnover];
    [aCoder encodeObject:_isspecial forKey:kShoppingCarProductIsspecial];
    [aCoder encodeObject:_productid forKey:kShoppingCarProductProductid];
    [aCoder encodeObject:_distance forKey:kShoppingCarProductDistance];
    [aCoder encodeObject:_sellerid forKey:kShoppingCarProductSellerid];
    [aCoder encodeObject:_logo forKey:kShoppingCarProductLogo];
    [aCoder encodeObject:_price forKey:kShoppingCarProductPrice];
    [aCoder encodeObject:_buycount forKey:kShoppingCarProductBuycount];
    [aCoder encodeObject:_citycode forKey:kShoppingCarProductCitycode];
    [aCoder encodeObject:_address forKey:kShoppingCarProductAddress];
    [aCoder encodeObject:_coinreturn forKey:kShoppingCarProductCoinreturn];
}

- (id)copyWithZone:(NSZone *)zone
{
    ShoppingCarProduct *copy = [[ShoppingCarProduct alloc] init];
    
    if (copy) {

        copy.cityname = [self.cityname copyWithZone:zone];
        copy.coinprice = [self.coinprice copyWithZone:zone];
        copy.title = [self.title copyWithZone:zone];
        copy.starlevel = [self.starlevel copyWithZone:zone];
        copy.outdate = [self.outdate copyWithZone:zone];
        copy.score = [self.score copyWithZone:zone];
        copy.tag = [self.tag copyWithZone:zone];
        copy.normtitle = [self.normtitle copyWithZone:zone];
        copy.indate = [self.indate copyWithZone:zone];
        copy.sellername = [self.sellername copyWithZone:zone];
        copy.pricenow = [self.pricenow copyWithZone:zone];
        copy.isneedbook = [self.isneedbook copyWithZone:zone];
        copy.producttype = [self.producttype copyWithZone:zone];
        copy.turnover = [self.turnover copyWithZone:zone];
        copy.isspecial = [self.isspecial copyWithZone:zone];
        copy.productid = [self.productid copyWithZone:zone];
        copy.distance = [self.distance copyWithZone:zone];
        copy.sellerid = [self.sellerid copyWithZone:zone];
        copy.logo = [self.logo copyWithZone:zone];
        copy.price = [self.price copyWithZone:zone];
        copy.buycount = [self.buycount copyWithZone:zone];
        copy.citycode = [self.citycode copyWithZone:zone];
        copy.address = [self.address copyWithZone:zone];
        copy.coinreturn = [self.coinreturn copyWithZone:zone];
    }
    
    return copy;
}


@end
