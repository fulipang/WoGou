//
//  NetWorkSingleton.m
//  HomeShopping
//
//  Created by sooncong on 15/12/14.
//  Copyright © 2015年 Administrator. All rights reserved.
//

#import "NetWorkSingleton.h"
#import "SCEnum.h"

NSString *const WeixinAppKey = @"wx0761b5dd04114882";
NSString *const WeixinAccount = @"mgjg8888@126.com";
NSString *const WeixinPassword = @"mgjg123";
NSString *const zhifubaoAccount = @"qhdazfb@163.com";
NSString *const zhifubaoPassword = @"da12345";
NSString *const zhifubaoPID = @"2088811229131974";
NSString *const zhifubaoRSA = @"MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDDI6d306Q8fIfCOaTXyiUeJHkrIvYISRcc73s3vF1ZT7XN8RNPwJxo8pWaJMmvyTn9N4HQ632qJBVHf8sxHi/fEsraprwCtzvzQETrNRwVxLO5jVmRGi60j8Ue1efIlzPXV9je9mkjzOmdssymZkh2QhUrCmZYI/FCEa3/cNMW0QIDAQAB";
NSString *const zhifubaoKEY = @"k328l92xx6xxjct3n90clrb5vinn456t";


@implementation NetWorkSingleton

+(NetWorkSingleton *)sharedManager{
    static NetWorkSingleton *sharedNetworkSingleton = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate,^{
        sharedNetworkSingleton = [[self alloc] init];
    });
    return sharedNetworkSingleton;
}

- (void)postWithHeadParameter:(NSDictionary *)headDic bodyParameter:(NSDictionary *)bodyDic SuccessBlock:(SuccessBlock)successBlock FailureBlock:(FailureBlock)failureBlock{
     NSMutableDictionary * parameter = [[NSMutableDictionary alloc] initWithCapacity:1];
    [parameter setObject:headDic forKey:@"head"];
    [parameter setObject:bodyDic forKey:@"body"];
    [self postWithParameter:parameter SuccessBlock:^(id responseBody) {
        if ([responseBody isKindOfClass:[NSDictionary class]]) {
            successBlock(responseBody);
        }else{
            failureBlock(@"数据解析失败");
        }
    } FailureBlock:^(NSString *error) {
        failureBlock(error);
    }];
}

-(void)postWithParameter:(NSDictionary *)parameter SuccessBlock:(SuccessBlock)successBlock FailureBlock:(FailureBlock)failureBlock{
    
    NSMutableDictionary * parameters = [self addEssentialParametersWithDictionary:parameter];
    
    [WTRequestCenter postWithURL:HOST_IP parameters:parameters finished:^(NSURLResponse *response, NSData *data) {
        
        NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
//        NSLog(@"json = %@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
        
        NSString * str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        if ([resultDic isKindOfClass:[NSDictionary class]]) {
            successBlock(resultDic);
        }else{
            failureBlock(@"数据解析失败");
        }
    } failed:^(NSURLResponse *response, NSError *error) {
        NSString *errorStr = [error.userInfo objectForKey:@"NSLocalizedDescription"];
        failureBlock(errorStr);
    }];
}

- (NSString *)getFormaterTime
{
    NSDate * timeDate=[NSDate date];
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [dateformatter setLocale:[NSLocale currentLocale]];
    
    NSString *  locationString=[dateformatter stringFromDate:timeDate];
    
    return locationString;
}

- (NSMutableDictionary *)addEssentialParametersWithDictionary:(NSDictionary *)parameter
{
    NSMutableDictionary * dictionaryM = [NSMutableDictionary dictionaryWithDictionary:parameter];
    NSMutableDictionary * headDic = [dictionaryM objectForKey:@"head"];
    
    [headDic setObject:@"2" forKey:@"clienttype"];
    [headDic setObject:[[NetWorkSingleton sharedManager] getFormaterTime] forKey:@"tranid"];
    [headDic setObject:@"2" forKey:@"os"];
    [headDic setObject:VERSION forKey:@"clientversion"];
    
    return dictionaryM;
}

#pragma mark - 通用请求

