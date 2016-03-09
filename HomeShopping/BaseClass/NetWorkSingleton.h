//
//  NetWorkSingleton.h
//  HomeShopping
//
//  Created by sooncong on 15/12/14.
//  Copyright © 2015年 Administrator. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIView+Toast.h"
#import "SCEnum.h"

typedef void(^SuccessBlock)(id responseBody);
typedef void(^FailureBlock)(NSString *error);

/// 微信appkey
extern NSString *const WeixinAppKey;
extern NSString *const WeixinAccount;
extern NSString *const WeixinPassword;
extern NSString *const zhifubaoAccount;
extern NSString *const zhifubaoPassword;
///合作者身份(PID)
extern NSString *const zhifubaoPID;
/// 支付宝公钥(RSA)
extern NSString *const zhifubaoRSA;
/// 支付宝校验(key)
extern NSString *const zhifubaoKEY;



@interface NetWorkSingleton : NSObject

+(NetWorkSingleton *)sharedManager;
//-(AFHTTPRequestOperationManager *)baseHtppRequest;
//-(WTNetWorkManager *)baseHtppRequest;

/**
 @brief  获取首页数据 参数分head和body情况传入
 @param head    head参数字典
 @param body    body参数字典
 @param successBlock 成功回调
 @param failureBlock 失败回调
 */
-(void)postWithHeadParameter:(NSDictionary *)headDic bodyParameter:(NSDictionary*)bodyDic SuccessBlock:(SuccessBlock)successBlock FailureBlock:(FailureBlock)failureBlock;

/**
 @brief  获取首页数据 参数整体传入
 @param head    head参数字典
 @param successBlock 成功回调
 @param failureBlock 失败回调
 */

-(void)postWithParameter:(NSDictionary *)parameter SuccessBlock:(SuccessBlock)successBlock FailureBlock:(FailureBlock)failureBlock;

- (NSString *)getFormaterTime;

#pragma mark - 公用方法

/**
 *  获取验证码方法
 *
 *  @param telNumber       电话号码
 *  @param confirmCodetype 验证码用途
 *  @param successBlock    成功回调方法
 *  @param failureBlock    失败回调方法
 */
-(void)getConfirmCodeWithTelNumber:(NSString *)telNumber ConfirmCodeType:(ConfirmCodeType)confirmCodetype SuccessBlock:(SuccessBlock)successBlock FailureBlock:(FailureBlock)failureBlock;

/**
 *  找回密码方法
 *
 *  @param phoneNumber 电话号码
 *  @param confirmCode 验证码
 *  @param newPassWord 新密码
 */
-(void)getBackPassWordWithPhoneNumber:(NSString *)phoneNumber ConfirmCode:(NSString *)confirmCode NewPassWord:(NSString *)newPassWord SuccessBlock:(SuccessBlock)successBlock FailureBlock:(FailureBlock)failureBlock;

/**
 *  注册用户方法
 *
 *  @param phoneNumber  电话号码
 *  @param confirmCode  验证码
 *  @param PassWord  密码
 *  @param successBlock 成功回调方法
 *  @param failureBlock 失败回调方法
 */
- (void)registerUserWithPhoneNumber:(NSString *)phoneNumber ConfirmCode:(NSString *)confirmCode PassWord:(NSString *)passWord SuccessBlock:(SuccessBlock)successBlock FailureBlock:(FailureBlock)failureBlock;

/**
 *  用户登陆方法
 *
 *  @param phoneNumber  电话号码
 *  @param passWord     密码
 *  @param successBlock 成功回调方法
 *  @param failureBlock 失败回调方法
 */
- (void)LoginUserWithPhoneNumber:(NSString *)phoneNumber PassWord:(NSString *)passWord SuccessBlock:(SuccessBlock)successBlock FailureBlock:(FailureBlock)failureBlock;

/**
 *  获取收货地址
 *
 *  @param isGetDefaultAddr 是否获取默认地址
 *  @param isGetReight      是否获取运费规则
 *  @param isGetPayType     是否获取支付方式
 */
- (void)getReceivingGoodsAddressWhetherGetDefaultAddress:(BOOL)isGetDefaultAddr GetReight:(BOOL)isGetReight GetPayType:(BOOL)isGetPayType SuccessBlock:(SuccessBlock)successBlock FailureBlock:(FailureBlock)failureBlock;

/**
 *  删除收货地址
 *
 *  @param addressID 地址id
 */
- (void)deleteReceivingGoodsAddressWithID:(NSString *)addressID SuccessBlock:(SuccessBlock)successBlock FailureBlock:(FailureBlock)failureBlock;

/**
 *  意见反馈
 *
 *  @param title               标题
 *  @param content             意见内容
 *  @param contactType         联系人联络方式类型
 *  @param contactMethodDetail 具体联系方式
 *  @param successBlock        成功回调方法
 *  @param failureBlock        失败回调方法
 */
- (void)feedBackWithTitle:(NSString *)title Content:(NSString *)content userContactType:(UserContactMethodType)contactType ContactDetail:(NSString *)contactMethodDetail SuccessBlock:(SuccessBlock)successBlock FailureBlock:(FailureBlock)failureBlock;

/**微信预支付接口*/
- (void)postWithHeadParameter:(NSDictionary *)headDic bodyParameter:(NSDictionary *)bodyDic productsParameter:(NSDictionary *)productsDic SuccessBlock:(SuccessBlock)successBlock FailureBlock:(FailureBlock)failureBlock;

/*更新地址接口*/
- (void)postWithBodyParameter:(NSDictionary *)bodyDic addressParameter:(NSDictionary *)addressDic SuccessBlock:(SuccessBlock)successBlock FailureBlock:(FailureBlock)failureBlock;
@end









