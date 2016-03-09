//
//  ProductSortModelParser.h
//
//  Created by sooncong  on 16/1/5
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProductSortModel.h"

@class ProductSortModel;

@interface ProductSortModelParser : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) ProductSortModel *productSortModel;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
