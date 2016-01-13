//
//  LJBBaseController.m
//  GuoKe
//
//  Created by 林俊炳 on 16/1/12.
//  Copyright © 2016年 ljunb. All rights reserved.
//

#import "LJBRootController.h"
#import "LJBMainController.h"
#import "LJBFavoriteController.h"
#import "LJBConfigController.h"
#import "LJBConnectionController.h"
#import "LJBSliderMenuController.h"
#import "LJBBaseController.h"
#import "AppDelegate.h"
#import <Masonry.h>
#import <ViewDeck.h>

typedef NS_ENUM(NSInteger, LJBControllerType) {
    LJBMainControllerType = 0,
    LJBFavoriteControllerType,
    LJBConfigControllerType,
    LJBConnectionControllerType
};


@interface LJBRootController () <IIViewDeckControllerDelegate, LJBSliderMenuControllerDelegate>

@property (nonatomic, copy) NSArray * controllerTitles;

@property (nonatomic, strong) UIViewController * currentController;

@property (nonatomic, assign, getter=isShow) BOOL show;

@property (nonatomic, strong) UIView * coverView;

@end

@implementation LJBRootController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self registerNotification];
    
    [self initBaseConfig];
    
    [self initChildController];
}

#pragma mark - 注册点击LJBBaseController菜单通知
- (void)registerNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didClickMenuItem)
                                                 name:kLJBBaseControllerDidClickMenuItemNotification
                                               object:nil];
}

#pragma mark - 注销通知
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:kLJBBaseControllerDidClickMenuItemNotification
                                                  object:nil];
}

#pragma mark - 基础配置
- (void)initBaseConfig {
    
    self.show = YES;    // 初始显示中心VC
    
    self.viewDeckController.delegate = self;
}

#pragma mark - 添加初始VC
- (void)initChildController {
    
    LJBMainController * mainVC = [[LJBMainController alloc] init];
    mainVC.title = self.controllerTitles.firstObject;
    
    UINavigationController * unc = [[UINavigationController alloc] initWithRootViewController:mainVC];
    [self.view addSubview:unc.view];
    [unc.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsZero);
    }];
    
    self.currentController = unc;
    [self addChildViewController:self.currentController];
}


#pragma mark - LJBSliderMenuControllerDelegate
- (void)sliderMenuController:(LJBSliderMenuController *)sliderMenuController didSelectedItemAtIndex:(NSInteger)index {
    
    self.title = self.controllerTitles[index];
    
    [self setupChildControllerWithIndex:index];
}

#pragma mark - 添加子VC
- (void)setupChildControllerWithIndex:(NSInteger)index {
    
    [self.currentController.view removeFromSuperview];
    [self.currentController removeFromParentViewController];
    
    UIViewController * viewController = nil;
    switch (index) {
        case LJBMainControllerType:
        {
            viewController = [[LJBMainController alloc] init];
        }
            break;
        case LJBFavoriteControllerType:
        {
            viewController = [[LJBFavoriteController alloc] init];
        }
            break;
        case LJBConfigControllerType:
        {
            viewController = [[LJBConfigController alloc] init];
        }
            break;
        case LJBConnectionControllerType:
        {
            viewController = [[LJBConnectionController alloc] init];
        }
            break;
    }
    
    viewController.title = self.controllerTitles[index];
    UINavigationController * unc = [[UINavigationController alloc] initWithRootViewController:viewController];
    
    [self.view addSubview:unc.view];
    [self addChildViewController:unc];
    
    self.currentController = unc;
}


#pragma mark - IIViewDeckControllerDelegate
#pragma mark 滑出侧滑菜单
- (void)viewDeckController:(IIViewDeckController *)viewDeckController didOpenViewSide:(IIViewDeckSide)viewDeckSide animated:(BOOL)animated {
    
    self.show = NO;
    
    [self showCoverView];
}

#pragma mark 收回侧滑菜单
- (void)viewDeckController:(IIViewDeckController *)viewDeckController didShowCenterViewFromSide:(IIViewDeckSide)viewDeckSide animated:(BOOL)animated {
    
    self.show = YES;
    
    [self hideCoverView];
}

#pragma mark - 通知处理方法
- (void)didClickMenuItem {
    
    self.show = !self.show;
    
    if (self.isShow) {  // 显示中心VC
        
        [self.viewDeckController closeLeftView];

        [self hideCoverView];
        
    } else {            // 隐藏中心VC
        
        [self.viewDeckController openLeftView];
        
        [self showCoverView];
    }
}

#pragma mark - 显示遮盖层
- (void)showCoverView {
    
    if (!_coverView) {
        _coverView = [[UIView alloc] initWithFrame:self.view.bounds];
        [self.view addSubview:_coverView];
        
        // 遮盖层添加单击手势
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                               action:@selector(clickedCoverView)];
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



#pragma mark - getter
- (NSArray *)controllerTitles {
    
    if (!_controllerTitles) {
        _controllerTitles = @[@"果壳精选", @"我的收藏", @"设置", @"与我们交流"];
    }
    return _controllerTitles;
}

@end
