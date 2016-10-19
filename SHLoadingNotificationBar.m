//
//  SHLoadingNotificationBar.m
//  SohaSDK
//
//  Created by Kent on 1/9/15.
//  Copyright (c) 2015 Sohagame Corporation. All rights reserved.
//

#import "SHLoadingNotificationBar.h"

@interface SHLoadingNotificationBar ()

@end

@implementation SHLoadingNotificationBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        UIActivityIndicatorView *activityIndicatorView = [[UIActivityIndicatorView alloc] init];
        activityIndicatorView.hidesWhenStopped = YES;
        [activityIndicatorView sizeToFit];
        [activityIndicatorView startAnimating];
        self.leftView = activityIndicatorView;
        
        self.hideManuallyEnable = NO;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
}

- (void)show {
    if (!_autoHide) {
        self.showDuration = 0;
    }
    [super show];
}

@end
