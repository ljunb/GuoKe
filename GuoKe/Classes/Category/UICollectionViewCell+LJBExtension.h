//
//  UICollectionViewCell+LJBExtension.h
//  GuoKe
//
//  Created by CookieJ on 16/3/23.
//  Copyright © 2016年 ljunb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UICollectionViewCell (LJBExtension)

- (void)configCell:(UICollectionViewCell *)cell object:(id)obj indexPath:(NSIndexPath *)indexPath;

+ (CGSize)getSizeWithObject:(id)obj indexPath:(NSIndexPath *)indexPath;

@end
