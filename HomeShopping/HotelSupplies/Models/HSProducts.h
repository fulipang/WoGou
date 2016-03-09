//
//  HSProducts.h
//
//  Created by sooncong  on 15/12/22
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface HSProducts : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *isleaf;
@property (nonatomic, strong) NSString *categorylogo;
@property (nonatomic, strong) NSString *parentid;
@property (nonatomic, strong) NSString *categoryid;
@property (nonatomic, strong) NSString *producttype;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSArray *subcategorys;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