-(void)getConfirmCodeWithTelNumber:(NSString *)telNumber ConfirmCodeType:(ConfirmCodeType)confirmCodetype SuccessBlock:(SuccessBlock)successBlock FailureBlock:(FailureBlock)failureBlock
{
    
    NSMutableDictionary * headDic = [[NSMutableDictionary alloc] initWithCapacity:1];
    NSMutableDictionary * bodyDic = [[NSMutableDictionary alloc] initWithCapacity:1];
    [bodyDic setObject:@"getphonecode" forKey:@"functionid"];
    [bodyDic setObject:telNumber forKey:@"phone"];
    [bodyDic setObject:[NSString stringWithFormat:@"%ld",confirmCodetype] forKey:@"codetag"];
    
    NSMutableDictionary * parameter = [[NSMutableDictionary alloc] initWithCapacity:1];
    [parameter setObject:headDic forKey:@"head"];
    [parameter setObject:bodyDic forKey:@"body"];
    [self postWithParameter:parameter SuccessBlock:^(id responseBody) {
        if ([responseBody isKindOfClass:[NSDictionary class]]) {
            successBlock(responseBody);
        }else{
            failureBlock(@"数据解析失败");
        }
    } FailureBlock:^(NSString *error) {
        failureBlock(error);
    }];
}

-(void)getBackPassWordWithPhoneNumber:(NSString *)phoneNumber ConfirmCode:(NSString *)confirmCode NewPassWord:(NSString *)newPassWord SuccessBlock:(SuccessBlock)successBlock FailureBlock:(FailureBlock)failureBlock
{
    NSMutableDictionary * headDic = [[NSMutableDictionary alloc] initWithCapacity:1];
    NSMutableDictionary * bodyDic = [[NSMutableDictionary alloc] initWithCapacity:1];
    [bodyDic setObject:@"findpassword" forKey:@"functionid"];
    [bodyDic setObject:phoneNumber forKey:@"phone"];
    [bodyDic setObject:confirmCode forKey:@"code"];
    [bodyDic setObject:newPassWord forKey:@"newpassword"];
    
    NSMutableDictionary * parameter = [[NSMutableDictionary alloc] initWithCapacity:1];
    [parameter setObject:headDic forKey:@"head"];
    [parameter setObject:bodyDic forKey:@"body"];
    [self postWithParameter:parameter SuccessBlock:^(id responseBody) {
        if ([responseBody isKindOfClass:[NSDictionary class]]) {
            successBlock(responseBody);
        }else{
            failureBlock(@"数据解析失败");
        }
    } FailureBlock:^(NSString *error) {
        failureBlock(error);
    }];
}

-(void)registerUserWithPhoneNumber:(NSString *)phoneNumber ConfirmCode:(NSString *)confirmCode PassWord:(NSString *)passWord SuccessBlock:(SuccessBlock)successBlock FailureBlock:(FailureBlock)failureBlock
{
    NSMutableDictionary * headDic = [[NSMutableDictionary alloc] initWithCapacity:1];
    NSMutableDictionary * bodyDic = [[NSMutableDictionary alloc] initWithCapacity:1];
    [bodyDic setObject:@"registphone" forKey:@"functionid"];
    [bodyDic setObject:phoneNumber forKey:@"phone"];
    [bodyDic setObject:confirmCode forKey:@"code"];
    [bodyDic setObject:passWord forKey:@"password"];
    
    NSMutableDictionary * parameter = [[NSMutableDictionary alloc] initWithCapacity:1];
    [parameter setObject:headDic forKey:@"head"];
    [parameter setObject:bodyDic forKey:@"body"];
    [self postWithParameter:parameter SuccessBlock:^(id responseBody) {
        if ([responseBody isKindOfClass:[NSDictionary class]]) {
            successBlock(responseBody);
        }else{
            failureBlock(@"数据解析失败");
        }
    } FailureBlock:^(NSString *error) {
        failureBlock(error);
    }];
}

