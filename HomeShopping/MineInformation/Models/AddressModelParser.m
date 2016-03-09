//
//  AddressModelParser.m
//
//  Created by sooncong  on 16/1/18
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "AddressModelParser.h"


NSString *const kAddressModelParserAddressModel = @"body";


@interface AddressModelParser ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation AddressModelParser

@synthesize addressModel = _addressModel;


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
            self.addressModel = [AddressModel modelObjectWithDictionary:[dict objectForKey:kAddressModelParserAddressModel]];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[self.addressModel dictionaryRepresentation] forKey:kAddressModelParserAddressModel];

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

    self.addressModel = [aDecoder decodeObjectForKey:kAddressModelParserAddressModel];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_addressModel forKey:kAddressModelParserAddressModel];
}

- (id)copyWithZone:(NSZone *)zone
{
    AddressModelParser *copy = [[AddressModelParser alloc] init];
    
    if (copy) {

        copy.addressModel = [self.addressModel copyWithZone:zone];
    }
    
    return copy;
}


@end
