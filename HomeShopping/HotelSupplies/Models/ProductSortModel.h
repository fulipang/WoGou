//
//  ProductSortModel.h
//
//  Created by sooncong  on 16/1/5
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ProductSortModel : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSArray *productbrands;
@property (nonatomic, strong) NSArray *coinreturns;
@property (nonatomic, strong) NSArray *prices;
@property (nonatomic, strong) NSArray *coinprices;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
