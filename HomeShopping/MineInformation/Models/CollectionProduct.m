//
//  CollectionProduct.m
//
//  Created by sooncong  on 16/1/17
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "CollectionProduct.h"


NSString *const kCollectionProductCityname = @"cityname";
NSString *const kCollectionProductCoinprice = @"coinprice";
NSString *const kCollectionProductTitle = @"title";
NSString *const kCollectionProductStarlevel = @"starlevel";
NSString *const kCollectionProductOutdate = @"outdate";
NSString *const kCollectionProductScore = @"score";
NSString *const kCollectionProductTag = @"tag";
NSString *const kCollectionProductNormtitle = @"normtitle";
NSString *const kCollectionProductIndate = @"indate";
NSString *const kCollectionProductSellername = @"sellername";
NSString *const kCollectionProductPricenow = @"pricenow";
NSString *const kCollectionProductIsneedbook = @"isneedbook";
NSString *const kCollectionProductProducttype = @"producttype";
NSString *const kCollectionProductTurnover = @"turnover";
NSString *const kCollectionProductIsspecial = @"isspecial";
NSString *const kCollectionProductProductid = @"productid";
NSString *const kCollectionProductDistance = @"distance";
NSString *const kCollectionProductSellerid = @"sellerid";
NSString *const kCollectionProductLogo = @"logo";
NSString *const kCollectionProductPrice = @"price";
NSString *const kCollectionProductBuycount = @"buycount";
NSString *const kCollectionProductCitycode = @"citycode";
NSString *const kCollectionProductAddress = @"address";
NSString *const kCollectionProductCoinreturn = @"coinreturn";


