//
//  UIDeviceUtil.h
//  WTAWeatherApp
//


#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <UIKit/UIKit.h>

@interface UIDeviceUtil : NSObject
/**
 * Get current device's hardware type, for example iPhone5,1, iPhone5,2, etc.
 */
+ (NSString *)hardwareType;

/**
 * Get current device's platform type, for example iPhone 5s, iPad Air, etc.
 */
+ (NSString *)platformType;

/**
 * Get current device's name, for example My iPhone 5s, etc.
 */
+ (NSString *)deviceName;

/**
 * Get the iOS system version
 */
+ (NSString *)systemVersionString;

/**
 * Get the iOS system version
 */
+ (CGFloat)systemVersion;

/**
 * Check if the current system version is greater or equal to the given osVersion.
 */
+ (BOOL)isOSVersionGreaterOrEqualTo:(CGFloat)osVersion;

/**
 * Check if the iOS system is iOS 7 and later
 */
+ (BOOL)iOS7OrLater;

@end
