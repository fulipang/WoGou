//
//  CollectionModelParser.h
//
//  Created by sooncong  on 16/1/17
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CollectionModel.h"

@class CollectionModel;

@interface CollectionModelParser : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) CollectionModel *collectionModel;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
