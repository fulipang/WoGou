//
//  ShoppingCarModelParser.h
//
//  Created by sooncong  on 16/1/19
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ShoppingCarModel.h"

@class ShoppingCarModel;

@interface ShoppingCarModelParser : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) ShoppingCarModel *shoppingCarModel;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
