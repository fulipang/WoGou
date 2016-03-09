//
//  OrderDetailproducts.m
//
//  Created by sooncong  on 16/1/24
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "OrderDetailproducts.h"
#import "Coupons.h"


NSString *const kOrderDetailproductsShortintro = @"shortintro";
NSString *const kOrderDetailproductsOrderproductcode = @"orderproductcode";
NSString *const kOrderDetailproductsProducttype = @"producttype";
NSString *const kOrderDetailproductsBuycount = @"buycount";
NSString *const kOrderDetailproductsNormtitle = @"normtitle";
NSString *const kOrderDetailproductsTitle = @"title";
NSString *const kOrderDetailproductsIndate = @"indate";
NSString *const kOrderDetailproductsOutdate = @"outdate";
NSString *const kOrderDetailproductsPrice = @"price";
NSString *const kOrderDetailproductsLogo = @"logo";
NSString *const kOrderDetailproductsCoinreturn = @"coinreturn";
NSString *const kOrderDetailproductsCoupons = @"coupons";
NSString *const kOrderDetailproductsCoinprice = @"coinprice";
NSString *const kOrderDetailproductsIsspecial = @"isspecial";
NSString *const kOrderDetailproductsProductid = @"productid";


@interface OrderDetailproducts ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation OrderDetailproducts

