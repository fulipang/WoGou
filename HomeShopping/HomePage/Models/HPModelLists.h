//
//  HPModelLists.h
//
//  Created by sooncong  on 15/12/19
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface HPModelLists : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSArray *possibleLikeModel;
@property (nonatomic, strong) NSArray *categorysModel;
@property (nonatomic, strong) NSArray *addsModel;
@property (nonatomic, strong) NSArray *starlevel;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
