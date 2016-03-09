//
//  PossibleLike.m
//
//  Created by sooncong  on 16/1/15
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "PossibleLike.h"


NSString *const kPossibleLikeCityname = @"cityname";
NSString *const kPossibleLikeCoinprice = @"coinprice";
NSString *const kPossibleLikeLinkcontent = @"linkcontent";
NSString *const kPossibleLikeTitle = @"title";
NSString *const kPossibleLikeStarlevel = @"starlevel";
NSString *const kPossibleLikeScore = @"score";
NSString *const kPossibleLikeSellername = @"sellername";
NSString *const kPossibleLikeIsneedbook = @"isneedbook";
NSString *const kPossibleLikeProducttype = @"producttype";
NSString *const kPossibleLikeTurnover = @"turnover";
NSString *const kPossibleLikeIsspecial = @"isspecial";
NSString *const kPossibleLikeProductid = @"productid";
NSString *const kPossibleLikeDistance = @"distance";
NSString *const kPossibleLikeSellerid = @"sellerid";
NSString *const kPossibleLikeLogo = @"logo";
NSString *const kPossibleLikePrice = @"price";
NSString *const kPossibleLikeLinktype = @"linktype";
NSString *const kPossibleLikeCitycode = @"citycode";
NSString *const kPossibleLikeAddress = @"address";
NSString *const kPossibleLikeCoinreturn = @"coinreturn";


@interface PossibleLike ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation PossibleLike

@synthesize cityname = _cityname;
@synthesize coinprice = _coinprice;
@synthesize linkcontent = _linkcontent;
@synthesize title = _title;
@synthesize starlevel = _starlevel;
@synthesize score = _score;
@synthesize sellername = _sellername;
@synthesize isneedbook = _isneedbook;
@synthesize producttype = _producttype;
@synthesize turnover = _turnover;
@synthesize isspecial = _isspecial;
@synthesize productid = _productid;
@synthesize distance = _distance;
@synthesize sellerid = _sellerid;
@synthesize logo = _logo;
@synthesize price = _price;
@synthesize linktype = _linktype;
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
            self.cityname = [self objectOrNilForKey:kPossibleLikeCityname fromDictionary:dict];
            self.coinprice = [self objectOrNilForKey:kPossibleLikeCoinprice fromDictionary:dict];
            self.linkcontent = [self objectOrNilForKey:kPossibleLikeLinkcontent fromDictionary:dict];
            self.title = [self objectOrNilForKey:kPossibleLikeTitle fromDictionary:dict];
            self.starlevel = [self objectOrNilForKey:kPossibleLikeStarlevel fromDictionary:dict];
            self.score = [self objectOrNilForKey:kPossibleLikeScore fromDictionary:dict];
            self.sellername = [self objectOrNilForKey:kPossibleLikeSellername fromDictionary:dict];
            self.isneedbook = [self objectOrNilForKey:kPossibleLikeIsneedbook fromDictionary:dict];
            self.producttype = [self objectOrNilForKey:kPossibleLikeProducttype fromDictionary:dict];
            self.turnover = [self objectOrNilForKey:kPossibleLikeTurnover fromDictionary:dict];
            self.isspecial = [self objectOrNilForKey:kPossibleLikeIsspecial fromDictionary:dict];
            self.productid = [self objectOrNilForKey:kPossibleLikeProductid fromDictionary:dict];
            self.distance = [self objectOrNilForKey:kPossibleLikeDistance fromDictionary:dict];
            self.sellerid = [self objectOrNilForKey:kPossibleLikeSellerid fromDictionary:dict];
            self.logo = [self objectOrNilForKey:kPossibleLikeLogo fromDictionary:dict];
            self.price = [self objectOrNilForKey:kPossibleLikePrice fromDictionary:dict];
            self.linktype = [self objectOrNilForKey:kPossibleLikeLinktype fromDictionary:dict];
            self.citycode = [self objectOrNilForKey:kPossibleLikeCitycode fromDictionary:dict];
            self.address = [self objectOrNilForKey:kPossibleLikeAddress fromDictionary:dict];
            self.coinreturn = [self objectOrNilForKey:kPossibleLikeCoinreturn fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.cityname forKey:kPossibleLikeCityname];
    [mutableDict setValue:self.coinprice forKey:kPossibleLikeCoinprice];
    [mutableDict setValue:self.linkcontent forKey:kPossibleLikeLinkcontent];
    [mutableDict setValue:self.title forKey:kPossibleLikeTitle];
    [mutableDict setValue:self.starlevel forKey:kPossibleLikeStarlevel];
    [mutableDict setValue:self.score forKey:kPossibleLikeScore];
    [mutableDict setValue:self.sellername forKey:kPossibleLikeSellername];
    [mutableDict setValue:self.isneedbook forKey:kPossibleLikeIsneedbook];
    [mutableDict setValue:self.producttype forKey:kPossibleLikeProducttype];
    [mutableDict setValue:self.turnover forKey:kPossibleLikeTurnover];
    [mutableDict setValue:self.isspecial forKey:kPossibleLikeIsspecial];
    [mutableDict setValue:self.productid forKey:kPossibleLikeProductid];
    [mutableDict setValue:self.distance forKey:kPossibleLikeDistance];
    [mutableDict setValue:self.sellerid forKey:kPossibleLikeSellerid];
    [mutableDict setValue:self.logo forKey:kPossibleLikeLogo];
    [mutableDict setValue:self.price forKey:kPossibleLikePrice];
    [mutableDict setValue:self.linktype forKey:kPossibleLikeLinktype];
    [mutableDict setValue:self.citycode forKey:kPossibleLikeCitycode];
    [mutableDict setValue:self.address forKey:kPossibleLikeAddress];
    [mutableDict setValue:self.coinreturn forKey:kPossibleLikeCoinreturn];

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

    self.cityname = [aDecoder decodeObjectForKey:kPossibleLikeCityname];
    self.coinprice = [aDecoder decodeObjectForKey:kPossibleLikeCoinprice];
    self.linkcontent = [aDecoder decodeObjectForKey:kPossibleLikeLinkcontent];
    self.title = [aDecoder decodeObjectForKey:kPossibleLikeTitle];
    self.starlevel = [aDecoder decodeObjectForKey:kPossibleLikeStarlevel];
    self.score = [aDecoder decodeObjectForKey:kPossibleLikeScore];
    self.sellername = [aDecoder decodeObjectForKey:kPossibleLikeSellername];
    self.isneedbook = [aDecoder decodeObjectForKey:kPossibleLikeIsneedbook];
    self.producttype = [aDecoder decodeObjectForKey:kPossibleLikeProducttype];
    self.turnover = [aDecoder decodeObjectForKey:kPossibleLikeTurnover];
    self.isspecial = [aDecoder decodeObjectForKey:kPossibleLikeIsspecial];
    self.productid = [aDecoder decodeObjectForKey:kPossibleLikeProductid];
    self.distance = [aDecoder decodeObjectForKey:kPossibleLikeDistance];
    self.sellerid = [aDecoder decodeObjectForKey:kPossibleLikeSellerid];
    self.logo = [aDecoder decodeObjectForKey:kPossibleLikeLogo];
    self.price = [aDecoder decodeObjectForKey:kPossibleLikePrice];
    self.linktype = [aDecoder decodeObjectForKey:kPossibleLikeLinktype];
    self.citycode = [aDecoder decodeObjectForKey:kPossibleLikeCitycode];
    self.address = [aDecoder decodeObjectForKey:kPossibleLikeAddress];
    self.coinreturn = [aDecoder decodeObjectForKey:kPossibleLikeCoinreturn];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_cityname forKey:kPossibleLikeCityname];
    [aCoder encodeObject:_coinprice forKey:kPossibleLikeCoinprice];
    [aCoder encodeObject:_linkcontent forKey:kPossibleLikeLinkcontent];
    [aCoder encodeObject:_title forKey:kPossibleLikeTitle];
    [aCoder encodeObject:_starlevel forKey:kPossibleLikeStarlevel];
    [aCoder encodeObject:_score forKey:kPossibleLikeScore];
    [aCoder encodeObject:_sellername forKey:kPossibleLikeSellername];
    [aCoder encodeObject:_isneedbook forKey:kPossibleLikeIsneedbook];
    [aCoder encodeObject:_producttype forKey:kPossibleLikeProducttype];
    [aCoder encodeObject:_turnover forKey:kPossibleLikeTurnover];
    [aCoder encodeObject:_isspecial forKey:kPossibleLikeIsspecial];
    [aCoder encodeObject:_productid forKey:kPossibleLikeProductid];
    [aCoder encodeObject:_distance forKey:kPossibleLikeDistance];
    [aCoder encodeObject:_sellerid forKey:kPossibleLikeSellerid];
    [aCoder encodeObject:_logo forKey:kPossibleLikeLogo];
    [aCoder encodeObject:_price forKey:kPossibleLikePrice];
    [aCoder encodeObject:_linktype forKey:kPossibleLikeLinktype];
    [aCoder encodeObject:_citycode forKey:kPossibleLikeCitycode];
    [aCoder encodeObject:_address forKey:kPossibleLikeAddress];
    [aCoder encodeObject:_coinreturn forKey:kPossibleLikeCoinreturn];
}

