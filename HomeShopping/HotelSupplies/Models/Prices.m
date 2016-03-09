//
//  Prices.m
//
//  Created by sooncong  on 16/1/5
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "Prices.h"


NSString *const kPricesPricemin = @"pricemin";
NSString *const kPricesPricemax = @"pricemax";


@interface Prices ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation Prices

@synthesize pricemin = _pricemin;
@synthesize pricemax = _pricemax;


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
            self.pricemin = [self objectOrNilForKey:kPricesPricemin fromDictionary:dict];
            self.pricemax = [self objectOrNilForKey:kPricesPricemax fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.pricemin forKey:kPricesPricemin];
    [mutableDict setValue:self.pricemax forKey:kPricesPricemax];

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

    self.pricemin = [aDecoder decodeObjectForKey:kPricesPricemin];
    self.pricemax = [aDecoder decodeObjectForKey:kPricesPricemax];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_pricemin forKey:kPricesPricemin];
    [aCoder encodeObject:_pricemax forKey:kPricesPricemax];
}

- (id)copyWithZone:(NSZone *)zone
{
    Prices *copy = [[Prices alloc] init];
    
    if (copy) {

        copy.pricemin = [self.pricemin copyWithZone:zone];
        copy.pricemax = [self.pricemax copyWithZone:zone];
    }
    
    return copy;
}


@end
