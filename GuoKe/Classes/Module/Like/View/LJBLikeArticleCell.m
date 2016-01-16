//
//  LJBLikeArticleCell.m
//  GuoKe
//
//  Created by CookieJ on 16/1/15.
//  Copyright © 2016年 ljunb. All rights reserved.
//  收藏文章cell

#import "LJBLikeArticleCell.h"
#import "LJBArticle.h"
#import "LJBButton.h"
#import "LJBDateTool.h"
#import <Masonry.h>

static CGFloat const kTitleTopPadding  = 15;
static CGFloat const kTitleLeftPadding = 10;

static CGFloat const kTitleAndSummarySpacing = 15;

@interface LJBLikeArticleCell ()

@property (nonatomic, strong) UILabel * title;
@property (nonatomic, strong) UILabel * summary;
@property (nonatomic, strong) LJBButton * source;
@property (nonatomic, strong) LJBButton * time;

@end

@implementation LJBLikeArticleCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupSubviews];
    }
    return self;
}

#pragma mark - 适配子控件
- (void)setupSubviews {
    
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(kTitleTopPadding));
        make.left.equalTo(@(kTitleLeftPadding));
        make.right.equalTo(@(-kTitleLeftPadding));
    }];
    
    [self.summary mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.title.mas_bottom).offset(kTitleAndSummarySpacing);
        make.left.equalTo(@(kTitleLeftPadding));
        make.right.equalTo(@(-kTitleLeftPadding));
    }];
    
    [self.source mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.summary.mas_bottom).offset(kTitleAndSummarySpacing);
        make.left.equalTo(@(kTitleLeftPadding));
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
    }];
    
    [self.time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.source);
        make.left.equalTo(self.contentView.mas_centerX);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
    }];
    
    // 底部线
    UIView * line = [[UIView alloc] init];
    line.backgroundColor = [UIColor lightGrayColor];
    [self.contentView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.title);
        make.bottom.equalTo(self.contentView);
        make.height.equalTo(@0.5);
    }];
}

#pragma mark - 设置cell内容
- (void)configCellWithArticle:(LJBArticle *)article {
    
    // 标题
    self.title.text = article.title;
    
    // 简介
    self.summary.text = article.summary;
    
    // 文章来源
    [self.source setTitle:article.source_name forState:UIControlStateDisabled];
    [self.source setImage:[UIImage imageNamed:@"icon_source"] forState:UIControlStateDisabled];
    
    // 文章挑选时间
    NSString * customDate = [LJBDateTool customDateWithOriginDateString:article.date_picked];
    [self.time setTitle:customDate forState:UIControlStateDisabled];
    [self.time setImage:[UIImage imageNamed:@"icon_time"] forState:UIControlStateDisabled];
}

#pragma mark - getter
- (UILabel *)title {
    
    if (!_title) {
        _title = [[UILabel alloc] init];
        _title.numberOfLines = 0;
        _title.textColor = [UIColor darkGrayColor];
        _title.font = [UIFont boldSystemFontOfSize:15];
        [self.contentView addSubview:_title];
    }
    return _title;
}

- (UILabel *)summary {
    
    if (!_summary) {
        _summary = [[UILabel alloc] init];
        _summary.numberOfLines = 0;
        _summary.textColor = [UIColor grayColor];
        _summary.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:_summary];
    }
    return _summary;
}


- (LJBButton *)source {
    
    if (!_source) {
        _source = [[LJBButton alloc] init];
        [_source setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
        _source.titleLabel.font = [UIFont systemFontOfSize:10];
        _source.enabled = NO;
        [self.contentView addSubview:_source];
    }
    return _source;
}

- (LJBButton *)time {
    
    if (!_time) {
        _time = [[LJBButton alloc] init];
        [_time setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
        _time.titleLabel.font = [UIFont systemFontOfSize:10];
        _time.enabled = NO;
        [self.contentView addSubview:_time];
    }
    return _time;
}

@end
