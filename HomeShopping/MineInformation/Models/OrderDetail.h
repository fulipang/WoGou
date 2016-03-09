//
//  OrderDetail.h
//
//  Created by sooncong  on 16/1/23
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Address;

@interface OrderDetail : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *paytime;
@property (nonatomic, strong) NSString *ordernum;
@property (nonatomic, strong) NSString *discount;
@property (nonatomic, strong) NSString *paytype;
@property (nonatomic, strong) NSString *backcoints;
@property (nonatomic, strong) NSString *usecoints;
@property (nonatomic, strong) NSString *productcount;
@property (nonatomic, strong) NSString *sellerid;
@property (nonatomic, strong) NSString *sellername;
@property (nonatomic, strong) NSString *orderid;
@property (nonatomic, strong) NSString *borndate;
@property (nonatomic, strong) Address *address;
@property (nonatomic, strong) NSArray *orderDetailproducts;
@property (nonatomic, strong) NSString *totalcost;
@property (nonatomic, strong) NSString *sellerlogo;
@property (nonatomic, strong) NSString *iscomment;
@property (nonatomic, strong) NSString *prepayid;
@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) NSString *cost;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
