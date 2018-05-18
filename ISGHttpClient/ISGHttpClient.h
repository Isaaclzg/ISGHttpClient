//
//  ISGHttpClient.h
//  ISGHttpClient
//
//  Created by Isaac on 2018/5/18.
//  Copyright © 2018年 Isaac. All rights reserved.
//

#import <Foundation/Foundation.h>

/*! @brief 请求成功的block */
typedef void (^SuccessBlock)(id result);

/*! @brief 请求失败的block */
typedef void (^FailureBlock)(NSError *error);


/**
 *  网络请求工具类
 */
@interface ISGHttpClient : NSObject


/**
 *  单例创建网络请求工具类
 *
 *  @return ISHttpClient
 */
+ (instancetype)shareClient;

/**
 *  POST请求
 *
 *  @param urlString 请求的url
 *  @param params    参数
 *  @param success   成功block
 *  @param failure   失败block
 */
- (void)postRequestWithURL:(NSString *)urlString
                parameters:(NSDictionary *)params
                   success:(SuccessBlock)success
                   failure:(FailureBlock)failure;

/**
 *  GET请求
 *
 *  @param urlString 请求的url
 *  @param params    参数
 *  @param success   成功block
 *  @param failure   失败block
 */
- (void)getRequestWithURL:(NSString *)urlString
               parameters:(NSDictionary *)params
                  success:(SuccessBlock)success
                  failure:(FailureBlock)failure;

@end
