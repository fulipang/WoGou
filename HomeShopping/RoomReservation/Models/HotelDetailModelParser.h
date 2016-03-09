//
//  HotelDetailModelParser.h
//
//  Created by sooncong  on 16/1/20
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HotelDetailModel.h"

@class HotelDetailModel;

@interface HotelDetailModelParser : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) HotelDetailModel *hotelDetailModel;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
