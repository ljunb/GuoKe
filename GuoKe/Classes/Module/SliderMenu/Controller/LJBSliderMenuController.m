//
//  LJBSliderMenuController.m
//  GuoKe
//
//  Created by 林俊炳 on 16/1/12.
//  Copyright © 2016年 ljunb. All rights reserved.
//

#import "LJBSliderMenuController.h"
#import "LJBSliderMenuCell.h"
#import "LJBRootController.h"
#import <Masonry.h>
#import <ViewDeck.h>
#import "UIColor+LJBExtension.h"

static NSString * const kSliderMenuCellIdentifier = @"LJBSliderMenuCell";

@interface LJBSliderMenuController () <UITableViewDataSource, UITableViewDelegate>
{
    NSArray * _menuTitles;
    NSArray * _menuImages;
    UITableView * _tableView;
}

@end

@implementation LJBSliderMenuController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initData];
    
    [self setupTableView];
    
    [self registerCell];
    
    self.view.backgroundColor = [UIColor whiteColor];
}

#pragma mark - 初始化数据
- (void)initData {
    
    _menuTitles = @[@"首页", @"我的收藏", @"设置", @"与我们交流"];
    
    _menuImages = @[@"menu_home_press", @"menu_collection_press", @"menu_settings_press", @"menu_mail_press"];
}

#pragma mark - 初始化UITableView
- (void)setupTableView {
    
    _tableView = ({
        UITableView * tableView         = [[UITableView alloc] init];
        tableView.rowHeight             = UITableViewAutomaticDimension;
        tableView.estimatedRowHeight    = 50;
        tableView.dataSource            = self;
        tableView.delegate              = self;
        tableView.tableFooterView       = [[UIView alloc] init];
        tableView.separatorStyle        = UITableViewCellSeparatorStyleNone;
        tableView.backgroundColor       = [UIColor sliderViewBackgroundColor];
        [self.view addSubview:tableView];
        tableView;
    });
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(20, 0, 0, 0));
    }];
}

#pragma mark - 注册cell
- (void)registerCell {
    [_tableView registerClass:[LJBSliderMenuCell class] forCellReuseIdentifier:kSliderMenuCellIdentifier];
}


#pragma mark - UITableView Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _menuTitles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LJBSliderMenuCell * cell = [tableView dequeueReusableCellWithIdentifier:kSliderMenuCellIdentifier forIndexPath:indexPath];
    
    [cell configCellWithTitle:_menuTitles[indexPath.row] image:_menuImages[indexPath.row]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // 回收左边菜单
    [self.viewDeckController toggleLeftViewAnimated:YES];
    
    // 取得中心VC
    LJBRootController * rootVC = (LJBRootController *)self.viewDeckController.centerController;
    self.delegate = rootVC;
    
    // 通知代理
    if ([self.delegate respondsToSelector:@selector(sliderMenuController:didSelectedItemAtIndex:)]) {
        [self.delegate sliderMenuController:self didSelectedItemAtIndex:indexPath.row];
    }
}

@end
