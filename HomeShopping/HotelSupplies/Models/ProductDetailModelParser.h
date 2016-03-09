//
//  ProductDetailModelParser.h
//
//  Created by sooncong  on 15/12/30
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProductDetailModel.h"

@class ProductDetailModel;

@interface ProductDetailModelParser : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) ProductDetailModel *productDetailModel;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
