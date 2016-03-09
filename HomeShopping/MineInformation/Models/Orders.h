//
//  Orders.h
//
//  Created by sooncong  on 16/1/21
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface Orders : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *backcoints;
@property (nonatomic, strong) NSString *ordernum;
@property (nonatomic, strong) NSString *cost;
@property (nonatomic, strong) NSString *usecoints;
@property (nonatomic, strong) NSString *producttype;
@property (nonatomic, strong) NSString *sellerid;
@property (nonatomic, strong) NSString *sellername;
@property (nonatomic, strong) NSString *orderid;
@property (nonatomic, strong) NSString *borndate;
@property (nonatomic, strong) NSArray *products;
@property (nonatomic, strong) NSString *sellerlogo;
@property (nonatomic, strong) NSString *prepayid;
@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) NSString *productcount;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
