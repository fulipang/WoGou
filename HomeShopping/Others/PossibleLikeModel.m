//
//  PossibleLikeModel.m
//
//  Created by sooncong  on 16/1/20
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "PossibleLikeModel.h"
#import "PossibleLike.h"
#import "Hotellikes.h"


NSString *const kPossibleLikeModelPossibleLike = @"likes";
NSString *const kPossibleLikeModelHotellikes = @"hotellikes";


@interface PossibleLikeModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation PossibleLikeModel

@synthesize possibleLike = _possibleLike;
@synthesize hotellikes = _hotellikes;


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
        NSObject *receivedPossibleLike = [dict objectForKey:kPossibleLikeModelPossibleLike];
        NSMutableArray *parsedPossibleLike = [NSMutableArray array];
        if ([receivedPossibleLike isKindOfClass:[NSArray class]]) {
            for (NSDictionary *item in (NSArray *)receivedPossibleLike) {
                if ([item isKindOfClass:[NSDictionary class]]) {
                    [parsedPossibleLike addObject:[PossibleLike modelObjectWithDictionary:item]];
                }
            }
        } else if ([receivedPossibleLike isKindOfClass:[NSDictionary class]]) {
            [parsedPossibleLike addObject:[PossibleLike modelObjectWithDictionary:(NSDictionary *)receivedPossibleLike]];
        }
        
        self.possibleLike = [NSArray arrayWithArray:parsedPossibleLike];
        NSObject *receivedHotellikes = [dict objectForKey:kPossibleLikeModelHotellikes];
        NSMutableArray *parsedHotellikes = [NSMutableArray array];
        if ([receivedHotellikes isKindOfClass:[NSArray class]]) {
            for (NSDictionary *item in (NSArray *)receivedHotellikes) {
                if ([item isKindOfClass:[NSDictionary class]]) {
                    [parsedHotellikes addObject:[Hotellikes modelObjectWithDictionary:item]];
                }
            }
        } else if ([receivedHotellikes isKindOfClass:[NSDictionary class]]) {
            [parsedHotellikes addObject:[Hotellikes modelObjectWithDictionary:(NSDictionary *)receivedHotellikes]];
        }
        
        self.hotellikes = [NSArray arrayWithArray:parsedHotellikes];
        
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    NSMutableArray *tempArrayForPossibleLike = [NSMutableArray array];
    for (NSObject *subArrayObject in self.possibleLike) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForPossibleLike addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForPossibleLike addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForPossibleLike] forKey:kPossibleLikeModelPossibleLike];
    NSMutableArray *tempArrayForHotellikes = [NSMutableArray array];
    for (NSObject *subArrayObject in self.hotellikes) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForHotellikes addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForHotellikes addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForHotellikes] forKey:kPossibleLikeModelHotellikes];
    
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
    
    self.possibleLike = [aDecoder decodeObjectForKey:kPossibleLikeModelPossibleLike];
    self.hotellikes = [aDecoder decodeObjectForKey:kPossibleLikeModelHotellikes];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
    [aCoder encodeObject:_possibleLike forKey:kPossibleLikeModelPossibleLike];
    [aCoder encodeObject:_hotellikes forKey:kPossibleLikeModelHotellikes];
}

- (id)copyWithZone:(NSZone *)zone
{
    PossibleLikeModel *copy = [[PossibleLikeModel alloc] init];
    
    if (copy) {
        
        copy.possibleLike = [self.possibleLike copyWithZone:zone];
        copy.hotellikes = [self.hotellikes copyWithZone:zone];
    }
    
    return copy;
}


@end
