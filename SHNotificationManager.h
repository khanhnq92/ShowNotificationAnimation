//
//  SHNotificationManager.h
//  Test
//
//  Created by nguyenquockhanh on 10/19/16.
//  Copyright © 2016 KVIP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SHLoadingNotificationBar.h"
#import "SHLogoNotificationBar.h"

@interface SHNotificationManager : NSObject
@property (nonatomic,assign) BOOL loadingBarStatus;
@property (nonatomic,strong) SHLoadingNotificationBar* loadingBar;

+ (instancetype)sharedInstance;
// show Loading
+ (SHLoadingNotificationBar *)showLoadingBarWithMessage:(NSString*)message;
+ (SHLoadingNotificationBar *)showLoadingBarWithMessage:(NSString*)message autoHide:(BOOL)autoHide;
+ (SHLoadingNotificationBar *)showLoadingBarWithMessage:(NSString*)message animationType:(SohaNotificationAnimation)animationType autoHide:(BOOL)autoHide;
//No loading
+ (SHLogoNotificationBar *)showNotificationBarWithMessage:(NSString*)message;
+ (SHLogoNotificationBar *)showNotificationBarWithMessage:(NSString*)message animationType:(SohaNotificationAnimation)animationType;
+ (SHNotificationBar *)showNotificationBarWithMessageWithoutLogo:(NSString*)message;
+ (void)hideLoadingBar;
@end
