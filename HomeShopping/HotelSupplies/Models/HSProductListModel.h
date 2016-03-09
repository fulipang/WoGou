//
//  HSProductListModel.h
//
//  Created by sooncong  on 15/12/24
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface HSProductListModel : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *totalcount;
@property (nonatomic, strong) NSArray *product;
@property (nonatomic, strong) NSArray *topadvs;
@property (nonatomic, strong) NSString *totalpage;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
