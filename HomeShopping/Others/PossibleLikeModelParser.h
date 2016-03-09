//
//  PossibleLikeModelParser.h
//
//  Created by sooncong  on 16/1/15
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PossibleLikeModel.h"

@class PossibleLikeModel;

@interface PossibleLikeModelParser : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) PossibleLikeModel *possibleLikeModel;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
