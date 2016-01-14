//
//  NSDate+LJBExtension.m
//  GuoKe
//
//  Created by CookieJ on 16/1/14.
//  Copyright © 2016年 ljunb. All rights reserved.
//

#import "NSDate+LJBExtension.h"

@implementation NSDate (LJBExtension)

- (BOOL)isThisYear {
    
    // 日历对象
    NSCalendar * calendar = [NSCalendar currentCalendar];
    
    // 当前时间
    NSDate * currentDate = [NSDate date];
    
    // 比较时间
    NSDateComponents * components = [calendar components:NSCalendarUnitYear
                                                fromDate:self
                                                  toDate:currentDate
                                                 options:0];
    return components.year == 0;
}

- (NSDateComponents *)compareDateByNow {
    
    // 日历对象
    NSCalendar * calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitMonth | NSCalendarUnitWeekday | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute;
    
    // 当前时间
    NSDate * currentDate = [NSDate date];
    
    // 比较时间
    NSDateComponents * components = [calendar components:unit
                                                fromDate:self
                                                  toDate:currentDate
                                                 options:0];
    return components;
}

@end
