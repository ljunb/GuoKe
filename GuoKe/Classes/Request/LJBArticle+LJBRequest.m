//
//  LJBArticle+LJBRequest.m
//  GuoKe
//
//  Created by 林俊炳 on 16/1/13.
//  Copyright © 2016年 ljunb. All rights reserved.
//

#import "LJBArticle+LJBRequest.h"
#import "LJBHTTPTool.h"
#import "LJBArticle.h"
#import "LJBArticleParam.h"
#import <MMProgressHUD.h>
#import <YYModel.h>

static NSString * kArticleURL = @"http://apis.guokr.com/handpick/article.json";


@implementation LJBArticle (LJBRequest)

+ (void)fetchLatestArticleWithCompletionBlock:(void (^)(id))successBlock failureBlock:(void (^)(NSError *))failureBlock {
    
    [MMProgressHUD setPresentationStyle:MMProgressHUDPresentationStyleFade];
    [MMProgressHUD show];
    
    LJBArticleParam * param = [[LJBArticleParam alloc] init];
  
    NSDictionary * paramDic = [param yy_modelToJSONObject];
    
    [LJBHTTPTool get:kArticleURL params:paramDic success:^(id response) {
        
        NSArray * articles = [NSArray yy_modelArrayWithClass:[LJBArticle class] json:response[@"result"]];
        
        if (successBlock) {
            successBlock(articles);
        }
        
        [MMProgressHUD dismiss];
        
    } failure:^(NSError *error) {
        
        [MMProgressHUD dismissWithError:@"请检查网络"];
        
        if (failureBlock) {
            failureBlock(error);
        }
    }];
}

@end
