//
//  LJBButton.m
//  GuoKe
//
//  Created by 林俊炳 on 16/1/13.
//  Copyright © 2016年 ljunb. All rights reserved.
//

#import "LJBButton.h"
#import "UIView+LJBExtension.h"

@implementation LJBButton

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.imageView.x = 0;
    
    self.titleLabel.x = CGRectGetMaxX(self.imageView.frame);
}

@end
