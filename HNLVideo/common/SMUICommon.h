//
//  SMUICommon.h
//  HNLVideo
//
//  Created by 谢印超 on 2017/3/6.
//  Copyright © 2017年 谢印超. All rights reserved.
//

#import <Foundation/Foundation.h>

/** String: Identifier **/
#define DEVICE_IDENTIFIER ( ( IS_IPAD ) ? DEVICE_IPAD : ( IS_IPHONE ) ? DEVICE_IPHONE , DEVICE_SIMULATOR )

/** String: iPhone **/
#define DEVICE_IPHONE @"iPhone"

/** String: iPad **/
#define DEVICE_IPAD @"iPad"

/** String: Device Model **/
#define DEVICE_MODEL ( [[UIDevice currentDevice ] model ] )

/** String: Localized Device Model **/
#define DEVICE_MODEL_LOCALIZED ( [[UIDevice currentDevice ] localizedModel ] )

/** String: Device Name **/
#define DEVICE_NAME ( [[UIDevice currentDevice ] name ] )

/** Double: Device Orientation **/
#define DEVICE_ORIENTATION ( [[UIDevice currentDevice ] orientation ] )

/** String: Simulator **/
#define DEVICE_SIMULATOR @"Simulator"

/** BOOL: Detect if device is an iPad **/
#define IS_IPAD ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad )

/** BOOL: Detect if device is an iPhone or iPod **/
#define IS_IPHONE ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone )

/** BOOL: Detect if device is an iPhone 5 **/
#define IS_IPHONE_5 ( IS_IPHONE ? CGSizeEqualToSize([[UIScreen mainScreen] preferredMode].size,CGSizeMake(640, 1136)) ? YES : NO : NO )

/** BOOL: IS_RETINA **/
#define IS_RETINA ( [[UIScreen mainScreen] respondsToSelector:@selector(scale)] && [[UIScreen mainScreen] scale] == 2 )

/** BOOL: Detect if device is the Simulator **/
#define IS_SIMULATOR ( TARGET_IPHONE_SIMULATOR )

/** BOOL: System version is above 7.0**/
#define OSABOVE7 ( [[UIDevice currentDevice].systemVersion floatValue] >= 7.0 )
#define IsOSVersionAtLeastiOS7()    (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_1)

#define ApplicationDelegate                 ((AppDelegate *)[[UIApplication sharedApplication] delegate])
#define UserDefaults                        [NSUserDefaults standardUserDefaults]
#define NotificationCenter                  [NSNotificationCenter defaultCenter]
#define SharedApplication                   [UIApplication sharedApplication]
#define Bundle                              [NSBundle mainBundle]
#define MainScreen                          [UIScreen mainScreen]
#define ShowNetworkActivityIndicator()      [UIApplication sharedApplication].networkActivityIndicatorVisible = YES
#define HideNetworkActivityIndicator()      [UIApplication sharedApplication].networkActivityIndicatorVisible = NO
#define NetworkActivityIndicatorVisible(x)  [UIApplication sharedApplication].networkActivityIndicatorVisible = x
#define NavBar                              self.navigationController.navigationBar
#define TabBar                              self.tabBarController.tabBar
#define NavBarHeight                        self.navigationController.navigationBar.bounds.size.height
#define TabBarHeight                        self.tabBarController.tabBar.bounds.size.height
#define ScreenWidth                         [[UIScreen mainScreen] bounds].size.width
#define ScreenHeight                        [[UIScreen mainScreen] bounds].size.height
#define TouchHeightDefault                  44
#define TouchHeightSmall                    32
#define ViewWidth(v)                        v.frame.size.width
#define ViewHeight(v)                       v.frame.size.height
#define ViewX(v)                            v.frame.origin.x
#define ViewY(v)                            v.frame.origin.y
#define SelfViewWidth                       self.view.bounds.size.width
#define SelfViewHeight                      self.view.bounds.size.height
#define RectX(f)                            f.origin.x
#define RectY(f)                            f.origin.y
#define RectWidth(f)                        f.size.width
#define RectHeight(f)                       f.size.height
#define RectSetWidth(f, w)                  CGRectMake(RectX(f), RectY(f), w, RectHeight(f))
#define RectSetHeight(f, h)                 CGRectMake(RectX(f), RectY(f), RectWidth(f), h)
#define RectSetX(f, x)                      CGRectMake(x, RectY(f), RectWidth(f), RectHeight(f))
#define RectSetY(f, y)                      CGRectMake(RectX(f), y, RectWidth(f), RectHeight(f))
#define RectSetSize(f, w, h)                CGRectMake(RectX(f), RectY(f), w, h)
#define RectSetOrigin(f, x, y)              CGRectMake(x, y, RectWidth(f), RectHeight(f))
#define DATE_COMPONENTS                     NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit
#define TIME_COMPONENTS                     NSHourCalendarUnit|NSMinuteCalendarUnit|NSSecondCalendarUnit
#define RGB(r, g, b)                        [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]
#define RGBA(r, g, b, a)                    [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define HEX_COLOR(c)                        [UIColor colorWithRed:((c>>16)&0xFF)/255.0 green:((c>>8)&0xFF)/255.0 blue:(c&0xFF)/255.0 alpha:1.0]
#define UIColorFromRGB(c)                   [UIColor colorWithRed:((c>>16)&0xFF)/255.0 green:((c>>8)&0xFF)/255.0 blue:(c&0xFF)/255.0 alpha:1.0]
#define UIColorFromRGBA(c,a)                [UIColor colorWithRed:((c>>16)&0xFF)/255.0 green:((c>>8)&0xFF)/255.0 blue:(c&0xFF)/255.0 alpha:a]

