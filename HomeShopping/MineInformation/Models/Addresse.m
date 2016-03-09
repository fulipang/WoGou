//
//  Addresse.m
//
//  Created by sooncong  on 16/1/18
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "Addresse.h"


NSString *const kAddresseIsdefault = @"isdefault";
NSString *const kAddresseArea = @"area";
NSString *const kAddresseCity = @"city";
NSString *const kAddresseConsigneeaddress = @"consigneeaddress";
NSString *const kAddressePca = @"pca";
NSString *const kAddresseConsigneephone = @"consigneephone";
NSString *const kAddresseConsignee = @"consignee";
NSString *const kAddressePostcode = @"postcode";
NSString *const kAddresseAddressid = @"addressid";
NSString *const kAddresseProvince = @"province";


@interface Addresse ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation Addresse

@synthesize isdefault = _isdefault;
@synthesize area = _area;
@synthesize city = _city;
@synthesize consigneeaddress = _consigneeaddress;
@synthesize pca = _pca;
@synthesize consigneephone = _consigneephone;
@synthesize consignee = _consignee;
@synthesize postcode = _postcode;
@synthesize addressid = _addressid;
@synthesize province = _province;


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
            self.isdefault = [self objectOrNilForKey:kAddresseIsdefault fromDictionary:dict];
            self.area = [self objectOrNilForKey:kAddresseArea fromDictionary:dict];
            self.city = [self objectOrNilForKey:kAddresseCity fromDictionary:dict];
            self.consigneeaddress = [self objectOrNilForKey:kAddresseConsigneeaddress fromDictionary:dict];
            self.pca = [self objectOrNilForKey:kAddressePca fromDictionary:dict];
            self.consigneephone = [self objectOrNilForKey:kAddresseConsigneephone fromDictionary:dict];
            self.consignee = [self objectOrNilForKey:kAddresseConsignee fromDictionary:dict];
            self.postcode = [self objectOrNilForKey:kAddressePostcode fromDictionary:dict];
            self.addressid = [self objectOrNilForKey:kAddresseAddressid fromDictionary:dict];
            self.province = [self objectOrNilForKey:kAddresseProvince fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.isdefault forKey:kAddresseIsdefault];
    [mutableDict setValue:self.area forKey:kAddresseArea];
    [mutableDict setValue:self.city forKey:kAddresseCity];
    [mutableDict setValue:self.consigneeaddress forKey:kAddresseConsigneeaddress];
    [mutableDict setValue:self.pca forKey:kAddressePca];
    [mutableDict setValue:self.consigneephone forKey:kAddresseConsigneephone];
    [mutableDict setValue:self.consignee forKey:kAddresseConsignee];
    [mutableDict setValue:self.postcode forKey:kAddressePostcode];
    [mutableDict setValue:self.addressid forKey:kAddresseAddressid];
    [mutableDict setValue:self.province forKey:kAddresseProvince];

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

    self.isdefault = [aDecoder decodeObjectForKey:kAddresseIsdefault];
    self.area = [aDecoder decodeObjectForKey:kAddresseArea];
    self.city = [aDecoder decodeObjectForKey:kAddresseCity];
    self.consigneeaddress = [aDecoder decodeObjectForKey:kAddresseConsigneeaddress];
    self.pca = [aDecoder decodeObjectForKey:kAddressePca];
    self.consigneephone = [aDecoder decodeObjectForKey:kAddresseConsigneephone];
    self.consignee = [aDecoder decodeObjectForKey:kAddresseConsignee];
    self.postcode = [aDecoder decodeObjectForKey:kAddressePostcode];
    self.addressid = [aDecoder decodeObjectForKey:kAddresseAddressid];
    self.province = [aDecoder decodeObjectForKey:kAddresseProvince];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_isdefault forKey:kAddresseIsdefault];
    [aCoder encodeObject:_area forKey:kAddresseArea];
    [aCoder encodeObject:_city forKey:kAddresseCity];
    [aCoder encodeObject:_consigneeaddress forKey:kAddresseConsigneeaddress];
    [aCoder encodeObject:_pca forKey:kAddressePca];
    [aCoder encodeObject:_consigneephone forKey:kAddresseConsigneephone];
    [aCoder encodeObject:_consignee forKey:kAddresseConsignee];
    [aCoder encodeObject:_postcode forKey:kAddressePostcode];
    [aCoder encodeObject:_addressid forKey:kAddresseAddressid];
    [aCoder encodeObject:_province forKey:kAddresseProvince];
}

- (id)copyWithZone:(NSZone *)zone
{
    Addresse *copy = [[Addresse alloc] init];
    
    if (copy) {

        copy.isdefault = [self.isdefault copyWithZone:zone];
        copy.area = [self.area copyWithZone:zone];
        copy.city = [self.city copyWithZone:zone];
        copy.consigneeaddress = [self.consigneeaddress copyWithZone:zone];
        copy.pca = [self.pca copyWithZone:zone];
        copy.consigneephone = [self.consigneephone copyWithZone:zone];
        copy.consignee = [self.consignee copyWithZone:zone];
        copy.postcode = [self.postcode copyWithZone:zone];
        copy.addressid = [self.addressid copyWithZone:zone];
        copy.province = [self.province copyWithZone:zone];
    }
    
    return copy;
}


@end
