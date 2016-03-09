//
//  Coinreturns.h
//
//  Created by sooncong  on 16/1/5
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface Coinreturns : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *coinreturnmin;
@property (nonatomic, strong) NSString *coinreturnmax;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
