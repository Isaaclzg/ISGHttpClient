//
//  ISGNetworkConfig.h
//  ISGHttpClient
//
//  Created by Isaac on 2018/5/22.
//  Copyright © 2018年 Isaac. All rights reserved.
//
#ifndef ISGNetworkConfig_h
#define ISGNetworkConfig_h
/*!
 * `1`:测试环境
 * `0`:生产环境
 */
#ifdef DEBUG
#define TEST 1
#else
#define TEST 0
#endif


#if TEST

#define kBasePort @"http://"

#else

#define kBasePort @"http://"

#endif

#ifdef DEBUG
#define ISGLog(fmt, ...) NSLog((@ "[行号:%d] \n" "[函数名:%s]\n"  fmt),  __LINE__, __FUNCTION__, ##__VA_ARGS__);
#else
#define ISGLog(...);
#endif


#define kLine1 @"--------------------------------------------"
#define kLine2 @"********************************************"

// 请求成功输出的信息
#define ISGLogRequestSuccess(urlStr, method, paramDict, result) ISGLog(@"\n%@\n请求地址:\n%@\n请求方式:\n%@\n请求参数:\n%@\n%@\n请求成功,返回数据:\n%@\n%@", (kLine1), (urlStr), (method), (paramDict), (kLine2), (result), kLine1)

// 请求失败输出的信息
#define ISGLogRequestFailure(urlStr, method, paramDict, error) ISGLog(@"\n%@\n请求地址:\n%@\n请求方式:\n%@\n请求参数:\n%@\n%@\n请求失败,失败原因:\n%@\n%@\n%@", (kLine1), (urlStr), (method), (paramDict), (kLine2), (error.localizedDescription), (error.userInfo), kLine2)

// JSON序列化
#define ISGJson(data) [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil]
#endif 
