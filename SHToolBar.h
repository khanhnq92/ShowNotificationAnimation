//
//  SHToolBar.h
//  SohaSDK
//
//  Created by Kent on 1/9/15.
//  Copyright (c) 2015 Sohagame Corporation. All rights reserved.
//
#import <UIKit/UIKit.h>

@interface SHToolBar : UIView

/**
 * @brief show the custom bar at the top of the game.
 */
- (void)show;

/**
 * @brief show the custom bar at the top of the game.
 * @param block handle completed block.
 */
- (void)showWithCompleteBlock:(void (^)(BOOL finished))block;

/**
 * @brief hide the custom bar at the top of the game.
 */
- (void)hide;

/**
 * @brief hide the custom bar at the top of the game.
 * @param block handle completed block.
 */
- (void)hideWithCompleteBlock:(void (^)(BOOL finished))block;

@end
