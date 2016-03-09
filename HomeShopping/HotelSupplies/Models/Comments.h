//
//  Comments.h
//
//  Created by sooncong  on 16/1/15
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface Comments : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *reback;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *commentlevel;
@property (nonatomic, strong) NSString *commenter;
@property (nonatomic, strong) NSString *remarkstars;
@property (nonatomic, strong) NSString *commentid;
@property (nonatomic, strong) NSString *comlogo;
@property (nonatomic, strong) NSString *commenttime;
@property (nonatomic, strong) NSString *kfstars;
@property (nonatomic, strong) NSString *sellername;
@property (nonatomic, strong) NSArray *comimagelist;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
