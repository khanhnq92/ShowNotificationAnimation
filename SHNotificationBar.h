//
//  SHNotificationBar.h
//  SohaSDK
//
//  Created by Kent on 1/9/15.
//  Copyright (c) 2015 Sohagame Corporation. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "SHToolBar.h"

/*!
 
 @typedef enum (NSUInteger, SohaNotificationAnimation)
 @abstract types of bar animation.
 
 */

typedef NS_ENUM(NSUInteger, SohaNotificationAnimation) {
    SohaNotificationAnimationFade,
    SohaNotificationAnimationBottom
};

@interface SHNotificationBar : SHToolBar

@property (nonatomic) SohaNotificationAnimation animationType;
@property (nonatomic, strong) UIView *leftView;
@property (nonatomic, strong) UILabel *message;
@property (nonatomic) NSTimeInterval showDuration;
@property (nonatomic, setter=hideManuallyEnable:) BOOL hideManuallyEnable;

/*!
 
 @brief overrided with animation
 
 */

- (void)show;

/*!
 
 @brief overrided with animation
 
 */

- (void)hide;

/*!
 
 @brief change message text
 
 */
- (void)changeMessage:(NSString *)newMessage;

/*!
 
 @brief change gradient background for notification bar
 
 */
- (void)changeBackgroundColor:(UIColor *)color;

@end
