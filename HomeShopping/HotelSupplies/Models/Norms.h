//
//  Norms.h
//
//  Created by sooncong  on 16/1/15
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface Norms : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *normid;
@property (nonatomic, strong) NSString *normtitle;
@property (nonatomic, strong) NSArray *normimagelist;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
