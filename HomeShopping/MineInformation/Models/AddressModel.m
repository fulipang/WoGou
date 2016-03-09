//
//  AddressModel.m
//
//  Created by sooncong  on 16/1/18
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "AddressModel.h"
#import "Addresse.h"


NSString *const kAddressModelProduct = @"product";
NSString *const kAddressModelFreights = @"freights";
NSString *const kAddressModelAddresse = @"addresses";


@interface AddressModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation AddressModel

@synthesize product = _product;
@synthesize freights = _freights;
@synthesize addresse = _addresse;


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
            self.product = [self objectOrNilForKey:kAddressModelProduct fromDictionary:dict];
            self.freights = [self objectOrNilForKey:kAddressModelFreights fromDictionary:dict];
    NSObject *receivedAddresse = [dict objectForKey:kAddressModelAddresse];
    NSMutableArray *parsedAddresse = [NSMutableArray array];
    if ([receivedAddresse isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedAddresse) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedAddresse addObject:[Addresse modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedAddresse isKindOfClass:[NSDictionary class]]) {
       [parsedAddresse addObject:[Addresse modelObjectWithDictionary:(NSDictionary *)receivedAddresse]];
    }

    self.addresse = [NSArray arrayWithArray:parsedAddresse];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    NSMutableArray *tempArrayForProduct = [NSMutableArray array];
    for (NSObject *subArrayObject in self.product) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForProduct addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForProduct addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForProduct] forKey:kAddressModelProduct];
    NSMutableArray *tempArrayForFreights = [NSMutableArray array];
    for (NSObject *subArrayObject in self.freights) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForFreights addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForFreights addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForFreights] forKey:kAddressModelFreights];
    NSMutableArray *tempArrayForAddresse = [NSMutableArray array];
    for (NSObject *subArrayObject in self.addresse) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForAddresse addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForAddresse addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForAddresse] forKey:kAddressModelAddresse];

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

    self.product = [aDecoder decodeObjectForKey:kAddressModelProduct];
    self.freights = [aDecoder decodeObjectForKey:kAddressModelFreights];
    self.addresse = [aDecoder decodeObjectForKey:kAddressModelAddresse];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_product forKey:kAddressModelProduct];
    [aCoder encodeObject:_freights forKey:kAddressModelFreights];
    [aCoder encodeObject:_addresse forKey:kAddressModelAddresse];
}

- (id)copyWithZone:(NSZone *)zone
{
    AddressModel *copy = [[AddressModel alloc] init];
    
    if (copy) {

        copy.product = [self.product copyWithZone:zone];
        copy.freights = [self.freights copyWithZone:zone];
        copy.addresse = [self.addresse copyWithZone:zone];
    }
    
    return copy;
}


@end
