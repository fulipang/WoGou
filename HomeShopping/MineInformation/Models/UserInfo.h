//
//  UserInfo.h
//
//  Created by sooncong  on 16/1/19
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface UserInfo : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *userid;
@property (nonatomic, strong) NSString *isrz;
@property (nonatomic, strong) NSString *coints;
@property (nonatomic, strong) NSString *nickname;
@property (nonatomic, strong) NSString *ut;
@property (nonatomic, strong) NSString *uname;
@property (nonatomic, strong) NSString *telephone;
@property (nonatomic, strong) NSString *logo;
@property (nonatomic, strong) NSString *sex;
@property (nonatomic, strong) NSString *birthdate;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
