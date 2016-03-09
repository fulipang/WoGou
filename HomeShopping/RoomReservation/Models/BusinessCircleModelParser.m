//
//  BusinessCircleModelParser.m
//
//  Created by sooncong  on 16/1/4
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "BusinessCircleModelParser.h"

NSString *const kBusinessCircleModelParserBusinessCircleModel = @"body";


@interface BusinessCircleModelParser ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation BusinessCircleModelParser

@synthesize businessCircleModel = _businessCircleModel;


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
            self.businessCircleModel = [BusinessCircleModel modelObjectWithDictionary:[dict objectForKey:kBusinessCircleModelParserBusinessCircleModel]];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[self.businessCircleModel dictionaryRepresentation] forKey:kBusinessCircleModelParserBusinessCircleModel];

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

    self.businessCircleModel = [aDecoder decodeObjectForKey:kBusinessCircleModelParserBusinessCircleModel];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_businessCircleModel forKey:kBusinessCircleModelParserBusinessCircleModel];
}

- (id)copyWithZone:(NSZone *)zone
{
    BusinessCircleModelParser *copy = [[BusinessCircleModelParser alloc] init];
    
    if (copy) {

        copy.businessCircleModel = [self.businessCircleModel copyWithZone:zone];
    }
    
    return copy;
}


@end
