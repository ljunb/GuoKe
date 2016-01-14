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
#import "LJBArticleFrame.h"
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
    
        NSArray * resultArr = response[@"result"];
        
        NSMutableArray * articleFrames = [NSMutableArray array];
        
        for (NSDictionary * artDic in resultArr) {
            
            LJBArticle * article = [LJBArticle yy_modelWithDictionary:artDic];
            
            LJBArticleFrame * articleF = [LJBArticleFrame frameWithArticle:article];
            
            [articleFrames addObject:articleF];
        }
        
        // 回传数据
        if (successBlock) {
            successBlock(articleFrames);
        }
        
        [MMProgressHUD dismiss];

        
    } failure:^(NSError *error) {
        
        [MMProgressHUD dismissWithError:@"请检查网络"];
        
        if (failureBlock) {
            failureBlock(error);
        }
    }];
}

+ (void)fetchMoreArticleWithParam:(LJBArticleParam *)param completionBlock:(void (^)(id))successBlock failureBlock:(void (^)(NSError *))failureBlock {
    
    [MMProgressHUD setPresentationStyle:MMProgressHUDPresentationStyleFade];
    [MMProgressHUD show];
    
    NSDictionary * paramDic = [param yy_modelToJSONObject];
    
    [LJBHTTPTool get:kArticleURL params:paramDic success:^(id response) {
        
        NSArray * resultArr = response[@"result"];
        
        NSMutableArray * articleFrames = [NSMutableArray array];
        
        for (NSDictionary * artDic in resultArr) {
            
            LJBArticle * article = [LJBArticle yy_modelWithDictionary:artDic];
            
            LJBArticleFrame * articleF = [LJBArticleFrame frameWithArticle:article];
            
            [articleFrames addObject:articleF];
        }
        
        // 回传数据
        if (successBlock) {
            successBlock(articleFrames);
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
