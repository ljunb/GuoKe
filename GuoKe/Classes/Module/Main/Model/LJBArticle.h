//
//  LJBArticle.h
//  GuoKe
//
//  Created by 林俊炳 on 16/1/13.
//  Copyright © 2016年 ljunb. All rights reserved.
//  精选文章模型

/**
 *  "category": "humanities",
 "link_v2_sync_img": "http://jingxuan.guokr.com/pick/v2/17135/sync/",
 "source_name": "十五言",
 "title": "这种美男子，夹在直男和gay之间",
 "page_source": "http://jingxuan.guokr.com/pick/17135/?ad=1",
 "images": [],
 "author": "绿流dr",
 "date_picked": 1452816026,
 "reply_root_id": 0,
 "summary": "一、 禁欲系美男是怎样的人 “禁欲系美男”，我很难找到他的反义词，只能粗略地描述为这是介于直男和ga",
 "content":

 */


#import <Foundation/Foundation.h>
#import <YYModel.h>

@interface LJBArticle : NSObject <YYModel>

@property (nonatomic, copy) NSString * articleID;

@property (nonatomic, copy) NSString * headline_img_tb;

@property (nonatomic, copy) NSString * title;

@property (nonatomic, copy) NSString * source_name;

@property (nonatomic, copy) NSString * date_picked;

@property (nonatomic, copy) NSString * date_created;

@property (nonatomic, copy) NSString * author;

@property (nonatomic, copy) NSString * summary;

@property (nonatomic, copy) NSString * content;

/**
 *  保存挑选时间原始时间戳
 */
@property (nonatomic, copy) NSString * sourcePickedDate;


@end
