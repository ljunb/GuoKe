//
//  LJBArticleFrame.h
//  GuoKe
//
//  Created by 林俊炳 on 16/1/13.
//  Copyright © 2016年 ljunb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <UIKit/UIKit.h>
#import "UIFont+LJBExtension.h"

@class LJBArticle;



@interface LJBArticleFrame : NSObject

@property (nonatomic, strong) LJBArticle * article;

@property (nonatomic, assign) CGRect imageF;

@property (nonatomic, assign) CGRect titleF;

@property (nonatomic, assign) CGRect lineF;

@property (nonatomic, assign) CGRect sourceF;

@property (nonatomic, assign) CGRect timeF;

@property (nonatomic, assign) CGSize cellSize;

@end
