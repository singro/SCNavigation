//
//  SCNavigationBar.m
//
//  Created by Singro on 6/23/14.
//  Copyright (c) 2014 Singro. All rights reserved.
//

#import "SCNavigationBar.h"

#import "SCShared.h"

@interface SCNavigationBar ()

@property (nonatomic, strong) UIView *lineView;
@end

@implementation SCNavigationBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        self.frame = (CGRect){0, 0, [UIScreen mainScreen].bounds.size.width, 64};

        self.backgroundColor = kNavigationBarColor;

        self.lineView = [[UIView alloc] initWithFrame:(CGRect){0, 64, [UIScreen mainScreen].bounds.size.width, 0.5}];
        self.lineView.backgroundColor = kNavigationBarLineColor;
        [self addSubview:self.lineView];

    }
    return self;
}

- (instancetype)init {
    return [self initWithFrame:CGRectZero];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Notifications

- (void)didReceiveThemeChangeNotification {

    self.backgroundColor = kNavigationBarColor;
    self.lineView.backgroundColor = kNavigationBarLineColor;

}

@end
