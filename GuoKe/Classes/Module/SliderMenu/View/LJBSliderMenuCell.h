//
//  LJBSliderMenuCell.h
//  GuoKe
//
//  Created by 林俊炳 on 16/1/12.
//  Copyright © 2016年 ljunb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LJBSliderMenuCell : UITableViewCell

/**
 *  设置cell内容
 *
 *  @param title    菜单名称
 *  @param norImage 菜单图片
 */
- (void)configCellWithTitle:(NSString *)title image:(NSString *)image;

@end
