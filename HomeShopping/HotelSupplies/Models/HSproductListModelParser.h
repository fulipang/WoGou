//
//  HSproductListModelParser.h
//
//  Created by sooncong  on 15/12/24
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HSProductListModel.h"

@class HSProductListModel;

@interface HSproductListModelParser : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) HSProductListModel *productListModel;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
