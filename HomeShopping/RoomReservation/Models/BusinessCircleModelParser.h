//
//  BusinessCircleModelParser.h
//
//  Created by sooncong  on 16/1/4
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BusinessCircleModel.h"

@interface BusinessCircleModelParser : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) BusinessCircleModel *businessCircleModel;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
