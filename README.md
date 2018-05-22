# ISGHttpClient

[![Version](https://img.shields.io/cocoapods/v/ISGHttpClient.svg?style=flat)](https://cocoapods.org/pods/ISGHttpClient)
[![License](https://img.shields.io/cocoapods/l/ISGHttpClient.svg?style=flat)](https://cocoapods.org/pods/ISGHttpClient)
[![Platform](https://img.shields.io/cocoapods/p/ISGHttpClient.svg?style=flat)](https://cocoapods.org/pods/ISGHttpClient)


## 安装

```ruby
pod 'ISGHttpClient'
```

## Use

```
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
```
## 简书

[二明白M6](https://www.jianshu.com/u/7e1b920cdac1)

## License

ISGUIViewExt is available under the MIT license. See the LICENSE file for more info.
