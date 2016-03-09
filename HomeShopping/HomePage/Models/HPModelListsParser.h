//
//  HPModelListsParser.h
//
//  Created by sooncong  on 15/12/19
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HPModelLists.h"

@class HPModelLists;

@interface HPModelListsParser : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) HPModelLists *modelLists;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
