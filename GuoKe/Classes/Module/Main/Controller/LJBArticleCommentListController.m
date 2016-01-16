//
//  LJBArticleCommentListController.m
//  GuoKe
//
//  Created by CookieJ on 16/1/15.
//  Copyright © 2016年 ljunb. All rights reserved.
//

#import "LJBArticleCommentListController.h"
#import "LJBCommentView.h"
#import <Masonry.h>

@interface LJBArticleCommentListController ()

@end

@implementation LJBArticleCommentListController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupCommentView];
    
    self.view.backgroundColor = [UIColor whiteColor];
}

#pragma mark - 创建评论view
- (void)setupCommentView {
    
    // 带回调block的初始化方法
    LJBCommentView * comment = [[LJBCommentView alloc] initWithHandleBlock:^{
        NSLog(@"=====");
    }];
    
    [self.view addSubview:comment];
    [comment mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.bottom.and.right.equalTo(self.view);
        make.height.equalTo(@44);
    }];
}

@end