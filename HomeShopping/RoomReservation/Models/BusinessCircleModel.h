//
//  BusinessCircleModel.h
//
//  Created by sooncong  on 16/1/4
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface BusinessCircleModel : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSArray *areas;
@property (nonatomic, strong) NSString *totalcount;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
