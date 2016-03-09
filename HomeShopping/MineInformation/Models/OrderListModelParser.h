//
//  OrderListModelParser.h
//
//  Created by sooncong  on 16/1/21
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class OrderListModel;
#import "OrderListModel.h"

@interface OrderListModelParser : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) OrderListModel *orderListModel;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
