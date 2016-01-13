//
//  LJBArticleParam.h
//  GuoKe
//
//  Created by 林俊炳 on 16/1/13.
//  Copyright © 2016年 ljunb. All rights reserved.
//  请求参数模型
/**
 *  retrieve_type=by_since&since=&orientation=before&category=all&ad=1
 */

#import <Foundation/Foundation.h>

@interface LJBArticleParam : NSObject

@property (nonatomic, copy) NSString * retrieve_type;
@property (nonatomic, copy) NSString * since;
@property (nonatomic, copy) NSString * orientation;
@property (nonatomic, copy) NSString * category;
@property (nonatomic, copy) NSString * ad;

@end
