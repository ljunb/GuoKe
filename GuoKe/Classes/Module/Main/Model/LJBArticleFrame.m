//
//  LJBArticleFrame.m
//  GuoKe
//
//  Created by 林俊炳 on 16/1/13.
//  Copyright © 2016年 ljunb. All rights reserved.
//

#import "LJBArticleFrame.h"
#import "LJBArticle.h"
#import <YYModel.h>

#define LJBScreenSize [UIScreen mainScreen].bounds.size
#define ImageFinalWidth (LJBScreenSize.width - 10 * 3) / 2

static CGFloat const kImageAndTitleMargin  = 10;

static CGFloat const kTitleMaxHeight       = 60;
static CGFloat const kTitleLeftMargin      = 5;

static CGFloat const kSourceHeight         = 28;

@implementation LJBArticleFrame

- (instancetype)initWithArticle:(LJBArticle *)article {
    
    if (self = [super init]) {
        self.article = article;
    }
    return self;
}

+ (instancetype)frameWithArticle:(LJBArticle *)article {
    return [[self alloc] initWithArticle:article];
}


- (void)setArticle:(LJBArticle *)article {
    
    _article = article;
    
    [self configImageFrame];
    
    [self configTitleFrame];
    
    [self configLineFrame];
    
    [self configSourceAndTimeFrame];
}

#pragma mark - 图片frame
- (void)configImageFrame {
    
    // 默认高度
    CGFloat height = ImageFinalWidth;
    
    if ([_article.headline_img_tb rangeOfString:@"imageView2/1/"].location != NSNotFound) {
        
        NSArray * component   = [_article.headline_img_tb componentsSeparatedByString:@"/"];
        
        CGFloat sourceWidth   = [component[component.count - 3] floatValue];
        CGFloat sourceHeight  = [component[component.count - 1] floatValue];
        
        height = ImageFinalWidth * sourceHeight / sourceWidth;
    }
    
    _imageF = CGRectMake(0, 0, ImageFinalWidth, height);
}

#pragma mark - 标题frame
- (void)configTitleFrame {

    
    CGSize size = [_article.title boundingRectWithSize:CGSizeMake(ImageFinalWidth - 10, kTitleMaxHeight)
                                               options:NSStringDrawingUsesLineFragmentOrigin
                                            attributes:@{ NSFontAttributeName : [UIFont fontOfTitle] }
                                               context:nil].size;
    
    _titleF = CGRectMake(kTitleLeftMargin, CGRectGetMaxY(_imageF) + kImageAndTitleMargin, size.width, size.height);
    
}

#pragma mark - 线frame
- (void)configLineFrame {
    
    _lineF = CGRectMake(0, CGRectGetMaxY(_titleF) + kImageAndTitleMargin, ImageFinalWidth, 1);
}

#pragma mark - 来源&时间frame
- (void)configSourceAndTimeFrame {
    
    _sourceF = CGRectMake(0, CGRectGetMaxY(_lineF), _imageF.size.width/2, kSourceHeight);
    
    _timeF = CGRectMake(CGRectGetMaxX(_sourceF), CGRectGetMinY(_sourceF), CGRectGetWidth(_sourceF), CGRectGetHeight(_sourceF));
    
    _titleBgF = CGRectMake(0, CGRectGetMaxY(_imageF), CGRectGetWidth(_imageF), CGRectGetMaxY(_lineF) - CGRectGetMaxY(_imageF));
                           
    // 设置cellSize
    _cellSize = CGSizeMake(ImageFinalWidth, CGRectGetMaxY(_sourceF));
}



@end
