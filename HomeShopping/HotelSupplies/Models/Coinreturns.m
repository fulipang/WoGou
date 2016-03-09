//
//  Coinreturns.m
//
//  Created by sooncong  on 16/1/5
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "Coinreturns.h"


NSString *const kCoinreturnsCoinreturnmin = @"coinreturnmin";
NSString *const kCoinreturnsCoinreturnmax = @"coinreturnmax";


@interface Coinreturns ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation Coinreturns

@synthesize coinreturnmin = _coinreturnmin;
@synthesize coinreturnmax = _coinreturnmax;


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
            self.coinreturnmin = [self objectOrNilForKey:kCoinreturnsCoinreturnmin fromDictionary:dict];
            self.coinreturnmax = [self objectOrNilForKey:kCoinreturnsCoinreturnmax fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.coinreturnmin forKey:kCoinreturnsCoinreturnmin];
    [mutableDict setValue:self.coinreturnmax forKey:kCoinreturnsCoinreturnmax];

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

    self.coinreturnmin = [aDecoder decodeObjectForKey:kCoinreturnsCoinreturnmin];
    self.coinreturnmax = [aDecoder decodeObjectForKey:kCoinreturnsCoinreturnmax];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_coinreturnmin forKey:kCoinreturnsCoinreturnmin];
    [aCoder encodeObject:_coinreturnmax forKey:kCoinreturnsCoinreturnmax];
}

- (id)copyWithZone:(NSZone *)zone
{
    Coinreturns *copy = [[Coinreturns alloc] init];
    
    if (copy) {

        copy.coinreturnmin = [self.coinreturnmin copyWithZone:zone];
        copy.coinreturnmax = [self.coinreturnmax copyWithZone:zone];
    }
    
    return copy;
}


@end
