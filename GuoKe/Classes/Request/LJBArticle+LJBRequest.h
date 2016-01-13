//
//  LJBArticle+LJBRequest.h
//  GuoKe
//
//  Created by 林俊炳 on 16/1/13.
//  Copyright © 2016年 ljunb. All rights reserved.
//

#import "LJBArticle.h"

@interface LJBArticle (LJBRequest)

/**
 *  请求最新精选文章
 *
 *  @param successBlock 请求成功回调
 *  @param failureBlock 请求失败回调
 */
+ (void)fetchLatestArticleWithCompletionBlock:(void(^)(id response))successBlock
                                 failureBlock:(void(^)(NSError *error))failureBlock;

@end
