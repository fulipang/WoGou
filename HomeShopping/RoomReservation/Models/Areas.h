//
//  Areas.h
//
//  Created by sooncong  on 16/1/4
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface Areas : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *areaid;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *isleaf;
@property (nonatomic, strong) NSArray *subareas;
@property (nonatomic, strong) NSString *parentid;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
