//
//  NSDate+LJBExtension.h
//  GuoKe
//
//  Created by CookieJ on 16/1/14.
//  Copyright © 2016年 ljunb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (LJBExtension)

/**
 *  判断日期是否为今年
 *
 *  @return 返回YES or NO
 */
- (BOOL)isThisYear;

/**
 *  与当前时间进行比较
 *
 *  @return 处理后的日历对象
 */
- (NSDateComponents *)compareDateByNow;

@end
