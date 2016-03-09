//
//  CityModelsParser.h
//
//  Created by sooncong  on 16/1/15
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CityModels.h"

@class CityModels;

@interface CityModelsParser : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) CityModels *cityModels;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
