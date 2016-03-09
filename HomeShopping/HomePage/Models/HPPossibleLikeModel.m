//
//  HPPossibleLikeModel.m
//
//  Created by sooncong  on 15/12/19
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "HPPossibleLikeModel.h"


NSString *const kHPPossibleLikeModelDistance = @"distance";
NSString *const kHPPossibleLikeModelIsneedbook = @"isneedbook";
NSString *const kHPPossibleLikeModelLinkcontent = @"linkcontent";
NSString *const kHPPossibleLikeModelProductid = @"productid";
NSString *const kHPPossibleLikeModelProducttype = @"producttype";
NSString *const kHPPossibleLikeModelStarlevel = @"starlevel";
NSString *const kHPPossibleLikeModelCityname = @"cityname";
NSString *const kHPPossibleLikeModelTitle = @"title";
NSString *const kHPPossibleLikeModelPrice = @"price";
NSString *const kHPPossibleLikeModelAddress = @"address";
NSString *const kHPPossibleLikeModelLogo = @"logo";
NSString *const kHPPossibleLikeModelCitycode = @"citycode";
NSString *const kHPPossibleLikeModelCoinreturn = @"coinreturn";
NSString *const kHPPossibleLikeModelCoinprice = @"coinprice";
NSString *const kHPPossibleLikeModelIsspecial = @"isspecial";
NSString *const kHPPossibleLikeModelScore = @"score";
NSString *const kHPPossibleLikeModelTurnover = @"turnover";
NSString *const kHPPossibleLikeModelLinktype = @"linktype";


@interface HPPossibleLikeModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation HPPossibleLikeModel

