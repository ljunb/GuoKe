//
//  LJBDBTool.m
//  GuoKe
//
//  Created by CookieJ on 16/1/14.
//  Copyright © 2016年 ljunb. All rights reserved.
/**
 *  @property (nonatomic, copy) NSString * headline_img_tb;
 
 @property (nonatomic, copy) NSString * title;
 
 @property (nonatomic, copy) NSString * source_name;
 
 @property (nonatomic, copy) NSString * date_picked;
 
 @property (nonatomic, copy) NSString * date_created;
 */

#import "LJBDBTool.h"
#import <FMDatabase.h>
#import "LJBArticleFrame.h"
#import "LJBArticle.h"


@implementation LJBDBTool
{
    FMDatabase * _fmDataBase;
}

#pragma mark - 创建单例
static LJBDBTool * dbTool = nil;
+ (instancetype)sharedDB {
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        dbTool = [[LJBDBTool alloc] init];
    });
    
    return dbTool;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    
    if (!dbTool) {
        dbTool = [super allocWithZone:zone];
    }
    
    return dbTool;
}

- (instancetype)init {
    
    if (self = [super init]) {
        [self createDB];
    }
    return self;
}

#pragma mark - 创建数据库
- (void)createDB {
    
    NSString * docPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    
    NSString * dbPath = [docPath stringByAppendingPathComponent:@"db_guoke.sqlite"];
    
    _fmDataBase = [FMDatabase databaseWithPath:dbPath];
    
    if ([_fmDataBase open]) {
        
        NSLog(@"成功创建数据库db_guoke.sqlite");
        
        [self createTable];
    }
}

#pragma mark - 创建数据表
- (void)createTable {
    
    NSString * createSQL = @"create table if not exists t_article (id integer primary key autoincrement, title text, source_name text, headline_img_tb text, date_picked text, favorite text)";
    
    if ([_fmDataBase executeUpdate:createSQL]) {
        
        NSLog(@"成功创建表t_article");
    }
    
}

#pragma mark - 保存数据
- (void)storeArticle:(LJBArticleFrame *)articleF {
    
    LJBArticle * article = articleF.article;
    
    NSString * insertSQL = @"insert into t_article (title, source_name, headline_img_tb, date_picked, favorite) values (?, ?, ?, ?, ?)";
    
    BOOL success;
    
    @synchronized(self) {
        success = [_fmDataBase executeUpdate:insertSQL, article.title, article.source_name, article.headline_img_tb, article.date_picked, article.favorite];
    }
    
    if (!success) {
        NSLog(@"插入失败！");
    }
}

#pragma mark - 查询所有缓存数据
- (NSArray *)getAllArticles {
    
    NSString * querySQL = @"select * from t_article";
    
    FMResultSet * result;
    
    @synchronized(self) {
        result = [_fmDataBase executeQuery:querySQL];
    }
    
    NSMutableArray * articleFs = [NSMutableArray array];
    
    while ([result next]) {
        
        LJBArticle * article    = [[LJBArticle alloc] init];
        article.title           = [result objectForColumnName:@"title"];
        article.date_picked     = [result objectForColumnName:@"date_picked"];
        article.source_name     = [result objectForColumnName:@"source_name"];
        article.headline_img_tb = [result objectForColumnName:@"headline_img_tb"];
        article.favorite        = [result objectForColumnName:@"favorite"];
        
        LJBArticleFrame * articleF = [[LJBArticleFrame alloc] init];
        articleF.article = article;
        
        [articleFs addObject:articleF];
    }
    
    return articleFs;
}

#pragma mark - 清空缓存数据
- (void)removeAllAritcles {
    
    NSString * deleteSQL = @"delete from t_article";
    
    BOOL success;
    
    @synchronized(self) {
        success = [_fmDataBase executeUpdate:deleteSQL];
    }
    
    if (!success) {
        NSLog(@"无法清空缓存数据！");
    }
}

@end
