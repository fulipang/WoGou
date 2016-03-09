//
//  ProductDetailModel.h
//
//  Created by sooncong  on 15/12/30
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ProductDetail;

@interface ProductDetailModel : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) ProductDetail *productDetail;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
