//
//  Address.h
//
//  Created by sooncong  on 16/1/23
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface Address : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *addressid;
@property (nonatomic, strong) NSString *consigneephone;
@property (nonatomic, strong) NSString *consigneeaddress;
@property (nonatomic, strong) NSString *pca;
@property (nonatomic, strong) NSString *consignee;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
