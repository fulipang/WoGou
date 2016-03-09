//
//  CityModels.h
//
//  Created by sooncong  on 16/1/15
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface CityModels : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSArray *cityModel;
@property (nonatomic, strong) NSString *totalpage;
@property (nonatomic, strong) NSString *totalcount;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
