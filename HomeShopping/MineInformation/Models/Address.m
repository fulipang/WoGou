//
//  Address.m
//
//  Created by sooncong  on 16/1/23
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "Address.h"


NSString *const kAddressAddressid = @"addressid";
NSString *const kAddressConsigneephone = @"consigneephone";
NSString *const kAddressConsigneeaddress = @"consigneeaddress";
NSString *const kAddressPca = @"pca";
NSString *const kAddressConsignee = @"consignee";


@interface Address ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation Address

@synthesize addressid = _addressid;
@synthesize consigneephone = _consigneephone;
@synthesize consigneeaddress = _consigneeaddress;
@synthesize pca = _pca;
@synthesize consignee = _consignee;


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
            self.addressid = [self objectOrNilForKey:kAddressAddressid fromDictionary:dict];
            self.consigneephone = [self objectOrNilForKey:kAddressConsigneephone fromDictionary:dict];
            self.consigneeaddress = [self objectOrNilForKey:kAddressConsigneeaddress fromDictionary:dict];
            self.pca = [self objectOrNilForKey:kAddressPca fromDictionary:dict];
            self.consignee = [self objectOrNilForKey:kAddressConsignee fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.addressid forKey:kAddressAddressid];
    [mutableDict setValue:self.consigneephone forKey:kAddressConsigneephone];
    [mutableDict setValue:self.consigneeaddress forKey:kAddressConsigneeaddress];
    [mutableDict setValue:self.pca forKey:kAddressPca];
    [mutableDict setValue:self.consignee forKey:kAddressConsignee];

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

    self.addressid = [aDecoder decodeObjectForKey:kAddressAddressid];
    self.consigneephone = [aDecoder decodeObjectForKey:kAddressConsigneephone];
    self.consigneeaddress = [aDecoder decodeObjectForKey:kAddressConsigneeaddress];
    self.pca = [aDecoder decodeObjectForKey:kAddressPca];
    self.consignee = [aDecoder decodeObjectForKey:kAddressConsignee];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_addressid forKey:kAddressAddressid];
    [aCoder encodeObject:_consigneephone forKey:kAddressConsigneephone];
    [aCoder encodeObject:_consigneeaddress forKey:kAddressConsigneeaddress];
    [aCoder encodeObject:_pca forKey:kAddressPca];
    [aCoder encodeObject:_consignee forKey:kAddressConsignee];
}

- (id)copyWithZone:(NSZone *)zone
{
    Address *copy = [[Address alloc] init];
    
    if (copy) {

        copy.addressid = [self.addressid copyWithZone:zone];
        copy.consigneephone = [self.consigneephone copyWithZone:zone];
        copy.consigneeaddress = [self.consigneeaddress copyWithZone:zone];
        copy.pca = [self.pca copyWithZone:zone];
        copy.consignee = [self.consignee copyWithZone:zone];
    }
    
    return copy;
}


@end
