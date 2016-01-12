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

static CGFloat const MenuIconTopAndBottomMargin = 15;
static CGFloat const MenuIconLeftMargin         = 20;
static CGFloat const MenuIconWidthAndHeight     = 25;

static CGFloat const MenuIconAndTitleSpace      = 15;

static CGFloat BottomLineHeight                 = 2;


@interface LJBSliderMenuCell ()
{
    UIImageView * _menuIcon;
    UILabel * _menuTitle;
    UIImageView * _indicatorIcon;
    UIImageView * _bottomLine;
}
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
    _menuIcon = ({
        UIImageView * menuIcon = [[UIImageView alloc] init];
        menuIcon.tintColor = [UIColor whiteColor];
        [self.contentView addSubview:menuIcon];
        menuIcon;
    });
    
    [_menuIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(MenuIconTopAndBottomMargin);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-MenuIconTopAndBottomMargin);
        make.left.equalTo(self.contentView.mas_left).offset(MenuIconLeftMargin);
        make.size.mas_equalTo(CGSizeMake(MenuIconWidthAndHeight, MenuIconWidthAndHeight));
    }];
    
    // 菜单标题
    _menuTitle = ({
        UILabel * title = [[UILabel alloc] init];
        title.font = [UIFont boldSystemFontOfSize:16];
        title.textColor = [UIColor whiteColor];
        [self.contentView addSubview:title];
        title;
    });
    
    [_menuTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(_menuIcon.mas_right).offset(MenuIconAndTitleSpace);
    }];
    
    // 右边箭头
    _indicatorIcon = ({
        UIImageView * indicatorIcon = [[UIImageView alloc] init];
        [self.contentView addSubview:indicatorIcon];
        indicatorIcon;
    });
    
    [_indicatorIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.right.equalTo(self.contentView.mas_right).offset(-(kViewDeckLeftSize + MenuIconLeftMargin));
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
    
    // 底部黑线
    _bottomLine = ({
        UIImageView * bottomLine = [[UIImageView alloc] init];
        [self.contentView addSubview:bottomLine];
        bottomLine;
    });
    [_bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.and.left.and.bottom.equalTo(self.contentView);
        make.height.equalTo(@(BottomLineHeight));
    }];
}

- (void)configCellWithTitle:(NSString *)title norImage:(NSString *)norImage {
    
    _menuIcon.image = [UIImage imageNamed:norImage];
    
    _menuTitle.text = title;
    
    _indicatorIcon.image = [UIImage imageNamed:@"menu_arrow_press"];
    
    _bottomLine.image = [[UIImage imageNamed:@"menu_line"] stretchableImageWithLeftCapWidth:10 topCapHeight:1];
}

@end
