//
//  LJBArticle.h
//  GuoKe
//
//  Created by 林俊炳 on 16/1/13.
//  Copyright © 2016年 ljunb. All rights reserved.
//  精选文章模型


#import <Foundation/Foundation.h>
#import <YYModel.h>

@interface LJBArticle : NSObject <YYModel>

@property (nonatomic, copy) NSString * articleID;

@property (nonatomic, copy) NSString * headline_img_tb;

@property (nonatomic, copy) NSString * title;

@property (nonatomic, copy) NSString * source_name;

@property (nonatomic, copy) NSString * date_picked;

/**
 *  保存挑选时间原始时间戳
 */
@property (nonatomic, copy) NSString * sourcePickedDate;

/**
 *  是否收藏
 */
@property (nonatomic, copy) NSString * favorite;

@end
