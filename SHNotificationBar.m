//
//  SHNotificationBar.m
//  SohaSDK
//
//  Created by Kent on 1/9/15.
//  Copyright (c) 2015 Sohagame Corporation. All rights reserved.
//

#import "SHNotificationBar.h"
//#import "UIView+Additions.h"
//#import "SHUtility.h"
//#import "UIViewController+Additions.h"

@implementation SHNotificationBar

#define DEFAULT_SHOW_DURATION 3.0
#define ALPHA_OF_TOOLBAR 0.7
#define MARGIN_BETWEEN_LEFTVIEW_LABEL 5.0
#define MARGIN_LEADING 20.0
#define MESSAGE_FONT_SIZE 12.0

#define LOCAL_BAR_HEIGHT_PAD    60.0
#define LOCAL_BAR_HEIGHT_PHONE  50.0

#define LOCAL_BAR_HEIGHT_PHONE_PORTRAIT     50.0
#define LOCAL_BAR_HEIGHT_PHONE_LANDSCAPE    44.0

#define DURATION_OF_ANIMATION 0.3
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

#define WIDTH_SCREEN [[UIScreen mainScreen] bounds].size.width
#define HEIGHT_SCREEN [[UIScreen mainScreen] bounds].size.height

#define ISLANDSCAPE UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation)
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.showDuration = DEFAULT_SHOW_DURATION;
        
        self.animationType = SohaNotificationAnimationFade;
        
        self.backgroundColor = [UIColor colorWithWhite:0.0 alpha:ALPHA_OF_TOOLBAR];
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleBottomMargin;
        
        self.leftView = nil;
        
        self.message = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.height+MARGIN_BETWEEN_LEFTVIEW_LABEL, 0, self.frame.size.width-self.frame.size.height-MARGIN_BETWEEN_LEFTVIEW_LABEL, self.frame.size.height)];
        _message.font = [UIFont systemFontOfSize:MESSAGE_FONT_SIZE];
        _message.textAlignment = NSTextAlignmentCenter;
        _message.textColor = [UIColor whiteColor];
        _message.backgroundColor = [UIColor clearColor];
        _message.numberOfLines = 0;
        _message.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleLeftMargin;
        
        [self addSubview:_message];
        
        [self registerForNotifications];
        
        
        self.userInteractionEnabled = YES;
        
        //        UISwipeGestureRecognizer *swipeUpgGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
        //        swipeUpgGesture.direction = UISwipeGestureRecognizerDirectionUp;
        //        [self addGestureRecognizer:swipeUpgGesture];
        
    }
    return self;
}

- (BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)panGestureRecognizer {
    CGPoint velocity = [panGestureRecognizer velocityInView:self];
    return fabs(velocity.y) > fabs(velocity.x); // vertical
}


- (void)handleSwipe:(UIPanGestureRecognizer*)recognizer {
    [self hide];
}

- (IBAction)swipeAction:(id)sender {
    [self hide];
}

- (void)hideManuallyEnable:(BOOL)hideManuallyEnable {
    _hideManuallyEnable = hideManuallyEnable;
    if (_hideManuallyEnable) {
        self.userInteractionEnabled = YES;
        
        UISwipeGestureRecognizer *gesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeAction:)];
        gesture.direction = UISwipeGestureRecognizerDirectionUp|UISwipeGestureRecognizerDirectionLeft|UISwipeGestureRecognizerDirectionRight;
        [self addGestureRecognizer:gesture];
        
    }
    else {
        self.userInteractionEnabled = NO;
    }
}

#pragma mark - Notifications

- (void)registerForNotifications {
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    
    [nc addObserver:self selector:@selector(statusBarOrientationDidChange:)
               name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];
}

- (void)unregisterFromNotifications {
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc removeObserver:self name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];
}

- (void)statusBarOrientationDidChange:(NSNotification *)notification {
    /*
     __block CGRect rect = [SHUtility currentGameBound];
     NSString *currSysVerBrand = [[[[UIDevice currentDevice] systemVersion] componentsSeparatedByString:@"."] firstObject];
     if ([currSysVerBrand isEqualToString:@"6"] || [currSysVerBrand isEqualToString:@"7"]) {
     // ios 6, 7
     if (UIDeviceOrientationIsPortrait([UIDevice currentDevice].orientation)) {
     if (rect.size.width > rect.size.height) {
     CGFloat temp = rect.size.width;
     rect.size.width = rect.size.height;
     rect.size.height = temp;
     }
     }
     else {
     if (rect.size.width < rect.size.height) {
     CGFloat temp = rect.size.width;
     rect.size.width = rect.size.height;
     rect.size.height = temp;
     }
     }
     }
     rect.size.height    = (UIDeviceOrientationIsPortrait([UIDevice currentDevice].orientation)) ? LOCAL_BAR_HEIGHT_PHONE_PORTRAIT : LOCAL_BAR_HEIGHT_PHONE_LANDSCAPE;
     
     self.frame = rect;
     */
    [self setNeedsLayout];
}


- (void)changeBackgroundColor:(UIColor *)color {
    self.backgroundColor = color;
}

