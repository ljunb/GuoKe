//
//  AppDelegate.m
//  GuoKe
//
//  Created by 林俊炳 on 16/1/12.
//  Copyright © 2016年 ljunb. All rights reserved.
//

#import "AppDelegate.h"
#import <IIViewDeckController.h>
#import "LJBSliderMenuController.h"
#import "LJBRootController.h"
#import "LJBBaseController.h"

CGFloat const kViewDeckLeftSize = 100;

NSString * const kLJBSliderMenuControllerShowNotification = @"kLJBSliderMenuControllerShowNotification";
NSString * const kLJBSliderMenuControllerHideNotification = @"kLJBSliderMenuControllerHideNotification";

@interface AppDelegate () <IIViewDeckControllerDelegate>

@property (nonatomic, strong) IIViewDeckController * viewDeckVC;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [self registerNotification];
    
    LJBRootController * rootVC = [[LJBRootController alloc] init];
    
    LJBSliderMenuController * sliderVC = [[LJBSliderMenuController alloc] init];
    
    _viewDeckVC = [[IIViewDeckController alloc] initWithCenterViewController:rootVC
                                                          leftViewController:sliderVC];
    _viewDeckVC.leftSize = kViewDeckLeftSize;
    _viewDeckVC.delegate = self;
    
    // 侧滑菜单单击回调block
    sliderVC.ClickedItemBlock = ^(NSInteger index){
        
        [_viewDeckVC closeLeftView];
        
        // 调用基类的回调block
        if (rootVC.ClickedItemAtIndexBlock) {
            rootVC.ClickedItemAtIndexBlock(index);
        }
    };
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    self.window.rootViewController = _viewDeckVC;
    
    [self.window makeKeyAndVisible];
    
    return YES;
}

#pragma mark - 注册通知
- (void)registerNotification {
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showBaseController) name:kLJBBaseControllerShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hideBaseController) name:kLJBBaseControllerHideNotification object:nil];
}

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kLJBBaseControllerHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kLJBBaseControllerShowNotification object:nil];
}

#pragma mark - 显示主视图
- (void)showBaseController {
    [self.viewDeckVC closeLeftView];
}

#pragma mark - 隐藏主视图
- (void)hideBaseController {
    [self.viewDeckVC openLeftView];
}


#pragma mark - IIViewDeckControllerDelegate

- (void)viewDeckController:(IIViewDeckController *)viewDeckController didOpenViewSide:(IIViewDeckSide)viewDeckSide animated:(BOOL)animated {
//    NSLog(@"open");
    [[NSNotificationCenter defaultCenter] postNotificationName:kLJBSliderMenuControllerShowNotification
                                                        object:nil];
}

- (void)viewDeckController:(IIViewDeckController *)viewDeckController didShowCenterViewFromSide:(IIViewDeckSide)viewDeckSide animated:(BOOL)animated {
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kLJBSliderMenuControllerHideNotification
                                                        object:nil];
}


@end
