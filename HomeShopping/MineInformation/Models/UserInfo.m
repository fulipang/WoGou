//
//  UserInfo.m
//
//  Created by sooncong  on 16/1/19
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "UserInfo.h"


NSString *const kUserInfoUserid = @"userid";
NSString *const kUserInfoIsrz = @"isrz";
NSString *const kUserInfoCoints = @"coints";
NSString *const kUserInfoNickname = @"nickname";
NSString *const kUserInfoUt = @"ut";
NSString *const kUserInfoUname = @"uname";
NSString *const kUserInfoTelephone = @"telephone";
NSString *const kUserInfoLogo = @"logo";
NSString *const kUserInfoSex = @"sex";
NSString *const kUserInfoBirthdate = @"borndate";


@interface UserInfo ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation UserInfo

@synthesize userid = _userid;
@synthesize isrz = _isrz;
@synthesize coints = _coints;
@synthesize nickname = _nickname;
@synthesize ut = _ut;
@synthesize uname = _uname;
@synthesize telephone = _telephone;
@synthesize logo = _logo;
@synthesize sex = _sex;
@synthesize birthdate = _birthdate;

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
        self.userid = [self objectOrNilForKey:kUserInfoUserid fromDictionary:dict];
        self.isrz = [self objectOrNilForKey:kUserInfoIsrz fromDictionary:dict];
        self.coints = [self objectOrNilForKey:kUserInfoCoints fromDictionary:dict];
        self.nickname = [self objectOrNilForKey:kUserInfoNickname fromDictionary:dict];
        self.ut = [self objectOrNilForKey:kUserInfoUt fromDictionary:dict];
        self.uname = [self objectOrNilForKey:kUserInfoUname fromDictionary:dict];
        self.telephone = [self objectOrNilForKey:kUserInfoTelephone fromDictionary:dict];
        self.logo = [self objectOrNilForKey:kUserInfoLogo fromDictionary:dict];
        self.sex = [self objectOrNilForKey:kUserInfoSex fromDictionary:dict];
        self.birthdate = [self objectOrNilForKey:kUserInfoBirthdate fromDictionary:dict];
        
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.userid forKey:kUserInfoUserid];
    [mutableDict setValue:self.isrz forKey:kUserInfoIsrz];
    [mutableDict setValue:self.coints forKey:kUserInfoCoints];
    [mutableDict setValue:self.nickname forKey:kUserInfoNickname];
    [mutableDict setValue:self.ut forKey:kUserInfoUt];
    [mutableDict setValue:self.uname forKey:kUserInfoUname];
    [mutableDict setValue:self.telephone forKey:kUserInfoTelephone];
    [mutableDict setValue:self.logo forKey:kUserInfoLogo];
    [mutableDict setValue:self.sex forKey:kUserInfoSex];
    [mutableDict setValue:self.birthdate forKey:kUserInfoBirthdate];
    
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
    
    self.userid = [aDecoder decodeObjectForKey:kUserInfoUserid];
    self.isrz = [aDecoder decodeObjectForKey:kUserInfoIsrz];
    self.coints = [aDecoder decodeObjectForKey:kUserInfoCoints];
    self.nickname = [aDecoder decodeObjectForKey:kUserInfoNickname];
    self.ut = [aDecoder decodeObjectForKey:kUserInfoUt];
    self.uname = [aDecoder decodeObjectForKey:kUserInfoUname];
    self.telephone = [aDecoder decodeObjectForKey:kUserInfoTelephone];
    self.logo = [aDecoder decodeObjectForKey:kUserInfoLogo];
    self.sex = [aDecoder decodeObjectForKey:kUserInfoSex];
    self.birthdate = [aDecoder decodeObjectForKey:kUserInfoBirthdate];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
    [aCoder encodeObject:_userid forKey:kUserInfoUserid];
    [aCoder encodeObject:_isrz forKey:kUserInfoIsrz];
    [aCoder encodeObject:_coints forKey:kUserInfoCoints];
    [aCoder encodeObject:_nickname forKey:kUserInfoNickname];
    [aCoder encodeObject:_ut forKey:kUserInfoUt];
    [aCoder encodeObject:_uname forKey:kUserInfoUname];
    [aCoder encodeObject:_telephone forKey:kUserInfoTelephone];
    [aCoder encodeObject:_logo forKey:kUserInfoLogo];
    [aCoder encodeObject:_sex forKey:kUserInfoSex];
    [aCoder encodeObject:_birthdate forKey:kUserInfoBirthdate];
}

- (id)copyWithZone:(NSZone *)zone
{
    UserInfo *copy = [[UserInfo alloc] init];
    
    if (copy) {
        
        copy.userid = [self.userid copyWithZone:zone];
        copy.isrz = [self.isrz copyWithZone:zone];
        copy.coints = [self.coints copyWithZone:zone];
        copy.nickname = [self.nickname copyWithZone:zone];
        copy.ut = [self.ut copyWithZone:zone];
        copy.uname = [self.uname copyWithZone:zone];
        copy.telephone = [self.telephone copyWithZone:zone];
        copy.logo = [self.logo copyWithZone:zone];
        copy.sex = [self.sex copyWithZone:zone];
        copy.birthdate = [self.birthdate copyWithZone:zone];
    }
    
    return copy;
}


@end
