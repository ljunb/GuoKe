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
    
    if (self.type == LJBButtonLeftType) {   // 靠左
        
        self.imageView.x = 5;
        
        self.titleLabel.x = CGRectGetMaxX(self.imageView.frame);
        
    } else {                                // 靠右
        
        self.titleLabel.x = self.width - self.titleLabel.width - 5;
        
        self.imageView.x = CGRectGetMinX(self.titleLabel.frame) - self.imageView.width;
    }

}

@end