@synthesize distance = _distance;
@synthesize isneedbook = _isneedbook;
@synthesize linkcontent = _linkcontent;
@synthesize productid = _productid;
@synthesize producttype = _producttype;
@synthesize starlevel = _starlevel;
@synthesize cityname = _cityname;
@synthesize title = _title;
@synthesize price = _price;
@synthesize address = _address;
@synthesize logo = _logo;
@synthesize citycode = _citycode;
@synthesize coinreturn = _coinreturn;
@synthesize coinprice = _coinprice;
@synthesize isspecial = _isspecial;
@synthesize score = _score;
@synthesize turnover = _turnover;
@synthesize linktype = _linktype;


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
            self.distance = [self objectOrNilForKey:kHPPossibleLikeModelDistance fromDictionary:dict];
            self.isneedbook = [self objectOrNilForKey:kHPPossibleLikeModelIsneedbook fromDictionary:dict];
            self.linkcontent = [self objectOrNilForKey:kHPPossibleLikeModelLinkcontent fromDictionary:dict];
            self.productid = [self objectOrNilForKey:kHPPossibleLikeModelProductid fromDictionary:dict];
            self.producttype = [self objectOrNilForKey:kHPPossibleLikeModelProducttype fromDictionary:dict];
            self.starlevel = [self objectOrNilForKey:kHPPossibleLikeModelStarlevel fromDictionary:dict];
            self.cityname = [self objectOrNilForKey:kHPPossibleLikeModelCityname fromDictionary:dict];
            self.title = [self objectOrNilForKey:kHPPossibleLikeModelTitle fromDictionary:dict];
            self.price = [self objectOrNilForKey:kHPPossibleLikeModelPrice fromDictionary:dict];
            self.address = [self objectOrNilForKey:kHPPossibleLikeModelAddress fromDictionary:dict];
            self.logo = [self objectOrNilForKey:kHPPossibleLikeModelLogo fromDictionary:dict];
            self.citycode = [self objectOrNilForKey:kHPPossibleLikeModelCitycode fromDictionary:dict];
            self.coinreturn = [self objectOrNilForKey:kHPPossibleLikeModelCoinreturn fromDictionary:dict];
            self.coinprice = [self objectOrNilForKey:kHPPossibleLikeModelCoinprice fromDictionary:dict];
            self.isspecial = [self objectOrNilForKey:kHPPossibleLikeModelIsspecial fromDictionary:dict];
            self.score = [self objectOrNilForKey:kHPPossibleLikeModelScore fromDictionary:dict];
            self.turnover = [self objectOrNilForKey:kHPPossibleLikeModelTurnover fromDictionary:dict];
            self.linktype = [self objectOrNilForKey:kHPPossibleLikeModelLinktype fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.distance forKey:kHPPossibleLikeModelDistance];
    [mutableDict setValue:self.isneedbook forKey:kHPPossibleLikeModelIsneedbook];
    [mutableDict setValue:self.linkcontent forKey:kHPPossibleLikeModelLinkcontent];
    [mutableDict setValue:self.productid forKey:kHPPossibleLikeModelProductid];
    [mutableDict setValue:self.producttype forKey:kHPPossibleLikeModelProducttype];
    [mutableDict setValue:self.starlevel forKey:kHPPossibleLikeModelStarlevel];
    [mutableDict setValue:self.cityname forKey:kHPPossibleLikeModelCityname];
    [mutableDict setValue:self.title forKey:kHPPossibleLikeModelTitle];
    [mutableDict setValue:self.price forKey:kHPPossibleLikeModelPrice];
    [mutableDict setValue:self.address forKey:kHPPossibleLikeModelAddress];
    [mutableDict setValue:self.logo forKey:kHPPossibleLikeModelLogo];
    [mutableDict setValue:self.citycode forKey:kHPPossibleLikeModelCitycode];
    [mutableDict setValue:self.coinreturn forKey:kHPPossibleLikeModelCoinreturn];
    [mutableDict setValue:self.coinprice forKey:kHPPossibleLikeModelCoinprice];
    [mutableDict setValue:self.isspecial forKey:kHPPossibleLikeModelIsspecial];
    [mutableDict setValue:self.score forKey:kHPPossibleLikeModelScore];
    [mutableDict setValue:self.turnover forKey:kHPPossibleLikeModelTurnover];
    [mutableDict setValue:self.linktype forKey:kHPPossibleLikeModelLinktype];

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

    self.distance = [aDecoder decodeObjectForKey:kHPPossibleLikeModelDistance];
    self.isneedbook = [aDecoder decodeObjectForKey:kHPPossibleLikeModelIsneedbook];
    self.linkcontent = [aDecoder decodeObjectForKey:kHPPossibleLikeModelLinkcontent];
    self.productid = [aDecoder decodeObjectForKey:kHPPossibleLikeModelProductid];
    self.producttype = [aDecoder decodeObjectForKey:kHPPossibleLikeModelProducttype];
    self.starlevel = [aDecoder decodeObjectForKey:kHPPossibleLikeModelStarlevel];
    self.cityname = [aDecoder decodeObjectForKey:kHPPossibleLikeModelCityname];
    self.title = [aDecoder decodeObjectForKey:kHPPossibleLikeModelTitle];
    self.price = [aDecoder decodeObjectForKey:kHPPossibleLikeModelPrice];
    self.address = [aDecoder decodeObjectForKey:kHPPossibleLikeModelAddress];
    self.logo = [aDecoder decodeObjectForKey:kHPPossibleLikeModelLogo];
    self.citycode = [aDecoder decodeObjectForKey:kHPPossibleLikeModelCitycode];
    self.coinreturn = [aDecoder decodeObjectForKey:kHPPossibleLikeModelCoinreturn];
    self.coinprice = [aDecoder decodeObjectForKey:kHPPossibleLikeModelCoinprice];
    self.isspecial = [aDecoder decodeObjectForKey:kHPPossibleLikeModelIsspecial];
    self.score = [aDecoder decodeObjectForKey:kHPPossibleLikeModelScore];
    self.turnover = [aDecoder decodeObjectForKey:kHPPossibleLikeModelTurnover];
    self.linktype = [aDecoder decodeObjectForKey:kHPPossibleLikeModelLinktype];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_distance forKey:kHPPossibleLikeModelDistance];
    [aCoder encodeObject:_isneedbook forKey:kHPPossibleLikeModelIsneedbook];
    [aCoder encodeObject:_linkcontent forKey:kHPPossibleLikeModelLinkcontent];
    [aCoder encodeObject:_productid forKey:kHPPossibleLikeModelProductid];
    [aCoder encodeObject:_producttype forKey:kHPPossibleLikeModelProducttype];
    [aCoder encodeObject:_starlevel forKey:kHPPossibleLikeModelStarlevel];
    [aCoder encodeObject:_cityname forKey:kHPPossibleLikeModelCityname];
    [aCoder encodeObject:_title forKey:kHPPossibleLikeModelTitle];
    [aCoder encodeObject:_price forKey:kHPPossibleLikeModelPrice];
    [aCoder encodeObject:_address forKey:kHPPossibleLikeModelAddress];
    [aCoder encodeObject:_logo forKey:kHPPossibleLikeModelLogo];
    [aCoder encodeObject:_citycode forKey:kHPPossibleLikeModelCitycode];
    [aCoder encodeObject:_coinreturn forKey:kHPPossibleLikeModelCoinreturn];
    [aCoder encodeObject:_coinprice forKey:kHPPossibleLikeModelCoinprice];
    [aCoder encodeObject:_isspecial forKey:kHPPossibleLikeModelIsspecial];
    [aCoder encodeObject:_score forKey:kHPPossibleLikeModelScore];
    [aCoder encodeObject:_turnover forKey:kHPPossibleLikeModelTurnover];
    [aCoder encodeObject:_linktype forKey:kHPPossibleLikeModelLinktype];
}

- (id)copyWithZone:(NSZone *)zone
{
    HPPossibleLikeModel *copy = [[HPPossibleLikeModel alloc] init];
    
    if (copy) {

        copy.distance = [self.distance copyWithZone:zone];
        copy.isneedbook = [self.isneedbook copyWithZone:zone];
        copy.linkcontent = [self.linkcontent copyWithZone:zone];
        copy.productid = [self.productid copyWithZone:zone];
        copy.producttype = [self.producttype copyWithZone:zone];
        copy.starlevel = [self.starlevel copyWithZone:zone];
        copy.cityname = [self.cityname copyWithZone:zone];
        copy.title = [self.title copyWithZone:zone];
        copy.price = [self.price copyWithZone:zone];
        copy.address = [self.address copyWithZone:zone];
        copy.logo = [self.logo copyWithZone:zone];
        copy.citycode = [self.citycode copyWithZone:zone];
        copy.coinreturn = [self.coinreturn copyWithZone:zone];
        copy.coinprice = [self.coinprice copyWithZone:zone];
        copy.isspecial = [self.isspecial copyWithZone:zone];
        copy.score = [self.score copyWithZone:zone];
        copy.turnover = [self.turnover copyWithZone:zone];
        copy.linktype = [self.linktype copyWithZone:zone];
    }
    
    return copy;
}


@end
