//
//  LJBFavoriteController.m
//  GuoKe
//
//  Created by 林俊炳 on 16/1/12.
//  Copyright © 2016年 ljunb. All rights reserved.
//

#import "LJBFavoriteController.h"
#import "LJBLikeArticleCell.h"
#import "LJBArticle.h"
#import "LJBDBTool.h"
#import "LJBArticleInfoController.h"
#import <Masonry.h>

static NSString * const kLJBLikeArticleCellIdentifier = @"LJBLikeArticleCell";

@interface LJBFavoriteController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView * tableView;

@property (nonatomic, copy) NSArray * artitles;

@end

@implementation LJBFavoriteController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self getAllLikeArticles];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];

    [self setupTableView];
    
    [self registerCell];
}

#pragma mark - 适配UITableView
- (void)setupTableView {
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

#pragma mark - 注册cell
- (void)registerCell {
    
    [self.tableView registerClass:[LJBLikeArticleCell class]
           forCellReuseIdentifier:kLJBLikeArticleCellIdentifier];
}

#pragma mark - 读取所有收藏的文章
- (void)getAllLikeArticles {
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
    
        // 读取数据
        self.artitles = [[LJBDBTool sharedDB] getAllLikeArticles];
    
        // 主线程更新UI
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.tableView reloadData];
        });
    });
}

#pragma mark - UITableVieWDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.artitles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LJBArticle * article = self.artitles[indexPath.row];
    
    LJBLikeArticleCell * cell = [tableView dequeueReusableCellWithIdentifier:kLJBLikeArticleCellIdentifier
                                                                forIndexPath:indexPath];
    [cell configCellWithArticle:article];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LJBArticle * article = self.artitles[indexPath.row];
    
    LJBArticleInfoController * articleInfoVC = [[LJBArticleInfoController alloc] init];
    
    articleInfoVC.articleID = article.articleID;
    
    [self.navigationController pushViewController:articleInfoVC animated:YES];
}

#pragma mark - getter
- (UITableView *)tableView {
    
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.bounces = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.rowHeight = UITableViewAutomaticDimension;
        _tableView.estimatedRowHeight = 80;
        _tableView.tableFooterView = [[UIView alloc] init];
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

@end
