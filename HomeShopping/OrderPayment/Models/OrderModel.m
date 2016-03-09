//
//  OrderModel.m
//  HomeShopping
//
//  Created by pfl on 16/1/14.
//  Copyright © 2016年 Administrator. All rights reserved.
//

#import "OrderModel.h"

@implementation OrderModel

+ (void)sendRequestForPrepareWeixinPaySuccessedHandler:(void (^)(BOOL, NSString *, NSString *))successedHandler {
    
    [WTRequestCenter postWithURL:nil parameters:nil finished:^(NSURLResponse *response, NSData *data) {
        
    } failed:^(NSURLResponse *response, NSError *error) {
        
    }];
    
    
}



@end
