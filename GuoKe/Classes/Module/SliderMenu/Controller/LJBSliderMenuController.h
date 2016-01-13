//
//  LJBSliderMenuController.h
//  GuoKe
//
//  Created by 林俊炳 on 16/1/12.
//  Copyright © 2016年 ljunb. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LJBSliderMenuController;

@protocol LJBSliderMenuControllerDelegate <NSObject>

- (void)sliderMenuController:(LJBSliderMenuController *)sliderMenuController
      didSelectedItemAtIndex:(NSInteger)index;

@end

@interface LJBSliderMenuController : UIViewController

@property (nonatomic, weak) id<LJBSliderMenuControllerDelegate> delegate;

@end
