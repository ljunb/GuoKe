//
//  LJBCommentView.h
//  GuoKe
//
//  Created by CookieJ on 16/1/15.
//  Copyright © 2016年 ljunb. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LJBCommentView;

@protocol LJBCommentViewDelegate <NSObject>

- (void)commentViewDidClick:(LJBCommentView *)commentView;

@end


@interface LJBCommentView : UIView

@property (nonatomic, weak) id<LJBCommentViewDelegate> delegate;

@end
