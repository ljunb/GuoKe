//
//  LJBArticleCell.m
//  GuoKe
//
//  Created by 林俊炳 on 16/1/13.
//  Copyright © 2016年 ljunb. All rights reserved.
//

#import "LJBArticleCell.h"
#import "LJBArticleFrame.h"
#import "LJBArticle.h"
#import "LJBButton.h"
#import "UIView+LJBExtension.h"
#import <Masonry.h>
#import <UIImageView+WebCache.h>


@interface LJBArticleCell ()

@property (nonatomic, strong) UIImageView * headImage;

@property (nonatomic, strong) UIView * titleBgView;

@property (nonatomic, strong) UILabel * title;

@property (nonatomic, strong) UIView * line;

@property (nonatomic, strong) LJBButton * source;

@property (nonatomic, strong) LJBButton * time;

@end

@implementation LJBArticleCell

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

#pragma mark - 创建子控件
- (void)setupSubviews {
    
    self.headImage.frame = _articleF.imageF;
    
    self.titleBgView.frame = _articleF.titleBgF;
    
    self.title.frame     = _articleF.titleF;
    
    self.line.frame      = _articleF.lineF;
    
    self.source.frame    = _articleF.sourceF;
    
    self.time.frame      = _articleF.timeF;
}

- (void)setArticleF:(LJBArticleFrame *)articleF {
    
    _articleF = articleF;
    
    [self setupSubviews];
    
    [self.headImage sd_setImageWithURL:[NSURL URLWithString:articleF.article.headline_img_tb]];
    
    self.title.text = _articleF.article.title;
    
    [self.source setTitle:_articleF.article.source_name forState:UIControlStateDisabled];
    [self.source setImage:[UIImage imageNamed:@"icon_source"] forState:UIControlStateDisabled];
    
    [self.time setTitle:_articleF.article.date_picked forState:UIControlStateDisabled];
    [self.time setImage:[UIImage imageNamed:@"icon_time"] forState:UIControlStateDisabled];
    
    NSLog(@"%@", _articleF.article.date_picked);
    
    // 设置圆角
    [self setCornerRadii:CGSizeMake(5, 5) roundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight fromView:self.headImage];
    [self setCornerRadii:CGSizeMake(5, 5) roundingCorners:UIRectCornerBottomLeft fromView:self.source];
    [self setCornerRadii:CGSizeMake(5, 5) roundingCorners:UIRectCornerBottomRight fromView:self.time];
}

#pragma mark - private method
- (void)setCornerRadii:(CGSize)size roundingCorners:(UIRectCorner)corner fromView:(UIView *)view {
    
    UIBezierPath * path = [UIBezierPath bezierPathWithRoundedRect:view.bounds
                                                byRoundingCorners:corner
                                                      cornerRadii:size];
    CAShapeLayer * layer = [[CAShapeLayer alloc] init];
    layer.frame = view.bounds;
    layer.path = path.CGPath;
    
    view.layer.mask = layer;
}


#pragma mark - getter
- (UIImageView *)headImage {
    
    if (!_headImage) {
        _headImage = [[UIImageView alloc] init];
        _headImage.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:_headImage];
    }
    return _headImage;
}

- (UIView *)titleBgView {
    
    if (!_titleBgView) {
        _titleBgView = [[UIView alloc] init];
        _titleBgView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:_titleBgView];
    }
    return _titleBgView;
}

- (UILabel *)title {
    
    if (!_title) {
        _title = [[UILabel alloc] init];
        _title.backgroundColor = [UIColor whiteColor];
        _title.numberOfLines = 0;
        _title.font = [UIFont fontOfTitle];
        [self.contentView addSubview:_title];
    }
    return _title;
}

- (UIView *)line {
    
    if (!_line) {
        _line = [[UIView alloc] init];
        _line.backgroundColor = [UIColor lightGrayColor];
        _line.alpha = 0.5;
        [self.contentView addSubview:_line];
    }
    return _line;
}

- (LJBButton *)source {
    
    if (!_source) {
        _source = [[LJBButton alloc] init];
        [_source setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
        _source.titleLabel.font = [UIFont systemFontOfSize:10];
        _source.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        _source.enabled = NO;
        _source.backgroundColor = [UIColor whiteColor];
        _source.type = LJBButtonLeftType;
        [self.contentView addSubview:_source];
    }
    return _source;
}

- (LJBButton *)time {
    
    if (!_time) {
        _time = [[LJBButton alloc] init];
        [_time setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
        _time.titleLabel.font = [UIFont systemFontOfSize:10];
        _time.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        _time.enabled = NO;
        _time.backgroundColor = [UIColor whiteColor];
        _time.type = LJBButtonRightType;
        [self.contentView addSubview:_time];
    }
    return _time;
}


@end
