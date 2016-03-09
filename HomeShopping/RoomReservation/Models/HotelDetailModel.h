//
//  HotelDetailModel.h
//
//  Created by sooncong  on 16/1/20
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface HotelDetailModel : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *cityname;
@property (nonatomic, strong) NSString *coinprice;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *starlevel;
@property (nonatomic, strong) NSString *ishotel;
@property (nonatomic, strong) NSString *score;
@property (nonatomic, strong) NSString *sellername;
@property (nonatomic, strong) NSString *sellerintro;
@property (nonatomic, strong) NSString *sellerlogo;
@property (nonatomic, strong) NSString *sellerscore;
@property (nonatomic, strong) NSString *isneedbook;
@property (nonatomic, strong) NSString *turnover;
@property (nonatomic, strong) NSString *distance;
@property (nonatomic, strong) NSString *coordinatey;
@property (nonatomic, strong) NSString *coordinatex;
@property (nonatomic, strong) NSString *sellerid;
@property (nonatomic, strong) NSString *logo;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSString *citycode;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *coinreturn;
@property (nonatomic, strong) NSString *servicephone;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
