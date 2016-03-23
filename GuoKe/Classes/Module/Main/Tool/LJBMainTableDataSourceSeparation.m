//
//  LJBMainTableDataSourceSeparation.m
//  GuoKe
//
//  Created by CookieJ on 16/3/23.
//  Copyright © 2016年 ljunb. All rights reserved.
//

#import "LJBMainTableDataSourceSeparation.h"
#import <CHTCollectionViewWaterfallLayout.h>

@interface LJBMainTableDataSourceSeparation () <UICollectionViewDataSource, UICollectionViewDelegate, CHTCollectionViewDelegateWaterfallLayout>

@property (nonatomic, strong) NSArray * dataSource;

@property (nonatomic, copy) NSString * cellIdentifier;

@property (nonatomic, copy) CellConfigBlock configBlock;

@property (nonatomic, copy) CellSelectedBlock selectedBlock;

@property (nonatomic, copy) CellSizeBlock sizeBlock;

@end


@implementation LJBMainTableDataSourceSeparation

- (instancetype)initWithDataSource:(NSArray *)dataSource cellIdentifier:(NSString *)cellIdentifier configBlock:(CellConfigBlock)configBlock selectedBlock:(CellSelectedBlock)selectedBlock sizeBlock:(CellSizeBlock)sizeBlock {
    
    if (self = [super init]) {
        self.dataSource = dataSource;
        self.cellIdentifier = cellIdentifier;
        self.configBlock = configBlock;
        self.selectedBlock = selectedBlock;
        self.sizeBlock = sizeBlock;
    }
    return self;
}

- (void)setupDelegateAndDataSourceWithCollectionView:(UICollectionView *)collectionView {
    
    collectionView.delegate = self;
    collectionView.dataSource = self;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return self.sizeBlock(indexPath);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    id obj = self.dataSource[indexPath.item];
    
    [collectionView registerClass:NSClassFromString(self.cellIdentifier) forCellWithReuseIdentifier:self.cellIdentifier];
    
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:self.cellIdentifier forIndexPath:indexPath];

    self.configBlock(indexPath, obj, cell);
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    self.selectedBlock(indexPath, self.dataSource[indexPath.item]);
}

@end