#define SCREEN_H [[UIScreen mainScreen] bounds].size.height
#define SCREEN_W [[UIScreen mainScreen] bounds].size.width

#define TABBAR_H  (iPhone6_Plus ? TABBAR_H_6P : (iPhone5_Down ? TABBAR_H_5Down : TABBAR_H_6))
#define TABBAR_H_6  58.0
#define TABBAR_H_6P 64.0
#define TABBAR_H_5Down 49.0

#define iPhone6_Plus  ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(1125, 2001), [[UIScreen mainScreen] currentMode].size) || CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size)) : NO)
#define iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone6_Screen (CGRectGetWidth([[UIScreen mainScreen] bounds]) > 320 ? YES:NO)
#define iPhone5_Down (CGRectGetWidth([[UIScreen mainScreen] bounds]) <= 320 ? YES:NO)//iphone5以及以下的屏幕尺寸

#define BELOW_IOS9 [[[UIDevice currentDevice]systemVersion] floatValue] < 9.0
#define IOS10 [[[UIDevice currentDevice]systemVersion] floatValue] >= 10.0
#define IOS9 [[[UIDevice currentDevice]systemVersion] floatValue] >= 9.0
#define IOS8 [[[UIDevice currentDevice]systemVersion] floatValue] >= 8.0
#define IOS7 [[[UIDevice currentDevice]systemVersion] floatValue] >= 7.0
#define IS_IOS6 [[[UIDevice currentDevice]systemVersion] floatValue] < 7.0
#define IS_IOS7 [[[UIDevice currentDevice]systemVersion] floatValue] < 8.0

#define SCREEN_ABOUT_4INCH (ScreenHeight > 480.0)


#define SCREEN_REAL_H ([UIScreen mainScreen].currentMode.size.height / [UIScreen mainScreen].scale)
#define SCREEN_REAL_W ([UIScreen mainScreen].currentMode.size.width / [UIScreen mainScreen].scale)


#if __IPHONE_OS_VERSION_MIN_REQUIRED >= 70000
#define QHSR_TEXTSIZE(text, font) [text length] > 0 ? [text \
sizeWithAttributes:@{NSFontAttributeName:font}] : CGSizeZero;
#else
#define QHSR_TEXTSIZE(text, font) [text length] > 0 ? [text sizeWithFont:font constrainedToSize:CGSizeMake(MAXFLOAT, 30)] : CGSizeZero;
#endif

#if __IPHONE_OS_VERSION_MIN_REQUIRED >= 70000
#define QHSR_MULTILINE_TEXTSIZE(text, font, maxSize, mode) [text length] > 0 ? [text \
boundingRectWithSize:maxSize options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading) \
attributes:@{NSFontAttributeName:font} context:nil].size : CGSizeZero;
#else
#define QHSR_MULTILINE_TEXTSIZE(text, font, maxSize, mode) [text length] > 0 ? [text \
sizeWithFont:font constrainedToSize:maxSize lineBreakMode:mode] : CGSizeZero;
#endif

#define DEGREES_TO_RADIANS(angle) (angle / 180.0 * M_PI)


#define FONT(size)        [UIFont systemFontOfSize:size]
#define BOLD_FONT(size)   [UIFont boldSystemFontOfSize:size]
#define ITALIC_FONT(size) [UIFont italicSystemFontOfSize:size]


#define FONT_SCALE   (iPhone6_Plus ? 1.15 : 1.0)

#define FONT_AS(size)        [UIFont systemFontOfSize:size * FONT_SCALE]
#define BOLD_FONT_AS(size)   [UIFont boldSystemFontOfSize:size * FONT_SCALE]
#define ITALIC_FONT_AS(size) [UIFont italicSystemFontOfSize:size * FONT_SCALE]




@interface SMUICommon : NSObject

@end
