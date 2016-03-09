//
//  AddressModel.h
//
//  Created by sooncong  on 16/1/18
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface AddressModel : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSArray *product;
@property (nonatomic, strong) NSArray *freights;
@property (nonatomic, strong) NSArray *addresse;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
