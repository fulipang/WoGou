//
//  Comments.m
//
//  Created by sooncong  on 16/1/15
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "Comments.h"


NSString *const kCommentsReback = @"reback";
NSString *const kCommentsContent = @"content";
NSString *const kCommentsCommentlevel = @"commentlevel";
NSString *const kCommentsCommenter = @"commenter";
NSString *const kCommentsRemarkstars = @"remarkstars";
NSString *const kCommentsCommentid = @"commentid";
NSString *const kCommentsComlogo = @"comlogo";
NSString *const kCommentsCommenttime = @"commenttime";
NSString *const kCommentsKfstars = @"kfstars";
NSString *const kCommentsSellername = @"sellername";
NSString *const kCommentsComimagelist = @"comimagelist";


@interface Comments ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation Comments

@synthesize reback = _reback;
@synthesize content = _content;
@synthesize commentlevel = _commentlevel;
@synthesize commenter = _commenter;
@synthesize remarkstars = _remarkstars;
@synthesize commentid = _commentid;
@synthesize comlogo = _comlogo;
@synthesize commenttime = _commenttime;
@synthesize kfstars = _kfstars;
@synthesize sellername = _sellername;
@synthesize comimagelist = _comimagelist;


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
            self.reback = [self objectOrNilForKey:kCommentsReback fromDictionary:dict];
            self.content = [self objectOrNilForKey:kCommentsContent fromDictionary:dict];
            self.commentlevel = [self objectOrNilForKey:kCommentsCommentlevel fromDictionary:dict];
            self.commenter = [self objectOrNilForKey:kCommentsCommenter fromDictionary:dict];
            self.remarkstars = [self objectOrNilForKey:kCommentsRemarkstars fromDictionary:dict];
            self.commentid = [self objectOrNilForKey:kCommentsCommentid fromDictionary:dict];
            self.comlogo = [self objectOrNilForKey:kCommentsComlogo fromDictionary:dict];
            self.commenttime = [self objectOrNilForKey:kCommentsCommenttime fromDictionary:dict];
            self.kfstars = [self objectOrNilForKey:kCommentsKfstars fromDictionary:dict];
            self.sellername = [self objectOrNilForKey:kCommentsSellername fromDictionary:dict];
            self.comimagelist = [self objectOrNilForKey:kCommentsComimagelist fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.reback forKey:kCommentsReback];
    [mutableDict setValue:self.content forKey:kCommentsContent];
    [mutableDict setValue:self.commentlevel forKey:kCommentsCommentlevel];
    [mutableDict setValue:self.commenter forKey:kCommentsCommenter];
    [mutableDict setValue:self.remarkstars forKey:kCommentsRemarkstars];
    [mutableDict setValue:self.commentid forKey:kCommentsCommentid];
    [mutableDict setValue:self.comlogo forKey:kCommentsComlogo];
    [mutableDict setValue:self.commenttime forKey:kCommentsCommenttime];
    [mutableDict setValue:self.kfstars forKey:kCommentsKfstars];
    [mutableDict setValue:self.sellername forKey:kCommentsSellername];
    NSMutableArray *tempArrayForComimagelist = [NSMutableArray array];
    for (NSObject *subArrayObject in self.comimagelist) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForComimagelist addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForComimagelist addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForComimagelist] forKey:kCommentsComimagelist];

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

    self.reback = [aDecoder decodeObjectForKey:kCommentsReback];
    self.content = [aDecoder decodeObjectForKey:kCommentsContent];
    self.commentlevel = [aDecoder decodeObjectForKey:kCommentsCommentlevel];
    self.commenter = [aDecoder decodeObjectForKey:kCommentsCommenter];
    self.remarkstars = [aDecoder decodeObjectForKey:kCommentsRemarkstars];
    self.commentid = [aDecoder decodeObjectForKey:kCommentsCommentid];
    self.comlogo = [aDecoder decodeObjectForKey:kCommentsComlogo];
    self.commenttime = [aDecoder decodeObjectForKey:kCommentsCommenttime];
    self.kfstars = [aDecoder decodeObjectForKey:kCommentsKfstars];
    self.sellername = [aDecoder decodeObjectForKey:kCommentsSellername];
    self.comimagelist = [aDecoder decodeObjectForKey:kCommentsComimagelist];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_reback forKey:kCommentsReback];
    [aCoder encodeObject:_content forKey:kCommentsContent];
    [aCoder encodeObject:_commentlevel forKey:kCommentsCommentlevel];
    [aCoder encodeObject:_commenter forKey:kCommentsCommenter];
    [aCoder encodeObject:_remarkstars forKey:kCommentsRemarkstars];
    [aCoder encodeObject:_commentid forKey:kCommentsCommentid];
    [aCoder encodeObject:_comlogo forKey:kCommentsComlogo];
    [aCoder encodeObject:_commenttime forKey:kCommentsCommenttime];
    [aCoder encodeObject:_kfstars forKey:kCommentsKfstars];
    [aCoder encodeObject:_sellername forKey:kCommentsSellername];
    [aCoder encodeObject:_comimagelist forKey:kCommentsComimagelist];
}

- (id)copyWithZone:(NSZone *)zone
{
    Comments *copy = [[Comments alloc] init];
    
    if (copy) {

        copy.reback = [self.reback copyWithZone:zone];
        copy.content = [self.content copyWithZone:zone];
        copy.commentlevel = [self.commentlevel copyWithZone:zone];
        copy.commenter = [self.commenter copyWithZone:zone];
        copy.remarkstars = [self.remarkstars copyWithZone:zone];
        copy.commentid = [self.commentid copyWithZone:zone];
        copy.comlogo = [self.comlogo copyWithZone:zone];
        copy.commenttime = [self.commenttime copyWithZone:zone];
        copy.kfstars = [self.kfstars copyWithZone:zone];
        copy.sellername = [self.sellername copyWithZone:zone];
        copy.comimagelist = [self.comimagelist copyWithZone:zone];
    }
    
    return copy;
}


@end
