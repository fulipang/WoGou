//
//  CommentsModel.h
//
//  Created by sooncong  on 16/1/15
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface CommentsModel : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSArray *comments;
@property (nonatomic, strong) NSString *totalcount1;
@property (nonatomic, strong) NSString *totalpage;
@property (nonatomic, strong) NSString *totalcount3;
@property (nonatomic, strong) NSString *totalcount;
@property (nonatomic, strong) NSString *totalcount0;
@property (nonatomic, strong) NSString *totalcount2;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
