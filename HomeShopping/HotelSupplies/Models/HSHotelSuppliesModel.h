//
//  HSHotelSuppliesModel.h
//
//  Created by sooncong  on 15/12/22
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface HSHotelSuppliesModel : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSArray *products;
@property (nonatomic, strong) NSArray *adsLists;
@property (nonatomic, strong) NSString *totalcount;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
