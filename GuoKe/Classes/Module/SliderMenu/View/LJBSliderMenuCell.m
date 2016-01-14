//
//  LJBSliderMenuCell.m
//  GuoKe
//
//  Created by 林俊炳 on 16/1/12.
//  Copyright © 2016年 ljunb. All rights reserved.
//

#import "LJBSliderMenuCell.h"
#import "AppDelegate.h"
#import <Masonry.h>

static CGFloat const kMenuIconTopAndBottomMargin = 15;
static CGFloat const kMenuIconLeftMargin         = 20;
static CGFloat const kMenuIconWidthAndHeight     = 25;

static CGFloat const kMenuIconAndTitleSpace      = 15;

static CGFloat const kIndicatorWidthAndHeight    = 20;

static CGFloat kBottomLineHeight                 = 2;


@interface LJBSliderMenuCell ()

@property (nonatomic, strong) UIImageView * menuIcon;

@property (nonatomic, strong) UILabel * menuTitle;

@property (nonatomic, strong) UIImageView * indicatorIcon;

@property (nonatomic, strong) UIImageView * bottomLine;

@end

@implementation LJBSliderMenuCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupSubviews];
        self.selectionStyle     = UITableViewCellSelectionStyleNone;
        self.backgroundColor    = [UIColor clearColor];
    }
    return self;
}

- (void)setupSubviews {
    
    // 菜单图片
    [self.menuIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(kMenuIconTopAndBottomMargin);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-kMenuIconTopAndBottomMargin);
        make.left.equalTo(self.contentView.mas_left).offset(kMenuIconLeftMargin);
        make.size.mas_equalTo(CGSizeMake(kMenuIconWidthAndHeight, kMenuIconWidthAndHeight));
    }];
    
    // 菜单标题
    [self.menuTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(_menuIcon.mas_right).offset(kMenuIconAndTitleSpace);
    }];
    
    // 右边箭头
    [self.indicatorIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.right.equalTo(self.contentView.mas_right).offset(-(kViewDeckLeftSize + kMenuIconLeftMargin));
        make.size.mas_equalTo(CGSizeMake(kIndicatorWidthAndHeight, kIndicatorWidthAndHeight));
    }];
    
    // 底部黑线
    [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.and.left.and.bottom.equalTo(self.contentView);
        make.height.equalTo(@(kBottomLineHeight));
    }];
}

- (void)configCellWithTitle:(NSString *)title image:(NSString *)image {
    
    self.menuIcon.image      = [UIImage imageNamed:image];
    
    self.menuTitle.text      = title;
    
    self.indicatorIcon.image = [UIImage imageNamed:@"menu_arrow_press"];
    
    self.bottomLine.image    = [[UIImage imageNamed:@"menu_line"] stretchableImageWithLeftCapWidth:10
                                                                                      topCapHeight:1];
}

#pragma mark - getter
- (UIImageView *)menuIcon {
    
    if (!_menuIcon) {
        _menuIcon           = [[UIImageView alloc] init];
        _menuIcon.tintColor = [UIColor whiteColor];
        [self.contentView addSubview:_menuIcon];
    }
    return _menuIcon;
}

- (UILabel *)menuTitle {
    
    if (!_menuTitle) {
        _menuTitle           = [[UILabel alloc] init];
        _menuTitle.font      = [UIFont boldSystemFontOfSize:16];
        _menuTitle.textColor = [UIColor whiteColor];
        [self.contentView addSubview:_menuTitle];
    }
    return _menuTitle;
}

- (UIImageView *)indicatorIcon {
    
    if (!_indicatorIcon) {
        _indicatorIcon = [[UIImageView alloc] init];
        [self.contentView addSubview:_indicatorIcon];
    }
    return _indicatorIcon;
}

- (UIImageView *)bottomLine {
    
    if (!_bottomLine) {
        _bottomLine = [[UIImageView alloc] init];
        [self.contentView addSubview:_bottomLine];
    }
    return _bottomLine;
}

@end
