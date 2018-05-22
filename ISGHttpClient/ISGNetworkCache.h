//
//  ISGNetworkCache.h
//  ISGHttpClient
//
//  Created by Isaac on 2018/5/18.
//  Copyright © 2018年 Isaac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ISGTypedefClass.h"

/**
 网络数据缓存
 */
@interface ISGNetworkCache : NSObject

/**
 缓存数据

 @param data 要缓存的数据
 @param url 请求的url
 @param parameters 请求的参数
 */
+ (void)cacheData:(id)data
              url:(NSString *)url
       parameters:(NSDictionary *)parameters;

/**
 通过URL和参数获取缓存的数据

 @param url 请求的url
 @param parameters 请求的参数
 @return 缓存的数据
 */
+ (id)getCacheForURL:(NSString *)url
          parameters:(NSDictionary *)parameters;

/**
 删除所有缓存的数据
 */
+ (void)removeAllCache;

/**
 获取所有缓存大小

 @return 缓存的大小
 */
+ (NSInteger)getAllCacheSize;

/**
 移除所有缓存带进度

 @param progress 进度
 @param success 成功
 @param failure 失败
 */
+ (void)removeAllObjectsWithProgressBlock:(CacheDeleteProgress)progress
                                  success:(CacheDeleteSuccess)success
                                  failure:(CacheDeleteFailure)failure;
@end
