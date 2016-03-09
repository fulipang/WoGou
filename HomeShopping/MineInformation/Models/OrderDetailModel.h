//
//  OrderDetailModel.h
//
//  Created by sooncong  on 16/1/23
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class OrderDetail;

@interface OrderDetailModel : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) OrderDetail *orderDetail;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
