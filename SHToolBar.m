//
//  SHToolBar.m
//  SohaSDK
//
//  Created by Kent on 1/9/15.
//  Copyright (c) 2015 Sohagame Corporation. All rights reserved.
//

#import "SHToolBar.h"

@implementation SHToolBar

#define DURATION_OF_ANIMATION 0.3

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initCustom];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self initCustom];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initCustom];
    }
    return self;
}

- (void)initCustom {
    self.userInteractionEnabled = NO;
}

- (void)show {
    [self showWithCompleteBlock:nil];
}

- (void)showWithCompleteBlock:(void (^)(BOOL finished))block {
    __block UIView* nonRetainedSelf = self;
    
    self.alpha = 0.0;
    
    [UIView animateWithDuration:DURATION_OF_ANIMATION
                     animations:^{
                         nonRetainedSelf.alpha = 1.0;
                     }
                     completion:block];
}

- (void)hide {
    __block UIView* nonRetainedSelf = self;
    [self hideWithCompleteBlock:^(BOOL finished) {
        [nonRetainedSelf removeFromSuperview];
    }];
}

- (void)hideWithCompleteBlock:(void (^)(BOOL finished))block {
    __block UIView* nonRetainedSelf = self;
    
    [UIView animateWithDuration:DURATION_OF_ANIMATION
                     animations:^{
                         nonRetainedSelf.alpha = 0.0;
                     }
                     completion:block];
}

@end
