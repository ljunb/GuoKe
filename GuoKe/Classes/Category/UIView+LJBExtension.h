//
//  UIView+LJBExtension.h
//  微博
//
//  Created by 林俊炳 on 15/12/21.
//  Copyright © 2015年 ljunb. All rights reserved.
//

#import <UIKit/UIKit.h>

// UIView分类，设置各frame属性
@interface UIView (LJBExtension)

@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;

- (void)cornerRadius:(CGFloat)radius;

@end

// UIBarButtonItem分类，导航栏按钮
@interface UIBarButtonItem (LJBExtension)

+ (UIBarButtonItem *)itemWithTarget:(id)target
                             Action:(SEL)action
                        normalImage:(NSString *)normalImage
                    hightlightImage:(NSString *)hightlightImage;

@end