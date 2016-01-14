//
//  LJBMainController.m
//  GuoKe
//
//  Created by 林俊炳 on 16/1/12.
//  Copyright © 2016年 ljunb. All rights reserved.
//

#import "LJBMainController.h"
#import "LJBArticle+LJBRequest.h"
#import "LJBArticleFrame.h"
#import "LJBArticle.h"
#import "LJBArticleCell.h"
#import "UIColor+LJBExtension.h"
#import "LJBArticleParam.h"
#import "LJBHTTPTool.h"
#import "LJBDBTool.h"
#import <Masonry.h>
#import <MJRefresh.h>
#import <CHTCollectionViewWaterfallLayout.h>

static CGFloat const kLayoutSectionInset                = 10;
static CGFloat const kLayoutColumnAndInteritemSpacing   = 10;
static NSString * const kLJBArticleCellIdentifier       = @"LJBArticleCell";

@interface LJBMainController () <UICollectionViewDataSource, UICollectionViewDelegate, CHTCollectionViewDelegateWaterfallLayout>

@property (nonatomic, strong) NSMutableArray * articleFrames;

@property (nonatomic, strong) UICollectionView * collectionView;

@end

@implementation LJBMainController

#pragma mark - Life Cycle
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // 检测网络状态
    [self checkNetwork];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];

    [self setupCollectionView];
    
    [self registerCell];
    
    [self addRefresh];
}

#pragma mark - 初始化UICollectionView
- (void)setupCollectionView {
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsZero);
    }];
    self.collectionView.backgroundColor = [UIColor articleCollectionViewBackgroundColor];
}

#pragma mark - 注册cell
- (void)registerCell {
    
    [self.collectionView registerClass:[LJBArticleCell class] forCellWithReuseIdentifier:kLJBArticleCellIdentifier];
}

#pragma mark - 添加上/拉刷新  
- (void)addRefresh {
    
    // 下拉刷新
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self fetchLatestArticle];
    }];
    
    // 上拉加载更多
    self.collectionView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
        
        // 取出当前最后一篇文章
        LJBArticleFrame * lastArticleF = self.articleFrames.lastObject;
        
        // 参数模型
        LJBArticleParam * param = [LJBArticleParam paramWithSincePickedDate:lastArticleF.article.date_created];
        
        [self fetchMoreArticleWithParam:param];
    }];
}

#pragma mark - 请求最新精选文章
- (void)fetchLatestArticle {
    
    [LJBArticle fetchLatestArticleWithCompletionBlock:^(id response) {
        
        // 移除旧文章
        if (self.articleFrames.count) {
            [self.articleFrames removeAllObjects];
        }
        
        [self.articleFrames addObjectsFromArray:response];
        
        // 刷新视图
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.collectionView reloadData];
            
            [self.collectionView.mj_header endRefreshing];
        });
        
        // 缓存数据
        [self storeArticles];
        
    } failureBlock:^(NSError *error) {
        
        NSLog(@"Fetch articles failed : %@", error);

        [self.collectionView.mj_header endRefreshing];
    }];
}

#pragma mark - 请求更多精选文章
- (void)fetchMoreArticleWithParam:(LJBArticleParam *)param {
    
    [LJBArticle fetchMoreArticleWithParam:param completionBlock:^(id response) {
        
        [self.articleFrames addObjectsFromArray:response];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.collectionView reloadData];
            
            [self.collectionView.mj_footer endRefreshing];
        });
        
        // 缓存数据
        [self storeArticles];
        
    } failureBlock:^(NSError *error) {
        
        NSLog(@"Fetch more articles failed : %@", error);
        
        [self.collectionView.mj_footer endRefreshing];
    }];
}

#pragma mark - UICollectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.articleFrames.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    LJBArticleCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:kLJBArticleCellIdentifier forIndexPath:indexPath];
    
    cell.articleF = self.articleFrames[indexPath.item];
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    LJBArticleFrame * articleF = self.articleFrames[indexPath.item];
    
    return articleF.cellSize;
}

#pragma mark - 检测网络
- (void)checkNetwork {
    
    [LJBHTTPTool checkNetworkWithConnected:^{
        
        // 当前网络连接正常，获取最新数据
        [self fetchLatestArticle];
        
    } disconnected:^{
        
        // 当前无网络，从数据库缓存中读取数据
        [self getCachedArticle];
    }];
}

#pragma mark - 缓存数据
- (void)storeArticles {
    
    // 清空原数据
    [[LJBDBTool sharedDB] removeAllAritcles];
    
    // 缓存数据
    for (LJBArticleFrame * articleF in self.articleFrames) {
        
        [[LJBDBTool sharedDB] storeArticle:articleF];
    }
}

#pragma mark - 从数据库获取数据
- (void)getCachedArticle {

    // 移除原数据
    if (self.articleFrames.count) {
        [self.articleFrames removeAllObjects];
    }
    
    [self.articleFrames addObjectsFromArray:[[LJBDBTool sharedDB] getAllArticles]];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.collectionView reloadData];
    });
}


#pragma mark - getter
- (NSMutableArray *)articleFrames {
    
    if (!_articleFrames) {
        _articleFrames = [NSMutableArray array];
    }
    return _articleFrames;
}

- (UICollectionView *)collectionView {
    
    if (!_collectionView) {
        
        // 初始化第三方layout
        CHTCollectionViewWaterfallLayout * layout = [[CHTCollectionViewWaterfallLayout alloc] init];
        layout.sectionInset = UIEdgeInsetsMake(kLayoutSectionInset, kLayoutSectionInset, kLayoutSectionInset, kLayoutSectionInset);
        layout.minimumColumnSpacing     = kLayoutColumnAndInteritemSpacing; // cell水平间距
        layout.minimumInteritemSpacing  = kLayoutColumnAndInteritemSpacing; // cell垂直间距
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        
        [self.view addSubview:_collectionView];
    }
    return _collectionView;
}

@end
