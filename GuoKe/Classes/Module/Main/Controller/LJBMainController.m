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
#import "LJBArticleCell.h"
#import "UIColor+LJBExtension.h"
#import <Masonry.h>
#import <CHTCollectionViewWaterfallLayout.h>

static CGFloat const kLayoutSectionInset                = 10;
static CGFloat const kLayoutColumnAndInteritemSpacing   = 10;
static NSString * const kLJBArticleCellIdentifier       = @"LJBArticleCell";

@interface LJBMainController () <UICollectionViewDataSource, UICollectionViewDelegate, CHTCollectionViewDelegateWaterfallLayout>

@property (nonatomic, strong) NSMutableArray * articleFrames;

@property (nonatomic, strong) UICollectionView * collectionView;

@end

@implementation LJBMainController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];

    [self setupCollectionView];
    
    [self registerCell];
    
    [self fetchLatestArticle];
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
    
    [self.collectionView registerClass:[LJBArticleCell class]
            forCellWithReuseIdentifier:kLJBArticleCellIdentifier];
}

#pragma mark - 请求最新精选文章
- (void)fetchLatestArticle {
    
    [LJBArticle fetchLatestArticleWithCompletionBlock:^(id response) {
        
        // 移除旧文章
        if (self.articleFrames.count) {
            [self.articleFrames removeAllObjects];
        }
        
        NSArray * articleArr = (NSArray *)response;
        
        for (LJBArticle * article in articleArr) {
            
            LJBArticleFrame * articleF = [[LJBArticleFrame alloc] init];
            articleF.article = article;
            
            [self.articleFrames addObject:articleF];
        }
        
        // 刷新视图
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.collectionView reloadData];
        });
        
        // 缓存数据
        
    } failureBlock:^(NSError *error) {
        
        NSLog(@"Fetch articles failed : %@", error);

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