@interface CollectionProduct ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation CollectionProduct

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
            self.cityname = [self objectOrNilForKey:kCollectionProductCityname fromDictionary:dict];
            self.coinprice = [self objectOrNilForKey:kCollectionProductCoinprice fromDictionary:dict];
            self.title = [self objectOrNilForKey:kCollectionProductTitle fromDictionary:dict];
            self.starlevel = [self objectOrNilForKey:kCollectionProductStarlevel fromDictionary:dict];
            self.outdate = [self objectOrNilForKey:kCollectionProductOutdate fromDictionary:dict];
            self.score = [self objectOrNilForKey:kCollectionProductScore fromDictionary:dict];
            self.tag = [self objectOrNilForKey:kCollectionProductTag fromDictionary:dict];
            self.normtitle = [self objectOrNilForKey:kCollectionProductNormtitle fromDictionary:dict];
            self.indate = [self objectOrNilForKey:kCollectionProductIndate fromDictionary:dict];
            self.sellername = [self objectOrNilForKey:kCollectionProductSellername fromDictionary:dict];
            self.pricenow = [self objectOrNilForKey:kCollectionProductPricenow fromDictionary:dict];
            self.isneedbook = [self objectOrNilForKey:kCollectionProductIsneedbook fromDictionary:dict];
            self.producttype = [self objectOrNilForKey:kCollectionProductProducttype fromDictionary:dict];
            self.turnover = [self objectOrNilForKey:kCollectionProductTurnover fromDictionary:dict];
            self.isspecial = [self objectOrNilForKey:kCollectionProductIsspecial fromDictionary:dict];
            self.productid = [self objectOrNilForKey:kCollectionProductProductid fromDictionary:dict];
            self.distance = [self objectOrNilForKey:kCollectionProductDistance fromDictionary:dict];
            self.sellerid = [self objectOrNilForKey:kCollectionProductSellerid fromDictionary:dict];
            self.logo = [self objectOrNilForKey:kCollectionProductLogo fromDictionary:dict];
            self.price = [self objectOrNilForKey:kCollectionProductPrice fromDictionary:dict];
            self.buycount = [self objectOrNilForKey:kCollectionProductBuycount fromDictionary:dict];
            self.citycode = [self objectOrNilForKey:kCollectionProductCitycode fromDictionary:dict];
            self.address = [self objectOrNilForKey:kCollectionProductAddress fromDictionary:dict];
            self.coinreturn = [self objectOrNilForKey:kCollectionProductCoinreturn fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.cityname forKey:kCollectionProductCityname];
    [mutableDict setValue:self.coinprice forKey:kCollectionProductCoinprice];
    [mutableDict setValue:self.title forKey:kCollectionProductTitle];
    [mutableDict setValue:self.starlevel forKey:kCollectionProductStarlevel];
    [mutableDict setValue:self.outdate forKey:kCollectionProductOutdate];
    [mutableDict setValue:self.score forKey:kCollectionProductScore];
    [mutableDict setValue:self.tag forKey:kCollectionProductTag];
    [mutableDict setValue:self.normtitle forKey:kCollectionProductNormtitle];
    [mutableDict setValue:self.indate forKey:kCollectionProductIndate];
    [mutableDict setValue:self.sellername forKey:kCollectionProductSellername];
    [mutableDict setValue:self.pricenow forKey:kCollectionProductPricenow];
    [mutableDict setValue:self.isneedbook forKey:kCollectionProductIsneedbook];
    [mutableDict setValue:self.producttype forKey:kCollectionProductProducttype];
    [mutableDict setValue:self.turnover forKey:kCollectionProductTurnover];
    [mutableDict setValue:self.isspecial forKey:kCollectionProductIsspecial];
    [mutableDict setValue:self.productid forKey:kCollectionProductProductid];
    [mutableDict setValue:self.distance forKey:kCollectionProductDistance];
    [mutableDict setValue:self.sellerid forKey:kCollectionProductSellerid];
    [mutableDict setValue:self.logo forKey:kCollectionProductLogo];
    [mutableDict setValue:self.price forKey:kCollectionProductPrice];
    [mutableDict setValue:self.buycount forKey:kCollectionProductBuycount];
    [mutableDict setValue:self.citycode forKey:kCollectionProductCitycode];
    [mutableDict setValue:self.address forKey:kCollectionProductAddress];
    [mutableDict setValue:self.coinreturn forKey:kCollectionProductCoinreturn];

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

    self.cityname = [aDecoder decodeObjectForKey:kCollectionProductCityname];
    self.coinprice = [aDecoder decodeObjectForKey:kCollectionProductCoinprice];
    self.title = [aDecoder decodeObjectForKey:kCollectionProductTitle];
    self.starlevel = [aDecoder decodeObjectForKey:kCollectionProductStarlevel];
    self.outdate = [aDecoder decodeObjectForKey:kCollectionProductOutdate];
    self.score = [aDecoder decodeObjectForKey:kCollectionProductScore];
    self.tag = [aDecoder decodeObjectForKey:kCollectionProductTag];
    self.normtitle = [aDecoder decodeObjectForKey:kCollectionProductNormtitle];
    self.indate = [aDecoder decodeObjectForKey:kCollectionProductIndate];
    self.sellername = [aDecoder decodeObjectForKey:kCollectionProductSellername];
    self.pricenow = [aDecoder decodeObjectForKey:kCollectionProductPricenow];
    self.isneedbook = [aDecoder decodeObjectForKey:kCollectionProductIsneedbook];
    self.producttype = [aDecoder decodeObjectForKey:kCollectionProductProducttype];
    self.turnover = [aDecoder decodeObjectForKey:kCollectionProductTurnover];
    self.isspecial = [aDecoder decodeObjectForKey:kCollectionProductIsspecial];
    self.productid = [aDecoder decodeObjectForKey:kCollectionProductProductid];
    self.distance = [aDecoder decodeObjectForKey:kCollectionProductDistance];
    self.sellerid = [aDecoder decodeObjectForKey:kCollectionProductSellerid];
    self.logo = [aDecoder decodeObjectForKey:kCollectionProductLogo];
    self.price = [aDecoder decodeObjectForKey:kCollectionProductPrice];
    self.buycount = [aDecoder decodeObjectForKey:kCollectionProductBuycount];
    self.citycode = [aDecoder decodeObjectForKey:kCollectionProductCitycode];
    self.address = [aDecoder decodeObjectForKey:kCollectionProductAddress];
    self.coinreturn = [aDecoder decodeObjectForKey:kCollectionProductCoinreturn];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_cityname forKey:kCollectionProductCityname];
    [aCoder encodeObject:_coinprice forKey:kCollectionProductCoinprice];
    [aCoder encodeObject:_title forKey:kCollectionProductTitle];
    [aCoder encodeObject:_starlevel forKey:kCollectionProductStarlevel];
    [aCoder encodeObject:_outdate forKey:kCollectionProductOutdate];
    [aCoder encodeObject:_score forKey:kCollectionProductScore];
    [aCoder encodeObject:_tag forKey:kCollectionProductTag];
    [aCoder encodeObject:_normtitle forKey:kCollectionProductNormtitle];
    [aCoder encodeObject:_indate forKey:kCollectionProductIndate];
    [aCoder encodeObject:_sellername forKey:kCollectionProductSellername];
    [aCoder encodeObject:_pricenow forKey:kCollectionProductPricenow];
    [aCoder encodeObject:_isneedbook forKey:kCollectionProductIsneedbook];
    [aCoder encodeObject:_producttype forKey:kCollectionProductProducttype];
    [aCoder encodeObject:_turnover forKey:kCollectionProductTurnover];
    [aCoder encodeObject:_isspecial forKey:kCollectionProductIsspecial];
    [aCoder encodeObject:_productid forKey:kCollectionProductProductid];
    [aCoder encodeObject:_distance forKey:kCollectionProductDistance];
    [aCoder encodeObject:_sellerid forKey:kCollectionProductSellerid];
    [aCoder encodeObject:_logo forKey:kCollectionProductLogo];
    [aCoder encodeObject:_price forKey:kCollectionProductPrice];
    [aCoder encodeObject:_buycount forKey:kCollectionProductBuycount];
    [aCoder encodeObject:_citycode forKey:kCollectionProductCitycode];
    [aCoder encodeObject:_address forKey:kCollectionProductAddress];
    [aCoder encodeObject:_coinreturn forKey:kCollectionProductCoinreturn];
}

- (id)copyWithZone:(NSZone *)zone
{
    CollectionProduct *copy = [[CollectionProduct alloc] init];
    
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
