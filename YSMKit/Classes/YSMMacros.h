//
//  YSMMacros.h
//  YSMKit
//
//  Created by duanzengguang on 2018/9/28.
//

#ifndef YSMMacros_h
#define YSMMacros_h

#define YSM_RGB(__r, __g, __b) [UIColor colorWithRed:(__r / 255.0) green:(__g / 255.0) blue:(__b / 255.0) alpha:1]
#define YSM_RGBA(__r, __g, __b, __a) [UIColor colorWithRed:(__r / 255.0) green:(__g / 255.0) blue:(__b / 255.0) alpha:__a]

#define YSM_HEXCOLOR(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define YSM_HEXCOLORA(rgbValue,__a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:__a]

//--------------------------------------------------------------------------------------------------
//Global frames

#define kYSM_iPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define kYSM_iPhone (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)

#define kYSM_IS_IPHONE_X   (kYSM_iPhone && kYSM_ScreenHeight == 812.0)

#define kYSM_ScreenWidth MIN([[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height)
#define kYSM_ScreenHeight MAX([[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height)
#define kYSM_AppWidth MIN([[UIScreen mainScreen] applicationFrame].size.width, [[UIScreen mainScreen] applicationFrame].size.height)
#define kYSM_AppHeight MAX([[UIScreen mainScreen] applicationFrame].size.width, [[UIScreen mainScreen] applicationFrame].size.height)
#define kYSM_AppOrientation [[UIApplication sharedApplication] statusBarOrientation]
#define kYSM_IsPortrait UIInterfaceOrientationIsPortrait([[UIApplication sharedApplication] statusBarOrientation])
#define kYSM_StatusBarHeight [[UIApplication sharedApplication] statusBarFrame].size.height
#define kYSM_NavigationBarHeight 44.0f
#define kYSM_TopBarHeight (kYSM_NavigationBarHeight+kYSM_StatusBarHeight)
#define kYSM_BottomBarHeight (kYSM_IS_IPHONE_X?83.0f:44.0f)
#define kYSM_NavigationBarLandscapeHeight 33.0f

#define kYSM_Width (kYSM_IsPortrait ? kYSM_ScreenWidth : kYSM_ScreenHeight)
#define kYSM_Height (kYSM_IsPortrait ? kYSM_ScreenHeight : kYSM_ScreenWidth)
#define kYSM_Rect kYSM_IsPortrait ? CGRectMake(0, 0, kYSM_ScreenWidth, kYSM_ScreenHeight) : CGRectMake(0, 0, kYSM_ScreenHeight, kYSM_ScreenWidth)
#define kYSM_SystemVersion [[[UIDevice currentDevice] systemVersion] floatValue]
//--------------------------------------------------------------------------------------------------
// 程序主目录
#define kYSM_HomePath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]
// 缓存目录
#define kYSM_TempPath [NSHomeDirectory() stringByAppendingPathComponent:@"/tmp"]
//--------------------------------------------------------------------------------------------------

#ifdef DEBUG
#define YSMLog(fmt,...) NSLog((@"%s:" fmt), __PRETTY_FUNCTION__, ##__VA_ARGS__);
#else
#define YSMLog(...)
#endif

#define YSMLogRect(rect) YSMLog(@"%s x:%.4f, y:%.4f, w:%.4f, h:%.4f", #rect, rect.origin.x, rect.origin.y, rect.size.width, rect.size.height)
#define YSMLogSize(size) YSMLog(@"%s w:%.4f, h:%.4f", #size, size.width, size.height)
#define YSMLogPoint(point) YSMLog(@"%s x:%.4f, y:%.4f", #point, point.x, point.y)
//--------------------------------------------------------------------------------------------------

#define YSM_SINGLETON_DEF(_type_) + (_type_ *)sharedInstance;\
+ (instancetype)alloc __attribute__((unavailable("call sharedInstance instead")));\
+ (instancetype)new __attribute__((unavailable("call sharedInstance instead")));\
- (instancetype)copy __attribute__((unavailable("call sharedInstance instead")));\
- (instancetype)mutableCopy __attribute__((unavailable("call sharedInstance instead")));

#define YSM_SINGLETON_IMP(_type_) + (_type_ *)sharedInstance{\
static _type_ *sharedInstance = nil;\
static dispatch_once_t onceToken;\
dispatch_once(&onceToken, ^{\
sharedInstance = [[super alloc] init];\
});\
return sharedInstance;\
}

#endif /* YSMMacros_h */
