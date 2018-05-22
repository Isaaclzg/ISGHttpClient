//
//  ISGTypedefClass.h
//  ISGHttpClient
//
//  Created by Isaac on 2018/5/22.
//  Copyright © 2018年 Isaac. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, ISGNetworkStatus) {
    /// 未知网络
    ISGNetworkStatusUnknown,
    /// 无网络
    ISGNetworkStatusNoNetwork,
    /// 手机网络
    ISGNetworkStatusWWAN,
    /// WIFI网络
    ISGNetworkStatusWiFi
};


/*! @brief 网络请求成功的block */
typedef void (^SuccessBlock)(id result);

/*! @brief 网络请求失败的block */
typedef void (^FailureBlock)(NSError *error);

/*! @brief 清除缓存的进度 */
typedef void (^CacheDeleteProgress)(int removedCount, int totalCount);

/*! @brief 清除缓存成功 */
typedef void (^CacheDeleteSuccess)(NSString *successDes);

/*! @brief 清除缓存失败 */
typedef void (^CacheDeleteFailure)(NSString *failureDes);

/*! @brief 网络状态的Block */
typedef void(^ISGNetworkStatusBlock)(ISGNetworkStatus status);

