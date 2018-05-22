//
//  ISGHttpClient.h
//  ISGHttpClient
//
//  Created by Isaac on 2018/5/18.
//  Copyright © 2018年 Isaac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ISGTypedefClass.h"

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
 自动缓存的GET请求

 @param urlString 请求的url
 @param params 参数
 @param success 成功
 @param failure 失败
 */
- (void)cacheGETRequestWithURL:(NSString *)urlString
                    parameters:(NSDictionary *)params
                       success:(SuccessBlock)success
                       failure:(FailureBlock)failure;

/**
 自动缓存的POST请求

 @param urlString 请求的url
 @param params 参数
 @param success 成功
 @param failure 失败
 */
- (void)cachePOSTRequestWithURL:(NSString *)urlString
                     parameters:(NSDictionary *)params
                        success:(SuccessBlock)success
                        failure:(FailureBlock)failure;
/**
 设置超时时间，默认60s

 @param timeout 超时时间
 */
- (void)setTimeoutInterval:(double)timeout;

/**
 取消单个请求

 @param url url
 @param parameters 参数
 */
- (void)cancelRequestWithURL:(NSURL *)url
                  parameters:(NSDictionary *)parameters;

/**
 取消所有请求
 */
- (void)cancelAllRequest;

/**
 开始检测网络状态

 @param networkStatu 网络状态
 */
- (void)networkStatusWithBlock:(ISGNetworkStatusBlock)networkStatu;


/**
 是否联网

 @return 网络状态
 */
- (BOOL)isNetwork;

/**
 是否使用手机网络

 @return 是否使用手机网络
 */
- (BOOL)isWWANNetwork;

/**
 是否使用Wifi

 @return 是否使用Wifi
 */
- (BOOL)isWiFiNetwork;
@end
