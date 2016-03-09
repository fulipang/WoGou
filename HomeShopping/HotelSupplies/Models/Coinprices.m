//
//  Coinprices.m
//
//  Created by sooncong  on 16/1/5
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "Coinprices.h"


NSString *const kCoinpricesCoinpricemin = @"coinpricemin";
NSString *const kCoinpricesCoinpricemax = @"coinpricemax";


@interface Coinprices ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation Coinprices

@synthesize coinpricemin = _coinpricemin;
@synthesize coinpricemax = _coinpricemax;


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
            self.coinpricemin = [self objectOrNilForKey:kCoinpricesCoinpricemin fromDictionary:dict];
            self.coinpricemax = [self objectOrNilForKey:kCoinpricesCoinpricemax fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.coinpricemin forKey:kCoinpricesCoinpricemin];
    [mutableDict setValue:self.coinpricemax forKey:kCoinpricesCoinpricemax];

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

    self.coinpricemin = [aDecoder decodeObjectForKey:kCoinpricesCoinpricemin];
    self.coinpricemax = [aDecoder decodeObjectForKey:kCoinpricesCoinpricemax];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_coinpricemin forKey:kCoinpricesCoinpricemin];
    [aCoder encodeObject:_coinpricemax forKey:kCoinpricesCoinpricemax];
}

- (id)copyWithZone:(NSZone *)zone
{
    Coinprices *copy = [[Coinprices alloc] init];
    
    if (copy) {

        copy.coinpricemin = [self.coinpricemin copyWithZone:zone];
        copy.coinpricemax = [self.coinpricemax copyWithZone:zone];
    }
    
    return copy;
}


@end
