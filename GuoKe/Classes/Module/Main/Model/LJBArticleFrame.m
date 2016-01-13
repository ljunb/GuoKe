//
//  LJBArticleFrame.m
//  GuoKe
//
//  Created by 林俊炳 on 16/1/13.
//  Copyright © 2016年 ljunb. All rights reserved.
//

#import "LJBArticleFrame.h"
#import "LJBArticle.h"

#define LJBScreenSize [UIScreen mainScreen].bounds.size
#define ImageFinalWidth (LJBScreenSize.width - 10 * 3) / 2

static CGFloat const kTitleLeftMargin      = 5;
static CGFloat const kImageAndTitleMargin  = 10;
static CGFloat const kTitleAndSourceMargin = 6;

static CGFloat const kImageDefaultWidth    = 288;
static CGFloat const kImageDefaultHeight   = 192;

@implementation LJBArticleFrame

- (void)setArticle:(LJBArticle *)article {
    
    _article = article;
    
    [self configImageFrame];
    
    [self configTitleFrame];
    
    [self configLineFrame];
    
    [self configSourceAndTimeFrame];
}

- (void)configImageFrame {
    
    CGFloat height  = ImageFinalWidth * kImageDefaultHeight / kImageDefaultWidth;
    
    if ([_article.headline_img_tb rangeOfString:@"imageView2/1/"].location != NSNotFound) {
        
        NSArray * component   = [_article.headline_img_tb componentsSeparatedByString:@"/"];
        
        CGFloat sourceWidth   = [component[component.count - 3] floatValue];
        CGFloat sourceHeight  = [component[component.count - 1] floatValue];
        
        height = ImageFinalWidth * sourceHeight / sourceWidth;
    }
    
    _imageF = CGRectMake(0, 0, ImageFinalWidth, height);
}

- (void)configTitleFrame {
    
    CGSize size = [_article.title boundingRectWithSize:CGSizeMake(ImageFinalWidth - 10, MAXFLOAT)
                                               options:NSStringDrawingUsesLineFragmentOrigin
                                            attributes:@{ NSFontAttributeName : [UIFont fontOfTitle] }
                                               context:nil].size;
    
    _titleF = CGRectMake(kTitleLeftMargin, CGRectGetMaxY(_imageF) + kImageAndTitleMargin, size.width, size.height);
}

- (void)configLineFrame {
    
    _lineF = CGRectMake(0, CGRectGetMaxY(_titleF) + kImageAndTitleMargin, ImageFinalWidth, 1);
}

- (void)configSourceAndTimeFrame {
    
    _sourceF = CGRectMake(kTitleLeftMargin, CGRectGetMaxY(_lineF) + kTitleAndSourceMargin, _imageF.size.width/2, 20);
    
    _timeF = CGRectMake(CGRectGetMaxX(_sourceF), CGRectGetMinY(_sourceF), CGRectGetWidth(_sourceF), CGRectGetHeight(_sourceF));
    
    _cellSize = CGSizeMake(ImageFinalWidth, CGRectGetMaxY(_sourceF) + kTitleAndSourceMargin);
}



@end
