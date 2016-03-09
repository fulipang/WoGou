//
//  ShoppingCarModelParser.m
//
//  Created by sooncong  on 16/1/19
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "ShoppingCarModelParser.h"


NSString *const kShoppingCarModelParserShoppingCarModel = @"body";


@interface ShoppingCarModelParser ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ShoppingCarModelParser

@synthesize shoppingCarModel = _shoppingCarModel;


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
            self.shoppingCarModel = [ShoppingCarModel modelObjectWithDictionary:[dict objectForKey:kShoppingCarModelParserShoppingCarModel]];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[self.shoppingCarModel dictionaryRepresentation] forKey:kShoppingCarModelParserShoppingCarModel];

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

    self.shoppingCarModel = [aDecoder decodeObjectForKey:kShoppingCarModelParserShoppingCarModel];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_shoppingCarModel forKey:kShoppingCarModelParserShoppingCarModel];
}

- (id)copyWithZone:(NSZone *)zone
{
    ShoppingCarModelParser *copy = [[ShoppingCarModelParser alloc] init];
    
    if (copy) {

        copy.shoppingCarModel = [self.shoppingCarModel copyWithZone:zone];
    }
    
    return copy;
}


@end
