//
//  LJBNavigationController.m
//  GuoKe
//
//  Created by CookieJ on 16/1/15.
//  Copyright © 2016年 ljunb. All rights reserved.
//

#import "LJBNavigationController.h"
#import "UIBarButtonItem+LJBExtension.h"

/**
 *  菜单按钮点击事件通知
 */
NSString * const kLJBBaseControllerDidClickMenuItemNotification = @"LJBBaseControllerDidClickMenuItemNotification";

@interface LJBNavigationController ()

@end

@implementation LJBNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationBar.barTintColor = [UIColor whiteColor];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    UIBarButtonItem * leftItem = nil;
    
    if (self.viewControllers.count == 0) {   // push的是根视图
        
        leftItem = [UIBarButtonItem itemWithTarget:self
                                            Action:@selector(didClickMenuItem)
                                       normalImage:@"nav_menuBtn"
                                   hightlightImage:@"nav_menuBtn_press"];
        
    } else {
        
        leftItem = [UIBarButtonItem itemWithTarget:self
                                            Action:@selector(didClickBackItem)
                                       normalImage:@"nav_back"
                                   hightlightImage:@"nav_back_press"];
        
    }
    viewController.navigationItem.leftBarButtonItems = [self fixSpaceWithItem:leftItem];
    
    [super pushViewController:viewController animated:animated];
}

#pragma mark - 解决左边导航栏空格过大
- (NSArray *)fixSpaceWithItem:(UIBarButtonItem *)barItem {
    
    UIBarButtonItem * spaceLeftItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    spaceLeftItem.width = -15;
    
    return @[spaceLeftItem, barItem];
}

#pragma mark - 菜单按钮事件
- (void)didClickMenuItem {
    
    // 发送通知
    [[NSNotificationCenter defaultCenter] postNotificationName:kLJBBaseControllerDidClickMenuItemNotification
                                                        object:nil];
}

#pragma mark - 返回按钮事件
- (void)didClickBackItem {
    [self popViewControllerAnimated:YES];
}

@end
