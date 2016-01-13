//
//  LJBBaseController.m
//  GuoKe
//
//  Created by 林俊炳 on 16/1/12.
//  Copyright © 2016年 ljunb. All rights reserved.
//

#import "LJBBaseController.h"
#import "AppDelegate.h"

/**
 *  菜单按钮点击事件通知
 */
NSString * const kLJBBaseControllerDidClickMenuItemNotification = @"LJBBaseControllerDidClickMenuItemNotification";

@interface LJBBaseController ()

@end

@implementation LJBBaseController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNavigationBar];
}

#pragma mark - 初始化导航栏
- (void)setupNavigationBar {
    
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    
    // 菜单按钮
    UIButton * menuBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
    menuBtn.frame       = CGRectMake(0, 0, 40, 30);
    [menuBtn setImage:[UIImage imageNamed:@"nav_menuBtn"] forState:UIControlStateNormal];
    [menuBtn setImage:[UIImage imageNamed:@"nav_menuBtn_press"] forState:UIControlStateHighlighted];
    menuBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -15, 0, 0);
    [menuBtn addTarget:self action:@selector(didClickMenuItem) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:menuBtn];
}

#pragma mark - 单击菜单按钮
- (void)didClickMenuItem {
    
    // 发送通知
    [[NSNotificationCenter defaultCenter] postNotificationName:kLJBBaseControllerDidClickMenuItemNotification
                                                        object:nil];
}

@end
