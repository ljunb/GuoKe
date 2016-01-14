//
//  LJBHTTPTool.h
//  GuoKe
//
//  Created by 林俊炳 on 16/1/13.
//  Copyright © 2016年 ljunb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LJBHTTPTool : NSObject

/**
 *  封装AFNetworking请求方法
 *
 *  @param url     URL
 *  @param params  请求参数字典
 *  @param success 请求成功回调
 *  @param failure 请求失败回调
 */
+ (void)get:(NSString *)url params:(NSDictionary *)params success:(void(^)(id response))success failure:(void(^)(NSError *error))failure;

/**
 *  检测网络状态
 *
 *  @param connected    网络连接正常回调
 *  @param disconnected 网络连接异常回调
 */
+ (void)checkNetworkWithConnected:(void(^)())connected disconnected:(void(^)())disconnected;

@end
