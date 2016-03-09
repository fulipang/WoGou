//
//  OrderDetailModelParser.h
//
//  Created by sooncong  on 16/1/23
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OrderDetailModel.h"

@class OrderDetailModel;

@interface OrderDetailModelParser : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) OrderDetailModel *orderDetailModel;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
