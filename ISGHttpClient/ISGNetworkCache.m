//
//  ISGNetworkCache.m
//  ISGHttpClient
//
//  Created by Isaac on 2018/5/18.
//  Copyright © 2018年 Isaac. All rights reserved.
//

#import "ISGNetworkCache.h"
#import <YYCache.h>

static NSString *const kISGNetworkCache = @"kISGNetworkCache";

@interface ISGNetworkCache ()

@end

@implementation ISGNetworkCache
static YYCache *_dataCache;

#pragma mark - initialize Method
+ (void)initialize {
    _dataCache = [YYCache cacheWithName:kISGNetworkCache];
}

#pragma mark - —————————————————————Public Method—————————————————————
#pragma mark - 缓存数据
+ (void)cacheData:(id)data
              url:(NSString *)url
       parameters:(NSDictionary *)parameters {
    
    NSString *cacheKey = [self cacheKeyWithURL:url parameters:parameters];
    //异步缓存,不会阻塞主线程
    [_dataCache setObject:data forKey:cacheKey withBlock:nil];
}

#pragma mark - 获取缓存的数据
+ (id)getCacheForURL:(NSString *)url
          parameters:(NSDictionary *)parameters {
    
    NSString *cacheKey = [self cacheKeyWithURL:url parameters:parameters];
    return [_dataCache objectForKey:cacheKey];
}

#pragma mark - 删除所有缓存
+ (void)removeAllCache {
    
    [_dataCache.diskCache removeAllObjects];
}

#pragma mark - 获取所有缓存的大小
+ (NSInteger)getAllCacheSize {
    // (@"网络缓存大小cache = %fKB",[PPNetworkCache getAllCacheSize]/1024.f)
    return [_dataCache.diskCache totalCost];
}

#pragma mark - 删除缓存的进度
+ (void)removeAllObjectsWithProgressBlock:(CacheDeleteProgress)progress success:(CacheDeleteSuccess)success failure:(CacheDeleteFailure)failure {
    
    [_dataCache removeAllObjectsWithProgressBlock:^(int removedCount, int totalCount) {
        progress(removedCount,totalCount);
        
    } endBlock:^(BOOL error) {
        if(!error){
            success(@"removeAllObjects sucess");
            
        }else{
            failure(@"removeAllObjects error");
        }
    }];
}

#pragma mark - —————————————————————Private Method—————————————————————
/**
 将参数字典转换成字符串（没有参数用url）

 @param URL url
 @param parameters 参数
 @return 字符串
 */
+ (NSString *)cacheKeyWithURL:(NSString *)URL parameters:(NSDictionary *)parameters {
    
    if(!parameters || parameters.count == 0){return URL;};
    NSData *stringData = [NSJSONSerialization dataWithJSONObject:parameters options:0 error:nil];
    NSString *paraString = [[NSString alloc] initWithData:stringData encoding:NSUTF8StringEncoding];
    return [NSString stringWithFormat:@"%@%@",URL,paraString];
}

@end
