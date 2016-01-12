//
//  LJBBaseController.m
//  GuoKe
//
//  Created by 林俊炳 on 16/1/12.
//  Copyright © 2016年 ljunb. All rights reserved.
//

#import "LJBBaseController.h"
#import "AppDelegate.h"

NSString * const kLJBBaseControllerShowNotification = @"kLJBBaseControllerShowNotification";
NSString * const kLJBBaseControllerHideNotification = @"kLJBBaseControllerHideNotification";

@interface LJBBaseController ()

@property (nonatomic, assign, getter=isShow) BOOL show;

@property (nonatomic, strong) UIView * coverView;

@end

@implementation LJBBaseController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.show = YES;
    
    [self registerNotification];
    
    [self setupNavigationBar];
}

#pragma mark - 注册通知
- (void)registerNotification {
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(sliderMenuHide)
                                                 name:kLJBSliderMenuControllerHideNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(sliderMenuShow)
                                                 name:kLJBSliderMenuControllerShowNotification
                                               object:nil];
}

#pragma mark - 注销通知
- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:kLJBSliderMenuControllerShowNotification
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:kLJBSliderMenuControllerHideNotification
                                                  object:nil];
}

#pragma mark - 初始化导航栏
- (void)setupNavigationBar {
    
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    
    // 菜单按钮
    UIButton * menuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    menuBtn.frame = CGRectMake(0, 0, 40, 30);
    [menuBtn setImage:[UIImage imageNamed:@"nav_menuBtn"] forState:UIControlStateNormal];
    [menuBtn setImage:[UIImage imageNamed:@"nav_menuBtn_press"] forState:UIControlStateHighlighted];
    menuBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -15, 0, 0);
    [menuBtn addTarget:self action:@selector(didClickMenuItem) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:menuBtn];
}

#pragma mark - 单击菜单按钮
- (void)didClickMenuItem {
    
    self.show = !self.show;
    
    // 发送通知
    [[NSNotificationCenter defaultCenter] postNotificationName:self.isShow ? kLJBBaseControllerShowNotification : kLJBBaseControllerHideNotification object:nil];
}

#pragma mark - 侧滑菜单已隐藏
- (void)sliderMenuHide {
    
    self.show = YES;
    
    [self hideCoverView];
}

#pragma mark - 侧滑菜单已显示
- (void)sliderMenuShow {
    
    self.show = NO;
    
    [self showCoverView];
}


#pragma mark - 显示遮盖层
- (void)showCoverView {
    
    if (!_coverView) {
        _coverView = [[UIView alloc] initWithFrame:self.view.bounds];
        [self.view addSubview:_coverView];
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickedCoverView)];
        [_coverView addGestureRecognizer:tap];
    }
}

#pragma mark - 隐藏遮盖层
- (void)hideCoverView {
    [_coverView removeFromSuperview];
    _coverView = nil;
}

#pragma mark - 遮盖层单击手势
- (void)clickedCoverView {
    
    [self hideCoverView];
    
    [self didClickMenuItem];
}

@end
