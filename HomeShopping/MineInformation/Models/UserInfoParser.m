//
//  UserInfoParser.m
//
//  Created by sooncong  on 16/1/16
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "UserInfoParser.h"


NSString *const kUserInfoParserUserInfo = @"body";


@interface UserInfoParser ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation UserInfoParser

@synthesize userInfo = _userInfo;


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
            self.userInfo = [UserInfo modelObjectWithDictionary:[dict objectForKey:kUserInfoParserUserInfo]];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[self.userInfo dictionaryRepresentation] forKey:kUserInfoParserUserInfo];

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

    self.userInfo = [aDecoder decodeObjectForKey:kUserInfoParserUserInfo];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_userInfo forKey:kUserInfoParserUserInfo];
}

- (id)copyWithZone:(NSZone *)zone
{
    UserInfoParser *copy = [[UserInfoParser alloc] init];
    
    if (copy) {

        copy.userInfo = [self.userInfo copyWithZone:zone];
    }
    
    return copy;
}


@end
