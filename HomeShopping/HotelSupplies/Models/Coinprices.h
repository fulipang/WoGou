//
//  Coinprices.h
//
//  Created by sooncong  on 16/1/5
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface Coinprices : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *coinpricemin;
@property (nonatomic, strong) NSString *coinpricemax;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
