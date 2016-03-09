//
//  HotelModelParser.h
//
//  Created by sooncong  on 16/1/18
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HotelModel.h"

@class HotelModel;

@interface HotelModelParser : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) HotelModel *hotelModel;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
