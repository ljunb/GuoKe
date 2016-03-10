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
#import "LJBArticle.h"
#import "LJBArticle+LJBRequest.h"
#import "LJBDBTool.h"
#import <Masonry.h>
#import <MJRefresh.h>

#define ArticleHTML @"http://jingxuan.guokr.com/pick/v2/%@/"

@interface LJBArticleInfoController () <LJBCommentViewDelegate>
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
/**
 *  加载文章详情的UIWebView
 */
@property (nonatomic, strong) UIWebView * webView;
/**
 *  文章模型
 */
@property (nonatomic, strong) LJBArticle * article;

@end

@implementation LJBArticleInfoController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // 检查是否已收藏
    [self checkArticleLikeStatus];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupNavigationItems];
    
    [self setupWebView];
    
    [self setupCommentView];
    
    [self fetchArticleInfo];
    
    self.view.backgroundColor = [UIColor whiteColor];
}

#pragma mark - 检查是否收藏
- (void)checkArticleLikeStatus {
    
    if ([[LJBDBTool sharedDB] isExistArticleWithID:self.articleID]) {   // 已收藏过文章
        
        self.favoriteBtn.selected = YES;
        
    } else {
        
        self.favoriteBtn.selected = NO;
    }
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
    
    // 下拉刷新
    self.webView.scrollView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self.webView.scrollView.mj_header endRefreshing];
    }];
}

#pragma mark - 创建评论view
- (void)setupCommentView {
    
    // 带回调block的初始化方法
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
    
    NSLog(@"点击了评论view");
}

#pragma mark - 获取文章数据
- (void)fetchArticleInfo {
    
    [LJBArticle fetchArticleDetailWithID:self.articleID completionBlock:^(id response) {
        
        _article = (LJBArticle *)response;
        
        [self handleHTML];
        
    } failureBlock:^(NSError *error) {
        NSLog(@"Fetch article info error : %@", error);
    }];
}


#pragma mark - Event response

#warning 未完成处理
#pragma mark - 处理HTML
- (void)handleHTML {
    
    // 图片属性
    NSString * imageHTML = [NSString stringWithFormat:@"<img src=\"%@\" width = \"303\" height = \"180\">", _article.headline_img_tb];
    
    // 创建日期
    NSDateFormatter * fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd HH:mm";
    
    NSDate * date = [NSDate dateWithTimeIntervalSince1970:[_article.date_created longLongValue]];
    NSString * dateStr = [fmt stringFromDate:date];
    
    // <h1 style="font-family:verdana;">A heading</h1>
//    <p style="font-family:arial;color:red;font-size:20px;">A paragraph.</p>
    // 作者 . 日期
    NSString * authorAndDate = [NSString stringWithFormat:@"%@ . %@", _article.author, dateStr];
    
//    NSString * authorHTML = [NSString stringWithFormat:@"<p style=\"font-family:arial;color:gray;font-size:20px;\">%@</p>", authorAndDate];

    NSString * authorHTML = @"<div>测试</div>";
    
    // 最终拼接的HTML
    NSString * finalHTML = [NSString stringWithFormat:@"%@%@%@", imageHTML, _article.content, authorHTML];
    
    [self.webView loadHTMLString:finalHTML baseURL:nil];
}

#pragma mark 分享
- (void)didClickShareItem {
    NSLog(@"click share item");
}

#pragma mark 收藏
- (void)didClickFavoriteItem {
    
    self.favoriteBtn.selected = !self.favoriteBtn.selected;
    
    if (self.favoriteBtn.selected) {    // 收藏
        
        [[LJBDBTool sharedDB] likeArticle:self.article];
        
    } else {                            // 取消收藏
        
        [[LJBDBTool sharedDB] dislikeArticle:self.article];
    }
    
    NSLog(@"%@", [[LJBDBTool sharedDB] getAllLikeArticles]);
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
