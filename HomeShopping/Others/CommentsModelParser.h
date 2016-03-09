//
//  CommentsModelParser.h
//
//  Created by sooncong  on 16/1/15
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CommentsModel.h"

@class CommentsModel;

@interface CommentsModelParser : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) CommentsModel *commentsModel;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
