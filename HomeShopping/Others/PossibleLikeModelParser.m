//
//  PossibleLikeModelParser.m
//
//  Created by sooncong  on 16/1/15
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "PossibleLikeModelParser.h"

NSString *const kPossibleLikeModelParserPossibleLikeModel = @"body";


@interface PossibleLikeModelParser ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation PossibleLikeModelParser

@synthesize possibleLikeModel = _possibleLikeModel;


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
            self.possibleLikeModel = [PossibleLikeModel modelObjectWithDictionary:[dict objectForKey:kPossibleLikeModelParserPossibleLikeModel]];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[self.possibleLikeModel dictionaryRepresentation] forKey:kPossibleLikeModelParserPossibleLikeModel];

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

    self.possibleLikeModel = [aDecoder decodeObjectForKey:kPossibleLikeModelParserPossibleLikeModel];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_possibleLikeModel forKey:kPossibleLikeModelParserPossibleLikeModel];
}

- (id)copyWithZone:(NSZone *)zone
{
    PossibleLikeModelParser *copy = [[PossibleLikeModelParser alloc] init];
    
    if (copy) {

        copy.possibleLikeModel = [self.possibleLikeModel copyWithZone:zone];
    }
    
    return copy;
}


@end
