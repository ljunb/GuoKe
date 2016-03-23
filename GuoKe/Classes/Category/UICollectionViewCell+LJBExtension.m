//
//  UICollectionViewCell+LJBExtension.m
//  GuoKe
//
//  Created by CookieJ on 16/3/23.
//  Copyright © 2016年 ljunb. All rights reserved.
//

#import "UICollectionViewCell+LJBExtension.h"

@implementation UICollectionViewCell (LJBExtension)

- (void)configCell:(UICollectionViewCell *)cell object:(id)obj indexPath:(NSIndexPath *)indexPath {
    
}

+ (CGSize)getSizeWithObject:(id)obj indexPath:(NSIndexPath *)indexPath {
    return obj ? CGSizeMake(100, 100): CGSizeZero;
}

@end
