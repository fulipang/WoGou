//
//  UserInfoParser.h
//
//  Created by sooncong  on 16/1/16
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserInfo.h"

@class UserInfo;

@interface UserInfoParser : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) UserInfo *userInfo;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
