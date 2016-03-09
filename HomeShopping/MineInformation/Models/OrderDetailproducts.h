//
//  OrderDetailproducts.h
//
//  Created by sooncong  on 16/1/23
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface OrderDetailproducts : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *shortintro;
@property (nonatomic, strong) NSString *orderproductcode;
@property (nonatomic, strong) NSString *producttype;
@property (nonatomic, strong) NSString *buycount;
@property (nonatomic, strong) NSString *normtitle;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *indate;
@property (nonatomic, strong) NSString *outdate;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSString *logo;
@property (nonatomic, strong) NSString *coinreturn;
@property (nonatomic, strong) NSArray *coupons;
@property (nonatomic, strong) NSString *coinprice;
@property (nonatomic, strong) NSString *isspecial;
@property (nonatomic, strong) NSString *productid;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