- (void)layoutSubviews {
    
    if (_leftView) {
        BOOL doesExist = NO;
        for (UIView *subView in self.subviews) {
            if (subView == _leftView) {
                doesExist = YES;
            }
        }
        if (!doesExist) [self addSubview:_leftView];
    }
    
    if ([_message.text isMemberOfClass:[NSNull class]]) {
        _message.text = @"";
    }
    
    if (!_message.text) {
        _message.text = @"";
    }
    
    [_message sizeToFit];
    
    CGFloat widthScreen;
    
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0")) {
        widthScreen = WIDTH_SCREEN;
    }
    else {
        widthScreen = UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation)? HEIGHT_SCREEN : WIDTH_SCREEN;
    }
    CGFloat maxBarHeight = CGRectGetHeight(self.bounds);
    CGFloat maxContentWidth = widthScreen-2*MARGIN_LEADING;
    
    CGFloat maxLabelContentWidth = _leftView ? (maxContentWidth-MARGIN_BETWEEN_LEFTVIEW_LABEL-CGRectGetWidth(_leftView.frame)) : maxContentWidth;
    
    if (!_message.text) {
        _message.text = @"";
    }
    
    NSAttributedString *attributedText =
    [[NSAttributedString alloc] initWithString:_message.text
                                    attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:MESSAGE_FONT_SIZE]}];
    CGRect desireRect = [attributedText boundingRectWithSize:(CGSize){maxLabelContentWidth, CGFLOAT_MAX}
                                                     options:NSStringDrawingUsesLineFragmentOrigin
                                                     context:nil];
    CGSize desireSize = desireRect.size;
    CGFloat desireHeight = ceilf(desireSize.height);
    if (desireHeight > (maxBarHeight-MARGIN_LEADING/2)) {
        maxBarHeight = desireHeight+MARGIN_LEADING/2;
    }
    
    if (_leftView) {
        CGRect leftViewRect = CGRectMake(MARGIN_LEADING, (self.frame.size.height-_leftView.frame.size.height)/2, _leftView.frame.size.width, _leftView.frame.size.height);
        _leftView.frame = leftViewRect;
    }
    
    CGRect labelRect = CGRectMake(0, (maxBarHeight-desireHeight)/2, maxLabelContentWidth, desireHeight);
    if (_leftView) {
        labelRect.origin.x = MARGIN_LEADING+CGRectGetWidth(_leftView.frame)+MARGIN_BETWEEN_LEFTVIEW_LABEL;
        _message.textAlignment = NSTextAlignmentLeft;
    }
    else {
        labelRect.origin.x = MARGIN_LEADING;
        _message.textAlignment = NSTextAlignmentCenter;
    }
    _message.frame = labelRect;
    
    self.frame = CGRectMake(0, 0, widthScreen, maxBarHeight);
}

- (void)show {
    __block CGRect rect = [UIScreen mainScreen].bounds;
//    if (ISLANDSCAPE) {
//        CGFloat temp = rect.size.width;
//        rect.size.width = rect.size.height;
//        rect.size.height = temp;
//    }

    rect.size.height    = ISLANDSCAPE ? LOCAL_BAR_HEIGHT_PHONE_LANDSCAPE : LOCAL_BAR_HEIGHT_PHONE_PORTRAIT;
    
    self.frame = rect;
    
    // immediately update view frame and its subviews
    [self setNeedsLayout];
    
    switch (_animationType) {
        case SohaNotificationAnimationBottom:
        {
            [self sohaChangeY:self.frame.size.height];
            [UIView animateWithDuration:DURATION_OF_ANIMATION
                             animations:^{
                                 [self sohaChangeY:rect.origin.y];
                             }
                             completion:^(BOOL finished) {
                                 if(_showDuration>0)
                                     [self performSelector:@selector(hide)
                                                           withObject:nil
                                                           afterDelay:_showDuration];
                                 
                                 // if you dont want it'll hide itself, set _showDuration = 0;
                             }];
            break;
        }
        case SohaNotificationAnimationFade:
        {
            [super showWithCompleteBlock:^(BOOL finished) {
                if(_showDuration>0)
                    [self performSelector:@selector(hide)
                                          withObject:nil
                                          afterDelay:_showDuration];
                
                // if you dont want it'll hide itself, set _showDuration = 0;
            }];
            break;
        }
        default:
            break;
    }
}

- (void)hide {
    switch (_animationType) {
        case SohaNotificationAnimationBottom:
        {

            [UIView animateWithDuration:DURATION_OF_ANIMATION
                             animations:^{
                                 [self sohaChangeY:self.frame.size.height];
                             }
                             completion:^(BOOL finished) {
                                 [self removeFromSuperview];
                             }];
            
            break;
        }
        case SohaNotificationAnimationFade:
        {
            [super hide];
            break;
        }
        default:
            break;
    }
}

- (void)changeMessage:(NSString *)newMessage {
    _message.text = newMessage;
}

- (void)dealloc{
    [self unregisterFromNotifications];
}

#pragma View addtion

- (void)sohaChangeX:(CGFloat)x
{
    self.frame = CGRectMake(x, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
}

- (void)sohaChangeY:(CGFloat)y
{
    self.frame = CGRectMake(self.frame.origin.x, y, self.frame.size.width, self.frame.size.height);
}

- (void)sohaChangeWidth:(CGFloat)width
{
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, width, self.frame.size.height);
}

- (void)sohaChangeHeight:(CGFloat)height
{
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, height);
}

- (void)sohaChangeAddX:(CGFloat)x
{
    [self sohaChangeX:(self.frame.origin.x + x)];
}

- (void)sohaChangeAddY:(CGFloat)y
{
    [self sohaChangeY:(self.frame.origin.y + y)];
}

- (void)sohaChangeAddWidth:(CGFloat)width
{
    [self sohaChangeWidth:(self.frame.size.width + width)];
}

- (void)sohaChangeAddHeight:(CGFloat)height
{
    [self sohaChangeHeight:(self.frame.size.height + height)];
}

@end