-(void)LoginUserWithPhoneNumber:(NSString *)phoneNumber PassWord:(NSString *)passWord SuccessBlock:(SuccessBlock)successBlock FailureBlock:(FailureBlock)failureBlock
{
    NSMutableDictionary * headDic = [[NSMutableDictionary alloc] initWithCapacity:1];
    NSMutableDictionary * bodyDic = [[NSMutableDictionary alloc] initWithCapacity:1];
    [bodyDic setObject:@"sj_login" forKey:@"functionid"];
    [bodyDic setObject:phoneNumber forKey:@"account"];
    [bodyDic setObject:passWord forKey:@"password"];
    
    NSMutableDictionary * parameter = [[NSMutableDictionary alloc] initWithCapacity:1];
    [parameter setObject:headDic forKey:@"head"];
    [parameter setObject:bodyDic forKey:@"body"];
    [self postWithParameter:parameter SuccessBlock:^(id responseBody) {
        if ([responseBody isKindOfClass:[NSDictionary class]]) {
            successBlock(responseBody);
        }else{
            failureBlock(@"数据解析失败");
        }
    } FailureBlock:^(NSString *error) {
        failureBlock(error);
    }];
}

-(void)getReceivingGoodsAddressWhetherGetDefaultAddress:(BOOL)isGetDefaultAddr GetReight:(BOOL)isGetReight GetPayType:(BOOL)isGetPayType SuccessBlock:(SuccessBlock)successBlock FailureBlock:(FailureBlock)failureBlock
{
    
    if(![[Reachability reachabilityForInternetConnection]isReachable])
    {
        NSString *showMsg = @"请检查网络";
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"提示"
                                                        message: showMsg
                                                       delegate: self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles: nil, nil];
        
        [alert show];

        
        return;
    }
    
    [SVProgressHUD show];
    
    NSMutableDictionary * headDic = [[NSMutableDictionary alloc] initWithCapacity:1];
    NSMutableDictionary * bodyDic = [[NSMutableDictionary alloc] initWithCapacity:1];
    
    if ([[AppInformationSingleton shareAppInfomationSingleton] getLoginCode]) {
        [headDic setObject:[[AppInformationSingleton shareAppInfomationSingleton] getLoginCode] forKey:@"ut"];
        [headDic setObject:[[AppInformationSingleton shareAppInfomationSingleton] getUserID] forKey:@"userid"];
    }
    
    
    [bodyDic setObject:@"shaddresslist" forKey:@"functionid"];
 
    if (isGetDefaultAddr == YES) {
        [bodyDic setObject:@"1" forKey:@"getdefault"];
    }
    
    if (isGetReight == YES) {
        [bodyDic setObject:@"1" forKey:@"getfreight"];
    }
    
    if (isGetPayType == YES) {
        [bodyDic setObject:@"1" forKey:@"getpaytype"];
    }
    
    NSMutableDictionary * parameter = [[NSMutableDictionary alloc] initWithCapacity:1];
    [parameter setObject:headDic forKey:@"head"];
    [parameter setObject:bodyDic forKey:@"body"];
    [self postWithParameter:parameter SuccessBlock:^(id responseBody) {
        if ([responseBody isKindOfClass:[NSDictionary class]]) {
            successBlock(responseBody);
            [SVProgressHUD dismissWithSuccess:@"加载成功" afterDelay:1];
        }
    } FailureBlock:^(NSString *error) {
        
        [SVProgressHUD dismissWithError:error afterDelay:1];
    }];
}

-(void)deleteReceivingGoodsAddressWithID:(NSString *)addressID SuccessBlock:(SuccessBlock)successBlock FailureBlock:(FailureBlock)failureBlock
{
    if(![[Reachability reachabilityForInternetConnection]isReachable])
    {
        NSString *showMsg = @"请检查网络";
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"提示"
                                                        message: showMsg
                                                       delegate: self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles: nil, nil];
        
        [alert show];
        
        
        return;
    }
    
    [SVProgressHUD show];
    
    NSMutableDictionary * headDic = [[NSMutableDictionary alloc] initWithCapacity:1];
    NSMutableDictionary * bodyDic = [[NSMutableDictionary alloc] initWithCapacity:1];
    
    if ([[AppInformationSingleton shareAppInfomationSingleton] getLoginCode]) {
        [headDic setObject:[[AppInformationSingleton shareAppInfomationSingleton] getLoginCode] forKey:@"ut"];
        [headDic setObject:[[AppInformationSingleton shareAppInfomationSingleton] getUserID] forKey:@"userid"];
    }
    
    
    [bodyDic setObject:@"deleteshaddress" forKey:@"functionid"];
    [bodyDic setObject:addressID forKey:@"addressid"];

    
    NSMutableDictionary * parameter = [[NSMutableDictionary alloc] initWithCapacity:1];
    [parameter setObject:headDic forKey:@"head"];
    [parameter setObject:bodyDic forKey:@"body"];
    [self postWithParameter:parameter SuccessBlock:^(id responseBody) {
        if ([responseBody isKindOfClass:[NSDictionary class]]) {
            successBlock(responseBody);
            [SVProgressHUD dismissWithSuccess:@"加载成功" afterDelay:1];
        }
    } FailureBlock:^(NSString *error) {
        
        [SVProgressHUD dismissWithError:error afterDelay:1];
    }];
}

