//
//  LJBMainTableDataSourceSeparation.h
//  GuoKe
//
//  Created by CookieJ on 16/3/23.
//  Copyright © 2016年 ljunb. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CellConfigBlock)(NSIndexPath *indexPath, id obj, UICollectionViewCell * cell);
typedef void(^CellSelectedBlock)(NSIndexPath *indexPath, id obj);
typedef CGSize(^CellSizeBlock)(NSIndexPath *indexPath);

@interface LJBMainTableDataSourceSeparation : NSObject

- (instancetype)initWithDataSource:(NSArray *)dataSource
                    cellIdentifier:(NSString *)cellIdentifier
                       configBlock:(CellConfigBlock)configBlock
                     selectedBlock:(CellSelectedBlock)selectedBlock
                         sizeBlock:(CellSizeBlock)sizeBlock;

- (void)setupDelegateAndDataSourceWithCollectionView:(UICollectionView *)collectionView;

@end
