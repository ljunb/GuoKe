//
//  LJBArticleCommentListController.m
//  GuoKe
//
//  Created by CookieJ on 16/1/15.
//  Copyright © 2016年 ljunb. All rights reserved.
//

#import "LJBArticleCommentListController.h"
#import "LJBCommentView.h"

@interface LJBArticleCommentListController () <LJBCommentViewDelegate>

@end

@implementation LJBArticleCommentListController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupCommentView];
    
    self.view.backgroundColor = [UIColor whiteColor];
}

#pragma mark - 创建评论view
- (void)setupCommentView {
    
    LJBCommentView * comment = [[LJBCommentView alloc] init];
    comment.delegate = self;
    [self.view addSubview:comment];
    
    [comment mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.bottom.and.right.equalTo(self.view);
        make.height.equalTo(@44);
    }];
}

#pragma mark - LJBCommentViewDelegate
- (void)commentViewDidClick:(LJBCommentView *)commentView {
    LJBLog(@"点击了评论列表评论view");
}

@end