-(void)feedBackWithTitle:(NSString *)title Content:(NSString *)content userContactType:(UserContactMethodType)contactType ContactDetail:(NSString *)contactMethodDetail SuccessBlock:(SuccessBlock)successBlock FailureBlock:(FailureBlock)failureBlock
{
    NSMutableDictionary * headDic = [[NSMutableDictionary alloc] initWithCapacity:1];
    NSMutableDictionary * bodyDic = [[NSMutableDictionary alloc] initWithCapacity:1];
    [bodyDic setObject:@"feedback" forKey:@"functionid"];
    [bodyDic setObject:title forKey:@"title"];
    [bodyDic setObject:content forKey:@"content"];
    
    if (contactMethodDetail.length > 0) {

        switch (contactType) {
            case kUserContactMethodTypeEmail: {
                [bodyDic setObject:contactMethodDetail forKey:@"email"];
                break;
            }
            case kUserContactMethodTypePhone: {
                [bodyDic setObject:contactMethodDetail forKey:@"phone"];
                break;
            }
            case kUserContactMethodTypeConnector: {
                [bodyDic setObject:contactMethodDetail forKey:@"connector"];
                break;
            }
            case kUserContactMethodTypeQQ: {
                [bodyDic setObject:contactMethodDetail forKey:@"qq"];
                break;
            }
        }
    }
    
        
    NSMutableDictionary * parameter = [[NSMutableDictionary alloc] initWithCapacity:1];
    [parameter setObject:headDic forKey:@"head"];
    [parameter setObject:bodyDic forKey:@"body"];
    [self postWithParameter:parameter SuccessBlock:^(id responseBody) {
        if ([responseBody isKindOfClass:[NSDictionary class]]) {
            successBlock(responseBody);
        }else{
            failureBlock(@"数据解析失败");
        }
    } FailureBlock:^(NSString *error) {
        failureBlock(error);
    }];
}


- (void)postWithHeadParameter:(NSDictionary *)headDic bodyParameter:(NSDictionary *)bodyDic productsParameter:(NSDictionary *)productsDic SuccessBlock:(SuccessBlock)successBlock FailureBlock:(FailureBlock)failureBlock{
    NSMutableDictionary * parameter = [[NSMutableDictionary alloc] initWithCapacity:1];
    [parameter setObject:headDic forKey:@"head"];
    [parameter setObject:bodyDic forKey:@"body"];
    
    [self postWithParameter:parameter SuccessBlock:^(id responseBody) {
        if ([responseBody isKindOfClass:[NSDictionary class]]) {
            successBlock(responseBody);
        }else{
            failureBlock(@"数据解析失败");
        }
    } FailureBlock:^(NSString *error) {
        failureBlock(error);
    }];
}

- (void)postWithBodyParameter:(NSDictionary *)bodyDic addressParameter:(NSDictionary *)addressDic SuccessBlock:(SuccessBlock)successBlock FailureBlock:(FailureBlock)failureBlock {
    NSMutableDictionary * parameter = [[NSMutableDictionary alloc] initWithCapacity:1];
    [parameter setObject:bodyDic forKey:@"body"];
    
    [self postWithParameter:parameter SuccessBlock:^(id responseBody) {
        if ([responseBody isKindOfClass:[NSDictionary class]]) {
            successBlock(responseBody);
        }else{
            failureBlock(@"数据解析失败");
        }
    } FailureBlock:^(NSString *error) {
        failureBlock(error);
    }];
    
    
}


@end














