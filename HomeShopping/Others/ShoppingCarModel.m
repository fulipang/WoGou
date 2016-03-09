//
//  ShoppingCarModel.m
//
//  Created by sooncong  on 16/1/19
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "ShoppingCarModel.h"
#import "ShoppingCarProduct.h"


NSString *const kShoppingCarModelTotalpage = @"totalpage";
NSString *const kShoppingCarModelShoppingCarProduct = @"products";
NSString *const kShoppingCarModelTotalcount = @"totalcount";


@interface ShoppingCarModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ShoppingCarModel

@synthesize totalpage = _totalpage;
@synthesize shoppingCarProduct = _shoppingCarProduct;
@synthesize totalcount = _totalcount;


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
            self.totalpage = [self objectOrNilForKey:kShoppingCarModelTotalpage fromDictionary:dict];
    NSObject *receivedShoppingCarProduct = [dict objectForKey:kShoppingCarModelShoppingCarProduct];
    NSMutableArray *parsedShoppingCarProduct = [NSMutableArray array];
    if ([receivedShoppingCarProduct isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedShoppingCarProduct) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedShoppingCarProduct addObject:[ShoppingCarProduct modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedShoppingCarProduct isKindOfClass:[NSDictionary class]]) {
       [parsedShoppingCarProduct addObject:[ShoppingCarProduct modelObjectWithDictionary:(NSDictionary *)receivedShoppingCarProduct]];
    }

    self.shoppingCarProduct = [NSArray arrayWithArray:parsedShoppingCarProduct];
            self.totalcount = [self objectOrNilForKey:kShoppingCarModelTotalcount fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.totalpage forKey:kShoppingCarModelTotalpage];
    NSMutableArray *tempArrayForShoppingCarProduct = [NSMutableArray array];
    for (NSObject *subArrayObject in self.shoppingCarProduct) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForShoppingCarProduct addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForShoppingCarProduct addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForShoppingCarProduct] forKey:kShoppingCarModelShoppingCarProduct];
    [mutableDict setValue:self.totalcount forKey:kShoppingCarModelTotalcount];

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

    self.totalpage = [aDecoder decodeObjectForKey:kShoppingCarModelTotalpage];
    self.shoppingCarProduct = [aDecoder decodeObjectForKey:kShoppingCarModelShoppingCarProduct];
    self.totalcount = [aDecoder decodeObjectForKey:kShoppingCarModelTotalcount];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_totalpage forKey:kShoppingCarModelTotalpage];
    [aCoder encodeObject:_shoppingCarProduct forKey:kShoppingCarModelShoppingCarProduct];
    [aCoder encodeObject:_totalcount forKey:kShoppingCarModelTotalcount];
}

- (id)copyWithZone:(NSZone *)zone
{
    ShoppingCarModel *copy = [[ShoppingCarModel alloc] init];
    
    if (copy) {

        copy.totalpage = [self.totalpage copyWithZone:zone];
        copy.shoppingCarProduct = [self.shoppingCarProduct copyWithZone:zone];
        copy.totalcount = [self.totalcount copyWithZone:zone];
    }
    
    return copy;
}


@end
