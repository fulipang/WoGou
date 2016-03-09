//
//  HPAddsModel.h
//
//  Created by sooncong  on 15/12/19
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface HPAddsModel : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *linktype;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *linkcontent;
@property (nonatomic, strong) NSString *logo;
@property (nonatomic, strong) NSString *producttype;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
