//
//  CollectionHotelListModelParser.h
//
//  Created by sooncong  on 16/1/20
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CollectionHotelListModel.h"


@class CollectionHotelListModel;

@interface CollectionHotelListModelParser : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) CollectionHotelListModel *collectionHotelListModel;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
