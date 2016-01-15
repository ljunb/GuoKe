//
//  LJBDBTool.h
//  GuoKe
//
//  Created by CookieJ on 16/1/14.
//  Copyright © 2016年 ljunb. All rights reserved.
//  数据库工具类

#import <Foundation/Foundation.h>
@class LJBArticleFrame;
@class LJBArticle;

@interface LJBDBTool : NSObject

/**
 *  数据库单例
 *
 *  @return 共享的数据库单例
 */
+ (instancetype)sharedDB;

/**
 *  存储文章数据
 *
 *  @param article 文章模型
 */
- (void)storeArticle:(LJBArticleFrame *)articleF;

/**
 *  获取所有缓存的数据
 *
 *  @return 文章数组
 */
- (NSArray *)getAllArticles;

/**
 *  清空所有缓存数据
 */
- (void)removeAllAritcles;


/**
 *  是否已收藏
 */
- (BOOL)isExistArticleWithID:(NSString *)article_id;


/**
 *  收藏文章
 */
- (void)likeArticle:(LJBArticle *)article;

/**
 *  取消收藏
 */
- (void)dislikeArticle:(LJBArticle *)article;

/**
 *  获得所有收藏
 */
- (NSArray *)getAllLikeArticles;

@end
