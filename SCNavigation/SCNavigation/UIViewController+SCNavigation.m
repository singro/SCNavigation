//
//  SPViewController+NaviBar.m
//
//  Created by Singro on 5/19/14.
//  Copyright (c) 2014 Singro. All rights reserved.
//

static char const * const kNaviHidden = "kSPNaviHidden";
static char const * const kNaviBar = "kSPNaviBar";
static char const * const kNaviBarView = "kNaviBarView";

#import "UIViewController+SCNavigation.h"

#import <objc/runtime.h>

#import "SCShared.h"

@implementation UIViewController (SCNavigation)

@dynamic sc_navigationItem;
@dynamic sc_navigationBar;
@dynamic sc_navigationBarHidden;

- (BOOL)sc_isNavigationBarHidden {
    return [objc_getAssociatedObject(self, kNaviHidden) boolValue];
}

- (void)setSc_navigationBarHidden:(BOOL)sc_navigationBarHidden {
    objc_setAssociatedObject(self, kNaviHidden, @(sc_navigationBarHidden), OBJC_ASSOCIATION_ASSIGN);
}

- (void)sc_setNavigationBarHidden:(BOOL)hidden animated:(BOOL)animated {
    if (hidden) {
        [UIView animateWithDuration:0.3 animations:^{
            self.sc_navigationBar.y = -44;
            for (UIView *view in self.sc_navigationBar.subviews) {
                view.alpha = 0.0;
            }
        } completion:^(BOOL finished) {
            self.sc_navigationBarHidden = YES;
        }];
    } else {
        [UIView animateWithDuration:0.3 animations:^{
            self.sc_navigationBar.y = 0;
            for (UIView *view in self.sc_navigationBar.subviews) {
                view.alpha = 1.0;
            }
        } completion:^(BOOL finished) {
            self.sc_navigationBarHidden = NO;
        }];
    }
}

- (SCNavigationItem *)sc_navigationItem {
    return objc_getAssociatedObject(self, kNaviBar);
}

- (void)setSc_navigationItem:(SCNavigationItem *)sc_navigationItem {
    objc_setAssociatedObject(self, kNaviBar, sc_navigationItem, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)sc_navigationBar {
    return objc_getAssociatedObject(self, kNaviBarView);
}

- (void)setSc_navigationBar:(UIView *)sc_navigationBar {
    objc_setAssociatedObject(self, kNaviBarView, sc_navigationBar, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)naviBeginRefreshing {

    UIActivityIndicatorView *activityView;
    for (UIView *view in self.sc_navigationBar.subviews) {
        if ([view isKindOfClass:[UIActivityIndicatorView class]]) {
            activityView = (UIActivityIndicatorView *)view;
        }
        if ([view isEqual:self.sc_navigationItem.rightBarButtonItem.view]) {
            [view removeFromSuperview];
        }
    }

    if (!activityView) {
        activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [activityView setColor:[UIColor blackColor]];
        activityView.frame = (CGRect){[UIScreen mainScreen].bounds.size.width - 42, 25, 35, 35};
        [self.sc_navigationBar addSubview:activityView];
    }

    [activityView startAnimating];

}


- (void)naviEndRefreshing {

    UIActivityIndicatorView *activityView;
    for (UIView *view in self.sc_navigationBar.subviews) {
        if ([view isKindOfClass:[UIActivityIndicatorView class]]) {
            activityView = (UIActivityIndicatorView *)view;
        }
    }

    if (self.sc_navigationItem.rightBarButtonItem) {
        [self.sc_navigationBar addSubview:self.sc_navigationItem.rightBarButtonItem.view];
    }

    [activityView stopAnimating];

}


@end
