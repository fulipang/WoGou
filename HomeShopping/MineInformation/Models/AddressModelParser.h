//
//  AddressModelParser.h
//
//  Created by sooncong  on 16/1/18
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AddressModel.h"

@class AddressModel;

@interface AddressModelParser : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) AddressModel *addressModel;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
