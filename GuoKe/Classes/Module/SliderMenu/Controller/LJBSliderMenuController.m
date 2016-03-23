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

static NSString * const kSliderMenuCellIdentifier = @"LJBSliderMenuCell";

@interface LJBSliderMenuController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView * tableView;

@property (nonatomic, copy) NSArray * menuTitles;

@property (nonatomic, copy) NSArray * menuImages;

@end

@implementation LJBSliderMenuController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTableView];
    
    [self registerCell];
    
    self.view.backgroundColor = [UIColor whiteColor];
}

#pragma mark - 初始化UITableView
- (void)setupTableView {
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(20, 0, 0, 0));
    }];
}

#pragma mark - 注册cell
- (void)registerCell {
    [self.tableView registerClass:[LJBSliderMenuCell class] forCellReuseIdentifier:kSliderMenuCellIdentifier];
}


#pragma mark - UITableView Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.menuTitles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LJBSliderMenuCell * cell = [tableView dequeueReusableCellWithIdentifier:kSliderMenuCellIdentifier forIndexPath:indexPath];
    
    [cell configCellWithTitle:self.menuTitles[indexPath.row] image:self.menuImages[indexPath.row]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // 回收左边菜单
    [self.viewDeckController toggleLeftViewAnimated:YES];
    
    // 通知代理
    if ([self.delegate respondsToSelector:@selector(sliderMenuController:didSelectedItemAtIndex:)]) {
        [self.delegate sliderMenuController:self didSelectedItemAtIndex:indexPath.row];
    }
}

#pragma mark - getter
- (UITableView *)tableView {
    
    if (!_tableView) {
        _tableView                    = [[UITableView alloc] init];
        _tableView.rowHeight          = UITableViewAutomaticDimension;
        _tableView.estimatedRowHeight = 50;
        _tableView.dataSource         = self;
        _tableView.delegate           = self;
        _tableView.tableFooterView    = [[UIView alloc] init];
        _tableView.separatorStyle     = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor    = [UIColor sliderViewBackgroundColor];
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (NSArray *)menuTitles {
    
    if (!_menuTitles) {
        _menuTitles = @[@"首页", @"我的收藏", @"设置", @"与我们交流"];
    }
    return _menuTitles;
}

- (NSArray *)menuImages {
    
    if (!_menuImages) {
        _menuImages = @[@"menu_home_press", @"menu_collection_press", @"menu_settings_press", @"menu_mail_press"];
    }
    return _menuImages;
}

@end
