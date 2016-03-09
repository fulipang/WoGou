//
//  HPCategorysModel.h
//
//  Created by sooncong  on 15/12/19
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface HPCategorysModel : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *categoryid;
@property (nonatomic, strong) NSString *producttype;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *parentid;
@property (nonatomic, strong) NSString *logo;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
