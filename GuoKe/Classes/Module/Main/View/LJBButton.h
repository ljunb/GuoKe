//
//  LJBButton.h
//  GuoKe
//
//  Created by 林俊炳 on 16/1/13.
//  Copyright © 2016年 ljunb. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, LJBButtonType) {
    LJBButtonLeftType = 0,
    LJBButtonRightType
};

@interface LJBButton : UIButton

@property (nonatomic, assign) LJBButtonType type;

@end
