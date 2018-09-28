//
//  ISGHttpClient.m
//  ISGHttpClient
//
//  Created by Isaac on 2018/5/18.
//  Copyright © 2018年 Isaac. All rights reserved.
//

#import "ISGHttpClient.h"
#import <AFNetworking.h>
#import "ISGNetworkConfig.h"
#import "ISGNetworkCache.h"

/*! @brief 超时的时间 */
static double const kTimeout  = 60.0;

@interface ISGHttpClient()

/*! @brief  manager */
@property (nonatomic, strong) AFHTTPSessionManager *manager;


@end

@implementation ISGHttpClient

static id _instance = nil;

#pragma mark - —————————————————————Public Method—————————————————————
+ (instancetype)shareClient{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}

#pragma mark - GET 无缓存
- (void)getRequestWithURL:(NSString *)urlString
               parameters:(id)params
                  success:(SuccessBlock)success
                  failure:(FailureBlock)failure {
    
    [self.manager GET:urlString parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *dict = ISGJson(responseObject);
        ISGLogRequestSuccess(urlString, @"GET", params, dict);
        success(dict);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        ISGLogRequestFailure(urlString, @"GET", params, error);
        failure(error);
    }];
    
}

#pragma mark - POST 无缓存
- (void)postRequestWithURL:(NSString *)urlString
                parameters:(id)params
                   success:(SuccessBlock)success
                   failure:(FailureBlock)failure {
    
    [self.manager POST:urlString parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *dict = ISGJson(responseObject);
        ISGLogRequestSuccess(urlString, @"POST", params, dict);
        success(dict);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        ISGLogRequestFailure(urlString, @"POST", params, error);
        failure(error);
    }];
}

#pragma mark - 缓存GET请求
- (void)cacheGETRequestWithURL:(NSString *)urlString
               parameters:(id)params
                  success:(SuccessBlock)success
                  failure:(FailureBlock)failure {
    
    [self.manager GET:urlString parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *dict = ISGJson(responseObject);
        ISGLogRequestSuccess(urlString, @"GET", params, dict);
        [ISGNetworkCache cacheData:dict url:urlString parameters:params];
        success(dict);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        ISGLogRequestFailure(urlString, @"GET", params, error);
        failure(error);
    }];
}

#pragma mark - 缓存POST请求
- (void)cachePOSTRequestWithURL:(NSString *)urlString
                parameters:(id)params
                   success:(SuccessBlock)success
                   failure:(FailureBlock)failure {
    
    [self.manager POST:urlString parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *dict = ISGJson(responseObject);
        ISGLogRequestSuccess(urlString, @"POST", params, dict);
        [ISGNetworkCache cacheData:dict url:urlString parameters:params];
        success(dict);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        ISGLogRequestFailure(urlString, @"POST", params, error);
        failure(error);
    }];
}

#pragma mark - 设置超时时间
- (void)setTimeoutInterval:(double)timeout {
    
    self.manager.requestSerializer.timeoutInterval = timeout;
}

#pragma mark - 取消单个请求
- (void)cancelRequestWithURL:(NSURL *)url
                  parameters:(id)parameters {
    
    NSURLSessionDataTask *task = [self.manager GET:url.absoluteString parameters:parameters progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        
        NSLog(@"JSON: %@", responseObject);
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        
        NSLog(@"Error: %@", error);
        
    }];
    //取消单个请求
    [task cancel];
}

#pragma mark - 取消所有请求
- (void)cancelAllRequest {
    
    [self.manager.operationQueue cancelAllOperations];
}

#pragma mark - 开始监听网络
- (void)networkStatusWithBlock:(ISGNetworkStatusBlock)networkStatus {
    
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                networkStatus ? networkStatus(ISGNetworkStatusUnknown) : nil;
                break;
            case AFNetworkReachabilityStatusNotReachable:
                networkStatus ? networkStatus(ISGNetworkStatusNoNetwork) : nil;
        
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                networkStatus ? networkStatus(ISGNetworkStatusWWAN) : nil;
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                networkStatus ? networkStatus(ISGNetworkStatusWiFi) : nil;
                break;
        }
    }];
}

#pragma mark - 是否联网
- (BOOL)isNetwork {
    return [AFNetworkReachabilityManager sharedManager].reachable;
}

#pragma mark - 是否是手机网
- (BOOL)isWWANNetwork {
    return [AFNetworkReachabilityManager sharedManager].reachableViaWWAN;
}

#pragma mark - 是否是Wifi
- (BOOL)isWiFiNetwork {
    return [AFNetworkReachabilityManager sharedManager].reachableViaWiFi;
}

#pragma mark - —————————————————————Private Method—————————————————————
- (AFHTTPSessionManager *)manager {
    
    if (nil == _manager) {
        
        _manager = [AFHTTPSessionManager manager];
        // 添加服务器可能返回的数据格式
        // 设置请求格式
        _manager.requestSerializer = [AFJSONRequestSerializer serializer];
        _manager.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"application/json",@"text/html",@"text/json",@"text/plain",@"text/javascript",@"text/xml",@"image/*",@"image/png"]];;
        _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        [_manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        _manager.requestSerializer.timeoutInterval = kTimeout;
        [_manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
        
    }
    return _manager;
}

@end
