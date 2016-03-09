//
//  Productbrands.m
//
//  Created by sooncong  on 16/1/5
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "Productbrands.h"


NSString *const kProductbrandsProductbrandid = @"productbrandid";
NSString *const kProductbrandsTitle = @"title";


@interface Productbrands ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation Productbrands

@synthesize productbrandid = _productbrandid;
@synthesize title = _title;


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
            self.productbrandid = [self objectOrNilForKey:kProductbrandsProductbrandid fromDictionary:dict];
            self.title = [self objectOrNilForKey:kProductbrandsTitle fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.productbrandid forKey:kProductbrandsProductbrandid];
    [mutableDict setValue:self.title forKey:kProductbrandsTitle];

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

    self.productbrandid = [aDecoder decodeObjectForKey:kProductbrandsProductbrandid];
    self.title = [aDecoder decodeObjectForKey:kProductbrandsTitle];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_productbrandid forKey:kProductbrandsProductbrandid];
    [aCoder encodeObject:_title forKey:kProductbrandsTitle];
}

- (id)copyWithZone:(NSZone *)zone
{
    Productbrands *copy = [[Productbrands alloc] init];
    
    if (copy) {

        copy.productbrandid = [self.productbrandid copyWithZone:zone];
        copy.title = [self.title copyWithZone:zone];
    }
    
    return copy;
}


@end
