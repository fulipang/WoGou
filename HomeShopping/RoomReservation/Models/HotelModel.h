//
//  HotelModel.h
//
//  Created by sooncong  on 16/1/18
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface HotelModel : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *totalcount;
@property (nonatomic, strong) NSArray *hotels;
@property (nonatomic, strong) NSArray *topadvs;
@property (nonatomic, strong) NSString *totalpage;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
