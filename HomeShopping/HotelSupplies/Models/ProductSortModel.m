//
//  ProductSortModel.m
//
//  Created by sooncong  on 16/1/5
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "ProductSortModel.h"
#import "Productbrands.h"
#import "Coinreturns.h"
#import "Prices.h"
#import "Coinprices.h"


NSString *const kProductSortModelProductbrands = @"productbrands";
NSString *const kProductSortModelCoinreturns = @"coinreturns";
NSString *const kProductSortModelPrices = @"prices";
NSString *const kProductSortModelCoinprices = @"coinprices";


@interface ProductSortModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ProductSortModel

@synthesize productbrands = _productbrands;
@synthesize coinreturns = _coinreturns;
@synthesize prices = _prices;
@synthesize coinprices = _coinprices;


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
    NSObject *receivedProductbrands = [dict objectForKey:kProductSortModelProductbrands];
    NSMutableArray *parsedProductbrands = [NSMutableArray array];
    if ([receivedProductbrands isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedProductbrands) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedProductbrands addObject:[Productbrands modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedProductbrands isKindOfClass:[NSDictionary class]]) {
       [parsedProductbrands addObject:[Productbrands modelObjectWithDictionary:(NSDictionary *)receivedProductbrands]];
    }

    self.productbrands = [NSArray arrayWithArray:parsedProductbrands];
    NSObject *receivedCoinreturns = [dict objectForKey:kProductSortModelCoinreturns];
    NSMutableArray *parsedCoinreturns = [NSMutableArray array];
    if ([receivedCoinreturns isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedCoinreturns) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedCoinreturns addObject:[Coinreturns modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedCoinreturns isKindOfClass:[NSDictionary class]]) {
       [parsedCoinreturns addObject:[Coinreturns modelObjectWithDictionary:(NSDictionary *)receivedCoinreturns]];
    }

    self.coinreturns = [NSArray arrayWithArray:parsedCoinreturns];
    NSObject *receivedPrices = [dict objectForKey:kProductSortModelPrices];
    NSMutableArray *parsedPrices = [NSMutableArray array];
    if ([receivedPrices isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedPrices) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedPrices addObject:[Prices modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedPrices isKindOfClass:[NSDictionary class]]) {
       [parsedPrices addObject:[Prices modelObjectWithDictionary:(NSDictionary *)receivedPrices]];
    }

    self.prices = [NSArray arrayWithArray:parsedPrices];
    NSObject *receivedCoinprices = [dict objectForKey:kProductSortModelCoinprices];
    NSMutableArray *parsedCoinprices = [NSMutableArray array];
    if ([receivedCoinprices isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedCoinprices) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedCoinprices addObject:[Coinprices modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedCoinprices isKindOfClass:[NSDictionary class]]) {
       [parsedCoinprices addObject:[Coinprices modelObjectWithDictionary:(NSDictionary *)receivedCoinprices]];
    }

    self.coinprices = [NSArray arrayWithArray:parsedCoinprices];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    NSMutableArray *tempArrayForProductbrands = [NSMutableArray array];
    for (NSObject *subArrayObject in self.productbrands) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForProductbrands addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForProductbrands addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForProductbrands] forKey:kProductSortModelProductbrands];
    NSMutableArray *tempArrayForCoinreturns = [NSMutableArray array];
    for (NSObject *subArrayObject in self.coinreturns) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForCoinreturns addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForCoinreturns addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForCoinreturns] forKey:kProductSortModelCoinreturns];
    NSMutableArray *tempArrayForPrices = [NSMutableArray array];
    for (NSObject *subArrayObject in self.prices) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForPrices addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForPrices addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForPrices] forKey:kProductSortModelPrices];
    NSMutableArray *tempArrayForCoinprices = [NSMutableArray array];
    for (NSObject *subArrayObject in self.coinprices) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForCoinprices addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForCoinprices addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForCoinprices] forKey:kProductSortModelCoinprices];

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

    self.productbrands = [aDecoder decodeObjectForKey:kProductSortModelProductbrands];
    self.coinreturns = [aDecoder decodeObjectForKey:kProductSortModelCoinreturns];
    self.prices = [aDecoder decodeObjectForKey:kProductSortModelPrices];
    self.coinprices = [aDecoder decodeObjectForKey:kProductSortModelCoinprices];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_productbrands forKey:kProductSortModelProductbrands];
    [aCoder encodeObject:_coinreturns forKey:kProductSortModelCoinreturns];
    [aCoder encodeObject:_prices forKey:kProductSortModelPrices];
    [aCoder encodeObject:_coinprices forKey:kProductSortModelCoinprices];
}

- (id)copyWithZone:(NSZone *)zone
{
    ProductSortModel *copy = [[ProductSortModel alloc] init];
    
    if (copy) {

        copy.productbrands = [self.productbrands copyWithZone:zone];
        copy.coinreturns = [self.coinreturns copyWithZone:zone];
        copy.prices = [self.prices copyWithZone:zone];
        copy.coinprices = [self.coinprices copyWithZone:zone];
    }
    
    return copy;
}


@end
