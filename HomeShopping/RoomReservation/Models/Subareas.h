//
//  Subareas.h
//
//  Created by sooncong  on 16/1/4
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface Subareas : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *subisleaf;
@property (nonatomic, strong) NSString *subparentid;
@property (nonatomic, strong) NSString *subtitle;
@property (nonatomic, strong) NSString *subareaid;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