- (id)copyWithZone:(NSZone *)zone
{
    PossibleLike *copy = [[PossibleLike alloc] init];
    
    if (copy) {

        copy.cityname = [self.cityname copyWithZone:zone];
        copy.coinprice = [self.coinprice copyWithZone:zone];
        copy.linkcontent = [self.linkcontent copyWithZone:zone];
        copy.title = [self.title copyWithZone:zone];
        copy.starlevel = [self.starlevel copyWithZone:zone];
        copy.score = [self.score copyWithZone:zone];
        copy.sellername = [self.sellername copyWithZone:zone];
        copy.isneedbook = [self.isneedbook copyWithZone:zone];
        copy.producttype = [self.producttype copyWithZone:zone];
        copy.turnover = [self.turnover copyWithZone:zone];
        copy.isspecial = [self.isspecial copyWithZone:zone];
        copy.productid = [self.productid copyWithZone:zone];
        copy.distance = [self.distance copyWithZone:zone];
        copy.sellerid = [self.sellerid copyWithZone:zone];
        copy.logo = [self.logo copyWithZone:zone];
        copy.price = [self.price copyWithZone:zone];
        copy.linktype = [self.linktype copyWithZone:zone];
        copy.citycode = [self.citycode copyWithZone:zone];
        copy.address = [self.address copyWithZone:zone];
        copy.coinreturn = [self.coinreturn copyWithZone:zone];
    }
    
    return copy;
}


@end
