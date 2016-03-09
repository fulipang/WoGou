//
//  Products.m
//
//  Created by sooncong  on 16/1/21
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "Products.h"
#import "Coupons.h"


NSString *const kProductsProducttype = @"producttype";
NSString *const kProductsBuycount = @"buycount";
NSString *const kProductsNormtitle = @"normtitle";
NSString *const kProductsTitle = @"title";
NSString *const kProductsIndate = @"indate";
NSString *const kProductsOutdate = @"outdate";
NSString *const kProductsPrice = @"price";
NSString *const kProductsLogo = @"logo";
NSString *const kProductsCoupons = @"coupons";
NSString *const kProductsCoinreturn = @"coinreturn";
NSString *const kProductsCoinprice = @"coinprice";
NSString *const kProductsIsspecial = @"isspecial";
NSString *const kProductsProductid = @"productid";


@interface Products ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation Products

@synthesize producttype = _producttype;
@synthesize buycount = _buycount;
@synthesize normtitle = _normtitle;
@synthesize title = _title;
@synthesize indate = _indate;
@synthesize outdate = _outdate;
@synthesize price = _price;
@synthesize logo = _logo;
@synthesize coupons = _coupons;
@synthesize coinreturn = _coinreturn;
@synthesize coinprice = _coinprice;
@synthesize isspecial = _isspecial;
@synthesize productid = _productid;


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
            self.producttype = [self objectOrNilForKey:kProductsProducttype fromDictionary:dict];
            self.buycount = [self objectOrNilForKey:kProductsBuycount fromDictionary:dict];
            self.normtitle = [self objectOrNilForKey:kProductsNormtitle fromDictionary:dict];
            self.title = [self objectOrNilForKey:kProductsTitle fromDictionary:dict];
            self.indate = [self objectOrNilForKey:kProductsIndate fromDictionary:dict];
            self.outdate = [self objectOrNilForKey:kProductsOutdate fromDictionary:dict];
            self.price = [self objectOrNilForKey:kProductsPrice fromDictionary:dict];
            self.logo = [self objectOrNilForKey:kProductsLogo fromDictionary:dict];
    NSObject *receivedCoupons = [dict objectForKey:kProductsCoupons];
    NSMutableArray *parsedCoupons = [NSMutableArray array];
    if ([receivedCoupons isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedCoupons) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedCoupons addObject:[Coupons modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedCoupons isKindOfClass:[NSDictionary class]]) {
       [parsedCoupons addObject:[Coupons modelObjectWithDictionary:(NSDictionary *)receivedCoupons]];
    }

    self.coupons = [NSArray arrayWithArray:parsedCoupons];
            self.coinreturn = [self objectOrNilForKey:kProductsCoinreturn fromDictionary:dict];
            self.coinprice = [self objectOrNilForKey:kProductsCoinprice fromDictionary:dict];
            self.isspecial = [self objectOrNilForKey:kProductsIsspecial fromDictionary:dict];
            self.productid = [self objectOrNilForKey:kProductsProductid fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.producttype forKey:kProductsProducttype];
    [mutableDict setValue:self.buycount forKey:kProductsBuycount];
    [mutableDict setValue:self.normtitle forKey:kProductsNormtitle];
    [mutableDict setValue:self.title forKey:kProductsTitle];
    [mutableDict setValue:self.indate forKey:kProductsIndate];
    [mutableDict setValue:self.outdate forKey:kProductsOutdate];
    [mutableDict setValue:self.price forKey:kProductsPrice];
    [mutableDict setValue:self.logo forKey:kProductsLogo];
    NSMutableArray *tempArrayForCoupons = [NSMutableArray array];
    for (NSObject *subArrayObject in self.coupons) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForCoupons addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForCoupons addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForCoupons] forKey:kProductsCoupons];
    [mutableDict setValue:self.coinreturn forKey:kProductsCoinreturn];
    [mutableDict setValue:self.coinprice forKey:kProductsCoinprice];
    [mutableDict setValue:self.isspecial forKey:kProductsIsspecial];
    [mutableDict setValue:self.productid forKey:kProductsProductid];

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

    self.producttype = [aDecoder decodeObjectForKey:kProductsProducttype];
    self.buycount = [aDecoder decodeObjectForKey:kProductsBuycount];
    self.normtitle = [aDecoder decodeObjectForKey:kProductsNormtitle];
    self.title = [aDecoder decodeObjectForKey:kProductsTitle];
    self.indate = [aDecoder decodeObjectForKey:kProductsIndate];
    self.outdate = [aDecoder decodeObjectForKey:kProductsOutdate];
    self.price = [aDecoder decodeObjectForKey:kProductsPrice];
    self.logo = [aDecoder decodeObjectForKey:kProductsLogo];
    self.coupons = [aDecoder decodeObjectForKey:kProductsCoupons];
    self.coinreturn = [aDecoder decodeObjectForKey:kProductsCoinreturn];
    self.coinprice = [aDecoder decodeObjectForKey:kProductsCoinprice];
    self.isspecial = [aDecoder decodeObjectForKey:kProductsIsspecial];
    self.productid = [aDecoder decodeObjectForKey:kProductsProductid];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_producttype forKey:kProductsProducttype];
    [aCoder encodeObject:_buycount forKey:kProductsBuycount];
    [aCoder encodeObject:_normtitle forKey:kProductsNormtitle];
    [aCoder encodeObject:_title forKey:kProductsTitle];
    [aCoder encodeObject:_indate forKey:kProductsIndate];
    [aCoder encodeObject:_outdate forKey:kProductsOutdate];
    [aCoder encodeObject:_price forKey:kProductsPrice];
    [aCoder encodeObject:_logo forKey:kProductsLogo];
    [aCoder encodeObject:_coupons forKey:kProductsCoupons];
    [aCoder encodeObject:_coinreturn forKey:kProductsCoinreturn];
    [aCoder encodeObject:_coinprice forKey:kProductsCoinprice];
    [aCoder encodeObject:_isspecial forKey:kProductsIsspecial];
    [aCoder encodeObject:_productid forKey:kProductsProductid];
}

- (id)copyWithZone:(NSZone *)zone
{
    Products *copy = [[Products alloc] init];
    
    if (copy) {

        copy.producttype = [self.producttype copyWithZone:zone];
        copy.buycount = [self.buycount copyWithZone:zone];
        copy.normtitle = [self.normtitle copyWithZone:zone];
        copy.title = [self.title copyWithZone:zone];
        copy.indate = [self.indate copyWithZone:zone];
        copy.outdate = [self.outdate copyWithZone:zone];
        copy.price = [self.price copyWithZone:zone];
        copy.logo = [self.logo copyWithZone:zone];
        copy.coupons = [self.coupons copyWithZone:zone];
        copy.coinreturn = [self.coinreturn copyWithZone:zone];
        copy.coinprice = [self.coinprice copyWithZone:zone];
        copy.isspecial = [self.isspecial copyWithZone:zone];
        copy.productid = [self.productid copyWithZone:zone];
    }
    
    return copy;
}


@end
