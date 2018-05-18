//
//  ISGHttpClient.m
//  ISGHttpClient
//
//  Created by Isaac on 2018/5/18.
//  Copyright © 2018年 Isaac. All rights reserved.
//

#import "ISGHttpClient.h"
#import <AFNetworking.h>

#define kLine1 @"--------------------------------------------"
#define kLine2 @"********************************************"

#define ISGJson(data) [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil]


/*! @brief 超时的时间 */
static double const kTimeout  = 60.0;

/*! @brief 端口号 */
static NSString * const kBasePort  = @"";

@interface ISGHttpClient()

/*! @brief  manager */
@property (nonatomic, strong) AFHTTPSessionManager *manager;

@end

@implementation ISGHttpClient

static id _instance = nil;

+ (instancetype)shareClient{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}

#pragma mark - GET
- (void)getRequestWithURL:(NSString *)urlString parameters:(NSDictionary *)params success:(SuccessBlock)success failure:(FailureBlock)failure{
    
    NSString *url = [NSString stringWithFormat:@"%@%@",kBasePort,urlString];
    NSLog(@"\n%@\n请求的方式:%@\n请求的url:%@\n请求的参数:%@\n%@",kLine1,@"GET",url,params,kLine2);
    [self.manager GET:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *dict = ISGJson(responseObject);
        NSLog(@"请求成功\n返回的结果:\n%@\n%@",dict,kLine1);
        success(dict);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"请求失败\n失败的错误码:%ld\n错误信息:%@\n%@",(long)error.code,error.localizedDescription,kLine1);
        failure(error);
    }];
    
}

#pragma mark - POST
- (void)postRequestWithURL:(NSString *)urlString parameters:(NSDictionary *)params success:(SuccessBlock)success failure:(FailureBlock)failure{
    
    NSString *url = [NSString stringWithFormat:@"%@%@",kBasePort,urlString];
    NSLog(@"\n%@\n请求的方式:%@\n请求的url:%@\n请求的参数:%@\n%@",kLine1,@"POST",url,params,kLine2);
    
    [self.manager POST:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *dict = ISGJson(responseObject);
        NSLog(@"请求成功\n返回的结果:\n%@\n%@",dict,kLine1);
        success(dict);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"请求失败\n失败的错误码:%ld\n错误信息:%@\n%@",(long)error.code,error.localizedDescription,kLine1);
        failure(error);
    }];
}

#pragma mark - Getter
- (AFHTTPSessionManager *)manager {
    
    if (nil == _manager) {
        
        _manager = [AFHTTPSessionManager manager];
        // 添加服务器可能返回的数据格式
        _manager.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"application/json",@"text/html",@"text/json",@"text/plain",@"text/javascript",@"text/xml",@"image/*",@"image/png"]];;
        _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        [_manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        _manager.requestSerializer.timeoutInterval = kTimeout;
        [_manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
        
    }
    return _manager;
}

@end
