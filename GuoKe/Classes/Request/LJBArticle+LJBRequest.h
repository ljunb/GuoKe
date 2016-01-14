//
//  LJBArticle+LJBRequest.h
//  GuoKe
//
//  Created by 林俊炳 on 16/1/13.
//  Copyright © 2016年 ljunb. All rights reserved.
//

#import "LJBArticle.h"

@class LJBArticleParam;

@interface LJBArticle (LJBRequest)

/**
 *  请求最新精选文章数据
 *
 *  @param successBlock 请求成功回调
 *  @param failureBlock 请求失败回调
 */
+ (void)fetchLatestArticleWithCompletionBlock:(void(^)(id response))successBlock
                                 failureBlock:(void(^)(NSError *error))failureBlock;

/**
 *  请求更多精选文章数据
 *
 *  @param param        请求参数模型
 *  @param successBlock 请求成功回调
 *  @param failureBlock 请求失败回调
 */
+ (void)fetchMoreArticleWithParam:(LJBArticleParam *)param
                  completionBlock:(void (^)(id response))successBlock
                     failureBlock:(void (^)(NSError *error))failureBlock;

@end
