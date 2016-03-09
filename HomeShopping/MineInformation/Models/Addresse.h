//
//  Addresse.h
//
//  Created by sooncong  on 16/1/18
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface Addresse : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *isdefault;
@property (nonatomic, strong) NSString *area;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *consigneeaddress;
@property (nonatomic, strong) NSString *pca;
@property (nonatomic, strong) NSString *consigneephone;
/**
 *  收件人姓名
 */
@property (nonatomic, strong) NSString *consignee;
@property (nonatomic, strong) NSString *postcode;
@property (nonatomic, strong) NSString *addressid;
@property (nonatomic, strong) NSString *province;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
