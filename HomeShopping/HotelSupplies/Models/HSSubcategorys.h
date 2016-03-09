//
//  HSSubcategorys.h
//
//  Created by sooncong  on 15/12/22
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HSSubcategory;

@interface HSSubcategorys : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *subparentid;
@property (nonatomic, strong) NSString *subtitle;
@property (nonatomic, strong) NSString *producttype;
@property (nonatomic, strong) NSString *subcategoryid;
@property (nonatomic, strong) NSString *subcategorylogo;
@property (nonatomic, strong) NSString *subisleaf;
@property (nonatomic, strong) HSSubcategory *subcategory;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
