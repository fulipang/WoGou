//
//  ProductDetail.h
//
//  Created by sooncong  on 15/12/31
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ProductDetail : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *coinreturn;
@property (nonatomic, strong) NSString *ishavetv;
@property (nonatomic, strong) NSString *coordinatey;
@property (nonatomic, strong) NSString *logo;
@property (nonatomic, strong) NSString *coordinatex;
@property (nonatomic, strong) NSString *ishaveac;
@property (nonatomic, strong) NSString *ishavepc;
@property (nonatomic, strong) NSArray *comments;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *ishavewifi;
@property (nonatomic, strong) NSString *productid;
@property (nonatomic, strong) NSString *score;
@property (nonatomic, strong) NSString *sellername;
@property (nonatomic, strong) NSString *cityname;
@property (nonatomic, strong) NSString *isneedbook;
@property (nonatomic, strong) NSString *turnover;
@property (nonatomic, strong) NSString *distance;
@property (nonatomic, strong) NSString *sellerlogo;
@property (nonatomic, strong) NSString *commentcount;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSString *producttype;
@property (nonatomic, strong) NSString *normintro;
@property (nonatomic, strong) NSArray *imagelist;
@property (nonatomic, strong) NSString *servicephone;
@property (nonatomic, strong) NSArray *norms;
@property (nonatomic, strong) NSString *coinprice;
@property (nonatomic, strong) NSString *citycode;
@property (nonatomic, strong) NSString *shortintro;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *starlevel;
@property (nonatomic, strong) NSString *packafserv;
@property (nonatomic, strong) NSString *isspecial;
@property (nonatomic, strong) NSString *sellerscore;
@property (nonatomic, strong) NSString *longintro;
@property (nonatomic, strong) NSString *sellerid;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
