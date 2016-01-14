//
//  LJBHTTPTool.m
//  GuoKe
//
//  Created by 林俊炳 on 16/1/13.
//  Copyright © 2016年 ljunb. All rights reserved.
//

#import "LJBHTTPTool.h"
#import <AFNetworking.h>

@implementation LJBHTTPTool

+ (void)checkNetworkWithConnected:(void (^)())connected disconnected:(void (^)())disconnected {
    
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        switch (status) {
            case AFNetworkReachabilityStatusReachableViaWiFi:
            case AFNetworkReachabilityStatusReachableViaWWAN:
            {
                if (connected) {
                    connected();
                }
            }
                break;
            case AFNetworkReachabilityStatusNotReachable:
            case AFNetworkReachabilityStatusUnknown:
            {
                if (disconnected) {
                    disconnected();
                }
            }
                break;
        }
    }];
}

+ (void)get:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    
    [manager GET:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
    
        if (!responseObject[@"ok"]) return ;
        
        if (success) {
            success(responseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (failure) {
            failure(error);
        }
    }];
    
}



@end