@synthesize shortintro = _shortintro;
@synthesize orderproductcode = _orderproductcode;
@synthesize producttype = _producttype;
@synthesize buycount = _buycount;
@synthesize normtitle = _normtitle;
@synthesize title = _title;
@synthesize indate = _indate;
@synthesize outdate = _outdate;
@synthesize price = _price;
@synthesize logo = _logo;
@synthesize coinreturn = _coinreturn;
@synthesize coupons = _coupons;
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
        self.shortintro = [self objectOrNilForKey:kOrderDetailproductsShortintro fromDictionary:dict];
        self.orderproductcode = [self objectOrNilForKey:kOrderDetailproductsOrderproductcode fromDictionary:dict];
        self.producttype = [self objectOrNilForKey:kOrderDetailproductsProducttype fromDictionary:dict];
        self.buycount = [self objectOrNilForKey:kOrderDetailproductsBuycount fromDictionary:dict];
        self.normtitle = [self objectOrNilForKey:kOrderDetailproductsNormtitle fromDictionary:dict];
        self.title = [self objectOrNilForKey:kOrderDetailproductsTitle fromDictionary:dict];
        self.indate = [self objectOrNilForKey:kOrderDetailproductsIndate fromDictionary:dict];
        self.outdate = [self objectOrNilForKey:kOrderDetailproductsOutdate fromDictionary:dict];
        self.price = [self objectOrNilForKey:kOrderDetailproductsPrice fromDictionary:dict];
        self.logo = [self objectOrNilForKey:kOrderDetailproductsLogo fromDictionary:dict];
        self.coinreturn = [self objectOrNilForKey:kOrderDetailproductsCoinreturn fromDictionary:dict];
        NSObject *receivedCoupons = [dict objectForKey:kOrderDetailproductsCoupons];
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
        self.coinprice = [self objectOrNilForKey:kOrderDetailproductsCoinprice fromDictionary:dict];
        self.isspecial = [self objectOrNilForKey:kOrderDetailproductsIsspecial fromDictionary:dict];
        self.productid = [self objectOrNilForKey:kOrderDetailproductsProductid fromDictionary:dict];
        
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.shortintro forKey:kOrderDetailproductsShortintro];
    [mutableDict setValue:self.orderproductcode forKey:kOrderDetailproductsOrderproductcode];
    [mutableDict setValue:self.producttype forKey:kOrderDetailproductsProducttype];
    [mutableDict setValue:self.buycount forKey:kOrderDetailproductsBuycount];
    [mutableDict setValue:self.normtitle forKey:kOrderDetailproductsNormtitle];
    [mutableDict setValue:self.title forKey:kOrderDetailproductsTitle];
    [mutableDict setValue:self.indate forKey:kOrderDetailproductsIndate];
    [mutableDict setValue:self.outdate forKey:kOrderDetailproductsOutdate];
    [mutableDict setValue:self.price forKey:kOrderDetailproductsPrice];
    [mutableDict setValue:self.logo forKey:kOrderDetailproductsLogo];
    [mutableDict setValue:self.coinreturn forKey:kOrderDetailproductsCoinreturn];
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
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForCoupons] forKey:kOrderDetailproductsCoupons];
    [mutableDict setValue:self.coinprice forKey:kOrderDetailproductsCoinprice];
    [mutableDict setValue:self.isspecial forKey:kOrderDetailproductsIsspecial];
    [mutableDict setValue:self.productid forKey:kOrderDetailproductsProductid];
    
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
    
    self.shortintro = [aDecoder decodeObjectForKey:kOrderDetailproductsShortintro];
    self.orderproductcode = [aDecoder decodeObjectForKey:kOrderDetailproductsOrderproductcode];
    self.producttype = [aDecoder decodeObjectForKey:kOrderDetailproductsProducttype];
    self.buycount = [aDecoder decodeObjectForKey:kOrderDetailproductsBuycount];
    self.normtitle = [aDecoder decodeObjectForKey:kOrderDetailproductsNormtitle];
    self.title = [aDecoder decodeObjectForKey:kOrderDetailproductsTitle];
    self.indate = [aDecoder decodeObjectForKey:kOrderDetailproductsIndate];
    self.outdate = [aDecoder decodeObjectForKey:kOrderDetailproductsOutdate];
    self.price = [aDecoder decodeObjectForKey:kOrderDetailproductsPrice];
    self.logo = [aDecoder decodeObjectForKey:kOrderDetailproductsLogo];
    self.coinreturn = [aDecoder decodeObjectForKey:kOrderDetailproductsCoinreturn];
    self.coupons = [aDecoder decodeObjectForKey:kOrderDetailproductsCoupons];
    self.coinprice = [aDecoder decodeObjectForKey:kOrderDetailproductsCoinprice];
    self.isspecial = [aDecoder decodeObjectForKey:kOrderDetailproductsIsspecial];
    self.productid = [aDecoder decodeObjectForKey:kOrderDetailproductsProductid];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
    [aCoder encodeObject:_shortintro forKey:kOrderDetailproductsShortintro];
    [aCoder encodeObject:_orderproductcode forKey:kOrderDetailproductsOrderproductcode];
    [aCoder encodeObject:_producttype forKey:kOrderDetailproductsProducttype];
    [aCoder encodeObject:_buycount forKey:kOrderDetailproductsBuycount];
    [aCoder encodeObject:_normtitle forKey:kOrderDetailproductsNormtitle];
    [aCoder encodeObject:_title forKey:kOrderDetailproductsTitle];
    [aCoder encodeObject:_indate forKey:kOrderDetailproductsIndate];
    [aCoder encodeObject:_outdate forKey:kOrderDetailproductsOutdate];
    [aCoder encodeObject:_price forKey:kOrderDetailproductsPrice];
    [aCoder encodeObject:_logo forKey:kOrderDetailproductsLogo];
    [aCoder encodeObject:_coinreturn forKey:kOrderDetailproductsCoinreturn];
    [aCoder encodeObject:_coupons forKey:kOrderDetailproductsCoupons];
    [aCoder encodeObject:_coinprice forKey:kOrderDetailproductsCoinprice];
    [aCoder encodeObject:_isspecial forKey:kOrderDetailproductsIsspecial];
    [aCoder encodeObject:_productid forKey:kOrderDetailproductsProductid];
}

- (id)copyWithZone:(NSZone *)zone
{
    OrderDetailproducts *copy = [[OrderDetailproducts alloc] init];
    
    if (copy) {
        
        copy.shortintro = [self.shortintro copyWithZone:zone];
        copy.orderproductcode = [self.orderproductcode copyWithZone:zone];
        copy.producttype = [self.producttype copyWithZone:zone];
        copy.buycount = [self.buycount copyWithZone:zone];
        copy.normtitle = [self.normtitle copyWithZone:zone];
        copy.title = [self.title copyWithZone:zone];
        copy.indate = [self.indate copyWithZone:zone];
        copy.outdate = [self.outdate copyWithZone:zone];
        copy.price = [self.price copyWithZone:zone];
        copy.logo = [self.logo copyWithZone:zone];
        copy.coinreturn = [self.coinreturn copyWithZone:zone];
        copy.coupons = [self.coupons copyWithZone:zone];
        copy.coinprice = [self.coinprice copyWithZone:zone];
        copy.isspecial = [self.isspecial copyWithZone:zone];
        copy.productid = [self.productid copyWithZone:zone];
    }
    
    return copy;
}


@end
