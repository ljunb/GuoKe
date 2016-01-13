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

@interface AppDelegate ()

@property (nonatomic, strong) IIViewDeckController * viewDeckVC;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    LJBRootController * rootVC = [[LJBRootController alloc] init];
    
    LJBSliderMenuController * sliderVC = [[LJBSliderMenuController alloc] init];
    
    _viewDeckVC = [[IIViewDeckController alloc] initWithCenterViewController:rootVC
                                                          leftViewController:sliderVC];
    _viewDeckVC.leftSize = kViewDeckLeftSize;
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    self.window.rootViewController = _viewDeckVC;
    
    [self.window makeKeyAndVisible];
    
    return YES;
}
@end
