//
//  HShotelSuppliesModelParser.h
//
//  Created by sooncong  on 15/12/22
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HSHotelSuppliesModel.h"

@class HSHotelSuppliesModel;

@interface HShotelSuppliesModelParser : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) HSHotelSuppliesModel *hotelSuppliesModel;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
