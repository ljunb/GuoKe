//
//  LJBHTTPTool.h
//  GuoKe
//
//  Created by 林俊炳 on 16/1/13.
//  Copyright © 2016年 ljunb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LJBHTTPTool : NSObject

+ (void)get:(NSString *)url params:(NSDictionary *)params success:(void(^)(id response))success failure:(void(^)(NSError *error))failure;

/**
 *  检查网络连接状态
 *
 *  @return YES or NO
 */
+ (BOOL)hasConnected;

+ (void)checkNetworkWithConnected:(void(^)())connected disconnected:(void(^)())disconnected;

@end
