//
//  LJBArticleInfoController.m
//  GuoKe
//
//  Created by CookieJ on 16/1/15.
//  Copyright © 2016年 ljunb. All rights reserved.
//  文章详情VC

#import "LJBArticleInfoController.h"
#import "UIBarButtonItem+LJBExtension.h"
#import "UIView+LJBExtension.h"
#import "LJBCommentView.h"
#import "LJBArticleCommentListController.h"
#import <Masonry.h>

#define ArticleHTML @"http://jingxuan.guokr.com/pick/v2/%@/"

@interface LJBArticleInfoController ()
/**
 *  分享
 */
@property (nonatomic, strong) UIBarButtonItem * shareItem;
/**
 *  收藏
 */
@property (nonatomic, strong) UIButton * favoriteBtn;
/**
 *  评论
 */
@property (nonatomic, strong) UIBarButtonItem * commentItem;

@property (nonatomic, strong) UIWebView * webView;

@end

@implementation LJBArticleInfoController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupNavigationItems];
    
    [self setupWebView];
    
    [self setupCommentView];
    
    self.view.backgroundColor = [UIColor whiteColor];
}

#pragma mark - 导航栏右边按钮数组
- (void)setupNavigationItems {
    
    // 缩小右边空格
    UIBarButtonItem * fixRightSpaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    fixRightSpaceItem.width = -5;
    
    // 每个item间隔
    UIBarButtonItem * spaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    spaceItem.width = 20;
    
    UIBarButtonItem * favoriteItem = [[UIBarButtonItem alloc] initWithCustomView:self.favoriteBtn];
    
    self.navigationItem.rightBarButtonItems = @[fixRightSpaceItem, self.commentItem, spaceItem, favoriteItem, spaceItem, self.shareItem];
}

#pragma mark - webview
- (void)setupWebView {
    
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(0, 0, 44, 0));
    }];
    
    self.webView.backgroundColor = [UIColor redColor];
    
    NSString * urlStr = [NSString stringWithFormat:ArticleHTML, self.articleID];
    NSURL * baseURL = [NSURL URLWithString:urlStr];
    NSString * HTMLString = [NSString stringWithContentsOfURL:baseURL encoding:NSUTF8StringEncoding error:nil];
    
    [self.webView loadHTMLString:HTMLString baseURL:baseURL];
    
}

#pragma mark - 创建评论view
- (void)setupCommentView {
    
    // 带回调block的初始化方法
    LJBCommentView * comment = [[LJBCommentView alloc] initWithHandleBlock:^{
        NSLog(@"-----");
    }];
    
    [self.view addSubview:comment];
    [comment mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.bottom.and.right.equalTo(self.view);
        make.height.equalTo(@44);
    }];
}

#pragma mark - Event response
#pragma mark 分享
- (void)didClickShareItem {
    NSLog(@"click share item");
}

#pragma mark 收藏
- (void)didClickFavoriteItem {
    
    self.favoriteBtn.selected = !self.favoriteBtn.selected;
}

#pragma mark 评论
- (void)didClickCommentItem {
    
    LJBArticleCommentListController * commentListVC = [[LJBArticleCommentListController alloc] init];
    commentListVC.title = @"评论";
    
    [self.navigationController pushViewController:commentListVC animated:YES];
}


#pragma mark - getter
- (UIWebView *)webView {
    
    if (!_webView) {
        _webView = [[UIWebView alloc] init];
        [self.view addSubview:_webView];
    }
    return _webView;
}


- (UIBarButtonItem *)shareItem {
    
    if (!_shareItem) {
        _shareItem = [UIBarButtonItem itemWithTarget:self
                                              Action:@selector(didClickShareItem)
                                         normalImage:@"article_btn_share"
                                     hightlightImage:@"article_btn_share_press"];
    }
    return _shareItem;
}

- (UIButton *)favoriteBtn {
    
    if (!_favoriteBtn) {
        _favoriteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_favoriteBtn setBackgroundImage:[UIImage imageNamed:@"article_btn_like"]
                                forState:UIControlStateNormal];
        [_favoriteBtn setBackgroundImage:[UIImage imageNamed:@"article_btn_like_press"]
                                forState:UIControlStateSelected];
        _favoriteBtn.size = _favoriteBtn.currentBackgroundImage.size;
        _favoriteBtn.adjustsImageWhenHighlighted = NO;
        [_favoriteBtn addTarget:self
                         action:@selector(didClickFavoriteItem)
               forControlEvents:UIControlEventTouchDown];
    }
    return _favoriteBtn;
}

- (UIBarButtonItem *)commentItem {
    
    if (!_commentItem) {
        _commentItem = [UIBarButtonItem itemWithTarget:self
                                                Action:@selector(didClickCommentItem)
                                           normalImage:@"article_nav_review_press"
                                       hightlightImage:@"article_nav_review"];
    }
    return _commentItem;
}

@end
