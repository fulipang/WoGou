//
//  SCEnum.h
//  HomeShopping
//
//  Created by sooncong on 16/1/7.
//  Copyright © 2016年 Administrator. All rights reserved.
//

#ifndef SCEnum_h
#define SCEnum_h

/**
 *  产品类型
 */
typedef NS_ENUM(NSInteger, ProductType) {
    
//    /**
//     *  全部
//     */
//    kProductTypeAll = 0,
    /**
     *  实物（酒店用品）
     */
    kProductTypeEntity = 1,
    /**
     *  虚拟（酒店）
     */
    kProductTypeVirtual,
};

/**
 *  控制器的弹出类型
 */
typedef NS_ENUM(NSInteger, SCApperType) {
    /**
     *  push
     */
    kApperTypePush = 0,
    /**
     *  模态
     */
    kApperTypePresent,
};

/**
 *  验证码用途
 */
typedef NS_ENUM(NSInteger, ConfirmCodeType) {
    /**
     *  注册用
     */
    kConfirmTypeRegister = 1,
    /**
     *  修改密码用
     */
    KConfirmTypeModifyPassWord,
    /**
     *  修改手机用
     */
    kConfirmTypeModifyPhoneNumber,
    /**
     *  找回密码用
     */
    kConfirmTypeGetBackPassWord,
};

/**
 *  用户联系方式
 */
typedef NS_ENUM(NSInteger, UserContactMethodType) {
    /**
     *  电子邮箱
     */
    kUserContactMethodTypeEmail = 0,
    /**
     *  电话
     */
    kUserContactMethodTypePhone,
    /**
     *  联系人
     */
    kUserContactMethodTypeConnector,
    /**
     *  QQ
     */
    kUserContactMethodTypeQQ,
};

/**
 *  订单操作按钮类型
 */
typedef NS_ENUM(NSInteger, OrderOperationType) {
    /**
     *  去付款
     */
    kOrderOperationTypePay = 0,
    /**
     *  去评价
     */
    kOrderOperationTypecomment,
    /**
     *  收货并评价
     */
    kOrderOperationTyperRceiveAndComment,
    /**
     *  已评价
     */
    kOrderOperationTypeDone,
};

/**
 *  评论类型
 */
typedef NS_ENUM(NSInteger, CommentListType) {
    /**
     *  全部
     */
    kCommentTypeAll = 0,
    /**
     *  好评
     */
    kCommentTypeGood,
    /**
     *  中评
     */
    kCommentTypeMiddle,
    /**
     *  差评
     */
    kCommentTypeBad,
};

/**
 *  商品cell位置类型 (商品详情)
 */
typedef NS_ENUM(NSInteger, ProductIndexType) {
    /**
     *  消息
     */
    kProductIndexTypeInfo = 0,
    /**
     *  选择
     */
    kProductIndexTypeSelect,
    /**
     *  评论
     */
    kProductIndexTypeComment,
    /**
     *  猜你喜欢
     */
    kProductIndexTypePossibleLike,
};

/**
 *  加入购物车或收藏类型
 */
typedef NS_ENUM(NSInteger, ProductGetInType) {
    /**
     *  加入购物车
     */
    kGetInTypeShopCar = 1,
    /**
     *  收藏
     */
    kGetInTypeCollection,
};

/**
 *  订单状态
 */
typedef NS_ENUM(NSInteger, OrderStatusType) {
    /**
     *  全部
     */
    kOrderStatusAll = 0,
    /**
     *  待付款
     */
    kOrderStatusWaitForPay = 1,
    /**
     *  待发货
     */
    kOrderStatusWaitForSendConsignment,
    /**
     *  待收货
     */
    kOrderStatusWaitForReceiveProduct,
    /**
     *  待评价
     */
    kOrderStatusWaitForGiveComment,
    /**
     *  已评价
     */
    kOrderStatusAlreadyComment,
    /**
     *  已付款
     */
    kOrderStatusAlreadyPayed,
};

#endif /* SCEnum_h */
