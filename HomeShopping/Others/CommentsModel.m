//
//  CommentsModel.m
//
//  Created by sooncong  on 16/1/15
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "CommentsModel.h"
#import "Comments.h"


NSString *const kCommentsModelComments = @"comments";
NSString *const kCommentsModelTotalcount1 = @"totalcount1";
NSString *const kCommentsModelTotalpage = @"totalpage";
NSString *const kCommentsModelTotalcount3 = @"totalcount3";
NSString *const kCommentsModelTotalcount = @"totalcount";
NSString *const kCommentsModelTotalcount0 = @"totalcount0";
NSString *const kCommentsModelTotalcount2 = @"totalcount2";


@interface CommentsModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation CommentsModel

@synthesize comments = _comments;
@synthesize totalcount1 = _totalcount1;
@synthesize totalpage = _totalpage;
@synthesize totalcount3 = _totalcount3;
@synthesize totalcount = _totalcount;
@synthesize totalcount0 = _totalcount0;
@synthesize totalcount2 = _totalcount2;


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
    NSObject *receivedComments = [dict objectForKey:kCommentsModelComments];
    NSMutableArray *parsedComments = [NSMutableArray array];
    if ([receivedComments isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedComments) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedComments addObject:[Comments modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedComments isKindOfClass:[NSDictionary class]]) {
       [parsedComments addObject:[Comments modelObjectWithDictionary:(NSDictionary *)receivedComments]];
    }

    self.comments = [NSArray arrayWithArray:parsedComments];
            self.totalcount1 = [self objectOrNilForKey:kCommentsModelTotalcount1 fromDictionary:dict];
            self.totalpage = [self objectOrNilForKey:kCommentsModelTotalpage fromDictionary:dict];
            self.totalcount3 = [self objectOrNilForKey:kCommentsModelTotalcount3 fromDictionary:dict];
            self.totalcount = [self objectOrNilForKey:kCommentsModelTotalcount fromDictionary:dict];
            self.totalcount0 = [self objectOrNilForKey:kCommentsModelTotalcount0 fromDictionary:dict];
            self.totalcount2 = [self objectOrNilForKey:kCommentsModelTotalcount2 fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    NSMutableArray *tempArrayForComments = [NSMutableArray array];
    for (NSObject *subArrayObject in self.comments) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForComments addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForComments addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForComments] forKey:kCommentsModelComments];
    [mutableDict setValue:self.totalcount1 forKey:kCommentsModelTotalcount1];
    [mutableDict setValue:self.totalpage forKey:kCommentsModelTotalpage];
    [mutableDict setValue:self.totalcount3 forKey:kCommentsModelTotalcount3];
    [mutableDict setValue:self.totalcount forKey:kCommentsModelTotalcount];
    [mutableDict setValue:self.totalcount0 forKey:kCommentsModelTotalcount0];
    [mutableDict setValue:self.totalcount2 forKey:kCommentsModelTotalcount2];

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

    self.comments = [aDecoder decodeObjectForKey:kCommentsModelComments];
    self.totalcount1 = [aDecoder decodeObjectForKey:kCommentsModelTotalcount1];
    self.totalpage = [aDecoder decodeObjectForKey:kCommentsModelTotalpage];
    self.totalcount3 = [aDecoder decodeObjectForKey:kCommentsModelTotalcount3];
    self.totalcount = [aDecoder decodeObjectForKey:kCommentsModelTotalcount];
    self.totalcount0 = [aDecoder decodeObjectForKey:kCommentsModelTotalcount0];
    self.totalcount2 = [aDecoder decodeObjectForKey:kCommentsModelTotalcount2];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_comments forKey:kCommentsModelComments];
    [aCoder encodeObject:_totalcount1 forKey:kCommentsModelTotalcount1];
    [aCoder encodeObject:_totalpage forKey:kCommentsModelTotalpage];
    [aCoder encodeObject:_totalcount3 forKey:kCommentsModelTotalcount3];
    [aCoder encodeObject:_totalcount forKey:kCommentsModelTotalcount];
    [aCoder encodeObject:_totalcount0 forKey:kCommentsModelTotalcount0];
    [aCoder encodeObject:_totalcount2 forKey:kCommentsModelTotalcount2];
}

- (id)copyWithZone:(NSZone *)zone
{
    CommentsModel *copy = [[CommentsModel alloc] init];
    
    if (copy) {

        copy.comments = [self.comments copyWithZone:zone];
        copy.totalcount1 = [self.totalcount1 copyWithZone:zone];
        copy.totalpage = [self.totalpage copyWithZone:zone];
        copy.totalcount3 = [self.totalcount3 copyWithZone:zone];
        copy.totalcount = [self.totalcount copyWithZone:zone];
        copy.totalcount0 = [self.totalcount0 copyWithZone:zone];
        copy.totalcount2 = [self.totalcount2 copyWithZone:zone];
    }
    
    return copy;
}


@end
