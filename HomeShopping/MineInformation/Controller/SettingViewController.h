//
//  SettingViewController.h
//  HomeShopping
//
//  Created by sooncong on 16/1/9.
//  Copyright © 2016年 Administrator. All rights reserved.
//

#import "UITableBaseViewController.h"

/**
 *  设置页面表视图点击类型
 */
typedef NS_ENUM(NSInteger, SettingClickType) {
    /**
     *  清除缓存
     */
    kSettingClickTypeCleanChache = 0,
    /**
     *  意见反馈
     */
    kSettingClickTypeAdviceFeedBack,
//    /**
//     *  版本更新
//     */
//    kSettingClickTypeCheckVersion,
    /**
     *  关于我们
     */
    kSettingClickTypeAboutUs,
};

@interface SettingViewController : UITableBaseViewController

@end
