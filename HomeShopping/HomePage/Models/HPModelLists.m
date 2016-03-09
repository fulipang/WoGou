//
//  HPModelLists.m
//
//  Created by sooncong  on 15/12/19
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "HPModelLists.h"
#import "HPPossibleLikeModel.h"
#import "HPCategorysModel.h"
#import "HPAddsModel.h"


NSString *const kHPModelListsPossibleLikeModel = @"likes";
NSString *const kHPModelListsCategorysModel = @"categorys";
NSString *const kHPModelListsAddsModel = @"topadvs";


@interface HPModelLists ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation HPModelLists

@synthesize possibleLikeModel = _possibleLikeModel;
@synthesize categorysModel = _categorysModel;
@synthesize addsModel = _addsModel;


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
    NSObject *receivedHPPossibleLikeModel = [dict objectForKey:kHPModelListsPossibleLikeModel];
    NSMutableArray *parsedHPPossibleLikeModel = [NSMutableArray array];
    if ([receivedHPPossibleLikeModel isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedHPPossibleLikeModel) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedHPPossibleLikeModel addObject:[HPPossibleLikeModel modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedHPPossibleLikeModel isKindOfClass:[NSDictionary class]]) {
       [parsedHPPossibleLikeModel addObject:[HPPossibleLikeModel modelObjectWithDictionary:(NSDictionary *)receivedHPPossibleLikeModel]];
    }

    self.possibleLikeModel = [NSArray arrayWithArray:parsedHPPossibleLikeModel];
    NSObject *receivedHPCategorysModel = [dict objectForKey:kHPModelListsCategorysModel];
    NSMutableArray *parsedHPCategorysModel = [NSMutableArray array];
    if ([receivedHPCategorysModel isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedHPCategorysModel) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedHPCategorysModel addObject:[HPCategorysModel modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedHPCategorysModel isKindOfClass:[NSDictionary class]]) {
       [parsedHPCategorysModel addObject:[HPCategorysModel modelObjectWithDictionary:(NSDictionary *)receivedHPCategorysModel]];
    }

    self.categorysModel = [NSArray arrayWithArray:parsedHPCategorysModel];
    NSObject *receivedHPAddsModel = [dict objectForKey:kHPModelListsAddsModel];
    NSMutableArray *parsedHPAddsModel = [NSMutableArray array];
    if ([receivedHPAddsModel isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedHPAddsModel) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedHPAddsModel addObject:[HPAddsModel modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedHPAddsModel isKindOfClass:[NSDictionary class]]) {
       [parsedHPAddsModel addObject:[HPAddsModel modelObjectWithDictionary:(NSDictionary *)receivedHPAddsModel]];
    }

    self.addsModel = [NSArray arrayWithArray:parsedHPAddsModel];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    NSMutableArray *tempArrayForPossibleLikeModel = [NSMutableArray array];
    for (NSObject *subArrayObject in self.possibleLikeModel) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForPossibleLikeModel addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForPossibleLikeModel addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForPossibleLikeModel] forKey:kHPModelListsPossibleLikeModel];
    NSMutableArray *tempArrayForCategorysModel = [NSMutableArray array];
    for (NSObject *subArrayObject in self.categorysModel) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForCategorysModel addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForCategorysModel addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForCategorysModel] forKey:kHPModelListsCategorysModel];
    NSMutableArray *tempArrayForAddsModel = [NSMutableArray array];
    for (NSObject *subArrayObject in self.addsModel) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForAddsModel addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForAddsModel addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForAddsModel] forKey:kHPModelListsAddsModel];

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

    self.possibleLikeModel = [aDecoder decodeObjectForKey:kHPModelListsPossibleLikeModel];
    self.categorysModel = [aDecoder decodeObjectForKey:kHPModelListsCategorysModel];
    self.addsModel = [aDecoder decodeObjectForKey:kHPModelListsAddsModel];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_possibleLikeModel forKey:kHPModelListsPossibleLikeModel];
    [aCoder encodeObject:_categorysModel forKey:kHPModelListsCategorysModel];
    [aCoder encodeObject:_addsModel forKey:kHPModelListsAddsModel];
}

- (id)copyWithZone:(NSZone *)zone
{
    HPModelLists *copy = [[HPModelLists alloc] init];
    
    if (copy) {

        copy.possibleLikeModel = [self.possibleLikeModel copyWithZone:zone];
        copy.categorysModel = [self.categorysModel copyWithZone:zone];
        copy.addsModel = [self.addsModel copyWithZone:zone];
    }
    
    return copy;
}


@end
