//
//  LJBDateTool.h
//  GuoKe
//
//  Created by CookieJ on 16/1/16.
//  Copyright © 2016年 ljunb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LJBDateTool : NSObject

/**
 *  处理时间戳方法
 *
 *  @param dateStr 时间戳字符串
 *
 *  @return 自定义的日期字符串
 */
+ (NSString *)customDateWithOriginDateString:(NSString *)dateStr;

@end
