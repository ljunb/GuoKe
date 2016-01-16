//
//  LJBCommentView.m
//  GuoKe
//
//  Created by CookieJ on 16/1/15.
//  Copyright © 2016年 ljunb. All rights reserved.
//

#import "LJBCommentView.h"
#import "LJBButton.h"
#import "UIColor+LJBExtension.h"
#import <Masonry.h>

#define LJBScreenSize [UIScreen mainScreen].bounds.size

@interface LJBCommentView ()

@property (nonatomic, strong) LJBButton * comment;

@property (nonatomic, copy) void(^ClickedBlock)();

@end

@implementation LJBCommentView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor articleCollectionViewBackgroundColor];
        
        [self.comment mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self).insets(UIEdgeInsetsMake(6, 12, 6, 12));
        }];
    }
    return self;
}

#pragma mark - 点击事件
- (void)didClickComment {

    // 通知代理
    if ([self.delegate respondsToSelector:@selector(commentViewDidClick:)]) {
        [self.delegate commentViewDidClick:self];
    }
}


#pragma mark - getter
- (LJBButton *)comment {
    
    if (!_comment) {
        _comment = [[LJBButton alloc] init];
        _comment.backgroundColor = [UIColor whiteColor];
        [_comment setTitle:@"写评论" forState:UIControlStateNormal];
        [_comment setImage:[UIImage imageNamed:@"article_btn_review"] forState:UIControlStateNormal];
        [_comment setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        _comment.titleLabel.font = [UIFont systemFontOfSize:13];
        _comment.adjustsImageWhenHighlighted = NO;
        
        _comment.layer.cornerRadius = 5;
        _comment.layer.masksToBounds = YES;
        _comment.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _comment.layer.borderWidth = 0.5;
        
        
        [_comment addTarget:self action:@selector(didClickComment) forControlEvents:UIControlEventTouchDown];
        [self addSubview:_comment];
    }
    return _comment;
}

@end
