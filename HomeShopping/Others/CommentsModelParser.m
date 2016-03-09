//
//  CommentsModelParser.m
//
//  Created by sooncong  on 16/1/15
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "CommentsModelParser.h"


NSString *const kCommentsModelParserCommentsModel = @"body";


@interface CommentsModelParser ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation CommentsModelParser

@synthesize commentsModel = _commentsModel;


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
            self.commentsModel = [CommentsModel modelObjectWithDictionary:[dict objectForKey:kCommentsModelParserCommentsModel]];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[self.commentsModel dictionaryRepresentation] forKey:kCommentsModelParserCommentsModel];

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

    self.commentsModel = [aDecoder decodeObjectForKey:kCommentsModelParserCommentsModel];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_commentsModel forKey:kCommentsModelParserCommentsModel];
}

- (id)copyWithZone:(NSZone *)zone
{
    CommentsModelParser *copy = [[CommentsModelParser alloc] init];
    
    if (copy) {

        copy.commentsModel = [self.commentsModel copyWithZone:zone];
    }
    
    return copy;
}


@end
