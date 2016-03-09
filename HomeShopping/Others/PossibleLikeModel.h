//
//  PossibleLikeModel.h
//
//  Created by sooncong  on 16/1/20
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface PossibleLikeModel : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSArray *possibleLike;
@property (nonatomic, strong) NSArray *hotellikes;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
