//
//  SHLogoNotificationBar.m
//  SohaSDK
//
//  Created by Kent on 1/9/15.
//  Copyright (c) 2015 Sohagame Corporation. All rights reserved.
//

#import "SHLogoNotificationBar.h"
//#import "UIImage+Additions.h"

@interface SHLogoNotificationBar ()

@end

@implementation SHLogoNotificationBar

#define IMG_BAR_LOGO_SHG @"bar-icon-sohagame.png"

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
////        UIImage *logo = [UIImage sohaImageNamed:IMG_BAR_LOGO_SHG];
//        UIImageView *logoView = [[UIImageView alloc] initWithImage:logo];
//        CGSize imgSize = [logo size];
//        logoView.frame = CGRectMake(0, 0, imgSize.width, imgSize.height);
//        self.leftView = logoView;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
}

@end
