//
//  UIBarButtonItem+LJBExtension.m
//  GuoKe
//
//  Created by CookieJ on 16/1/15.
//  Copyright © 2016年 ljunb. All rights reserved.
//

#import "UIBarButtonItem+LJBExtension.h"
#import "UIView+LJBExtension.h"

@implementation UIBarButtonItem (LJBExtension)

+ (UIBarButtonItem *)itemWithTarget:(id)target
                             Action:(SEL)action
                        normalImage:(NSString *)normalImage
                    hightlightImage:(NSString *)hightlightImage {
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:normalImage] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:hightlightImage] forState:UIControlStateHighlighted];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    button.size = button.currentBackgroundImage.size;
    
    return [[UIBarButtonItem alloc] initWithCustomView:button];
    
}

@end
