//
//  SHNotificationManager.m
//  Test
//
//  Created by nguyenquockhanh on 10/19/16.
//  Copyright © 2016 KVIP. All rights reserved.
//

#import "SHNotificationManager.h"

@implementation SHNotificationManager
+ (instancetype)sharedInstance{
    static SHNotificationManager* obj;
    static dispatch_once_t oneT;
    dispatch_once(&oneT, ^{
        obj=[SHNotificationManager new];
    });
    return obj;
}


+ (void)showController:(UIViewController *)controller {
    
    [[SHNotificationManager sharedInstance] showController:controller];
}

- (void)showController:(UIViewController *)controller {
    
    UIViewController *lastPresentedController = [[[[UIApplication sharedApplication] delegate] window] rootViewController];
    controller.modalPresentationStyle = UIModalPresentationFullScreen;
    controller.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [lastPresentedController presentViewController:controller animated:YES completion:^{
        // do something at completion
    }];
}

+ (void)showToolbar:(SHToolBar *)toolbar {
    //    [toolbar setFrame:CGRectMake(0, 44, toolbar.frame.size.width, toolbar.frame.size.height)];
    __block CGRect rect = [UIScreen mainScreen].bounds;
    [toolbar setFrame:rect];
    UIViewController *viewController = [[[[UIApplication sharedApplication] delegate] window] rootViewController];
    [viewController.view addSubview:toolbar];
    [toolbar show];
}

+ (SHNotificationBar *)showNotificationBarWithMessageWithoutLogo:(NSString*)message{
    SHNotificationBar *notificationBar = [[SHNotificationBar alloc] init];
    notificationBar.message.text = message;
    notificationBar.animationType = SohaNotificationAnimationBottom;
    [self showToolbar:notificationBar];
    return notificationBar;
}

+ (SHLogoNotificationBar *)showNotificationBarWithMessage:(NSString*)message {
    return [self showNotificationBarWithMessage:message animationType:SohaNotificationAnimationBottom];
}

+ (SHLogoNotificationBar *)showNotificationBarWithMessage:(NSString*)message animationType:(SohaNotificationAnimation)animationType {
    SHLogoNotificationBar *notificationBar = [[SHLogoNotificationBar alloc] init];
    notificationBar.message.text = message;
    notificationBar.animationType = animationType;
    [self showToolbar:notificationBar];
    return notificationBar;
}

+ (SHLoadingNotificationBar *)showLoadingBarWithMessage:(NSString*)message {
    return [self showLoadingBarWithMessage:message autoHide:NO];
}

+ (SHLoadingNotificationBar *)showLoadingBarWithMessage:(NSString*)message autoHide:(BOOL)autoHide {
    return [self showLoadingBarWithMessage:message animationType:SohaNotificationAnimationBottom autoHide:autoHide];
}

+ (SHLoadingNotificationBar *)showLoadingBarWithMessage:(NSString*)message animationType:(SohaNotificationAnimation)animationType autoHide:(BOOL)autoHide {
    
    [SHNotificationManager sharedInstance].loadingBarStatus = YES;
    SHLoadingNotificationBar *notificationBar = [[SHLoadingNotificationBar alloc] init];
    notificationBar.message.text = message;
    notificationBar.animationType = animationType;
    notificationBar.autoHide = autoHide;
    [SHNotificationManager sharedInstance].loadingBar = notificationBar;
    [SHNotificationManager showToolbar:notificationBar];
    return notificationBar;
}

+ (void)hideLoadingBar {
    
    if (![SHNotificationManager sharedInstance].loadingBarStatus) {
        return;
    }
    if ([SHNotificationManager sharedInstance].loadingBar) {
        [[SHNotificationManager sharedInstance].loadingBar hide];
        [SHNotificationManager sharedInstance].loadingBar = nil;
        
        [SHNotificationManager sharedInstance].loadingBarStatus = NO;
    };
}

@end
