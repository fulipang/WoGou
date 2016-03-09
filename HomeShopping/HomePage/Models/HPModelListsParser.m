//
//  HPModelListsParser.m
//
//  Created by sooncong  on 15/12/19
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "HPModelListsParser.h"


NSString *const kHPModelListsParserModelLists = @"body";


@interface HPModelListsParser ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation HPModelListsParser

@synthesize modelLists = _modelLists;


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
            self.modelLists = [HPModelLists modelObjectWithDictionary:[dict objectForKey:kHPModelListsParserModelLists]];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[self.modelLists dictionaryRepresentation] forKey:kHPModelListsParserModelLists];

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

    self.modelLists = [aDecoder decodeObjectForKey:kHPModelListsParserModelLists];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_modelLists forKey:kHPModelListsParserModelLists];
}

- (id)copyWithZone:(NSZone *)zone
{
    HPModelListsParser *copy = [[HPModelListsParser alloc] init];
    
    if (copy) {

        copy.modelLists = [self.modelLists copyWithZone:zone];
    }
    
    return copy;
}


@end
