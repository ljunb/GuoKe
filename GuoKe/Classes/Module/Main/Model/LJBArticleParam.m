//
//  LJBArticleParam.m
//  GuoKe
//
//  Created by 林俊炳 on 16/1/13.
//  Copyright © 2016年 ljunb. All rights reserved.
//  retrieve_type=by_since&since=&orientation=before&category=all&ad=1

#import "LJBArticleParam.h"

@implementation LJBArticleParam

- (instancetype)init {
    
    if (self = [super init]) {
        _retrieve_type = @"by_since";
        _since = @"";
        _orientation = @"before";
        _category = @"all";
        _ad = @"1";
    }
    return self;
}

@end
