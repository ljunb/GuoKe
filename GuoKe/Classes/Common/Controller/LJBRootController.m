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
#import "AppDelegate.h"
#import <Masonry.h>

typedef NS_ENUM(NSInteger, LJBControllerType) {
    LJBMainControllerType = 0,
    LJBFavoriteControllerType,
    LJBConfigControllerType,
    LJBConnectionControllerType
};


@interface LJBRootController ()

@property (nonatomic, copy) NSArray * controllerTitles;

@property (nonatomic, strong) UIViewController * currentController;

@end

@implementation LJBRootController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initChildController];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 侧滑菜单单击回调block
    __weak typeof(self) weakSelf = self;
    self.ClickedItemAtIndexBlock = ^(NSInteger index) {
        
        weakSelf.title = weakSelf.controllerTitles[index];
    
        [weakSelf setupChildControllerWithIndex:index];
    };
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


#pragma mark - getter
- (NSArray *)controllerTitles {
    
    if (!_controllerTitles) {
        _controllerTitles = @[@"果壳精选", @"我的收藏", @"设置", @"与我们交流"];
    }
    return _controllerTitles;
}

@end
