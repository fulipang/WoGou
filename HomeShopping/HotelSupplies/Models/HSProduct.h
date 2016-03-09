//
//  HSProduct.h
//
//  Created by sooncong  on 15/12/24
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface HSProduct : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *turnover;
@property (nonatomic, strong) NSString *productid;
@property (nonatomic, strong) NSString *sellername;
@property (nonatomic, strong) NSString *producttype;
@property (nonatomic, strong) NSString *starlevel;
@property (nonatomic, strong) NSString *cityname;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *logo;
@property (nonatomic, strong) NSString *citycode;
@property (nonatomic, strong) NSString *coinreturn;
@property (nonatomic, strong) NSString *sellerid;
@property (nonatomic, strong) NSString *isspecial;
@property (nonatomic, strong) NSString *distance;
@property (nonatomic, strong) NSString *isneedbook;
@property (nonatomic, strong) NSString *coinprice;
@property (nonatomic, strong) NSString *score;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
