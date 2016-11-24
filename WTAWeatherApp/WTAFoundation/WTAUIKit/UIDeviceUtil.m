//
//  UIDeviceUtil.m
//  WTAWeatherApp
//


#import "UIDeviceUtil.h"
#import <sys/utsname.h>
#import <AdSupport/AdSupport.h>

@implementation UIDeviceUtil

+ (NSString *)hardwareType
{
    struct utsname systemInfo;
    uname(&systemInfo);

    return [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
}

+ (NSString *)platformType
{
    static NSString *g_platformType = nil;
    if (g_platformType == nil) {
        NSString *result = [self hardwareType];
        const NSDictionary *platforms = @{@"i386": @"Simulator",
                                          @"x86_64": @"Simulator",
                                          @"iPod3,1": @"iPod Touch 3",
                                          @"iPod4,1": @"iPod Touch 4",
                                          @"iPod5,1": @"iPod Touch 5",
                                          @"iPhone2,1": @"iPhone 3Gs",
                                          @"iPhone3,1": @"iPhone 4",
                                          @"iPhone4,1": @"iPhone 4s",
                                          @"iPhone5,1": @"iPhone 5",
                                          @"iPhone5,2": @"iPhone 5",
                                          @"iPhone5,3": @"iPhone 5c",
                                          @"iPhone5,4": @"iPhone 5c",
                                          @"iPhone6,1": @"iPhone 5s",
                                          @"iPhone6,2": @"iPhone 5s",
                                          @"iPhone7,1": @"iPhone 6 Plus",
                                          @"iPhone7,2": @"iPhone 6",
                                          @"iPhone8,1": @"iPhone 6s",
                                          @"iPhone8,2": @"iPhone 6s Plus",
                                          @"iPad2,1": @"iPad 2",
                                          @"iPad2,2": @"iPad 2",
                                          @"iPad2,3": @"iPad 2",
                                          @"iPad3,1": @"iPad 3",
                                          @"iPad3,2": @"iPad 3",
                                          @"iPad3,3": @"iPad 3",
                                          @"iPad3,4": @"iPad 4",
                                          @"iPad3,5": @"iPad 4",
                                          @"iPad3,6": @"iPad 4",
                                          @"iPad4,1": @"iPad Air",
                                          @"iPad4,2": @"iPad Air",
                                          @"iPad2,5": @"iPad Mini",
                                          @"iPad2,6": @"iPad Mini",
                                          @"iPad2,7": @"iPad Mini",
                                          @"iPad4,4": @"iPad Mini Retina",
                                          @"iPad4,5": @"iPad Mini Retina"};

        g_platformType = [platforms objectForKey:result];
        if (g_platformType == nil) {
            g_platformType = result;
        }
    }

    return g_platformType;
}

+ (NSString *)deviceName
{
    return [[UIDevice currentDevice] name];
}

+ (NSString *)systemVersionString
{
    return [[UIDevice currentDevice] systemVersion];
}

+ (CGFloat)systemVersion
{
    static CGFloat version = 0;
    if (version == 0) {
        version = [[[UIDevice currentDevice] systemVersion] floatValue];
    }
    return version;
}

+ (BOOL)isOSVersionGreaterOrEqualTo:(CGFloat)osVersion
{
    return (BOOL)([self systemVersion] >= osVersion);
}

+ (BOOL)iOS7OrLater
{
    static short siOS7AndLater = -1;
    if (siOS7AndLater == -1) {
        siOS7AndLater = [self isOSVersionGreaterOrEqualTo:7.f];
    }
    return (BOOL)siOS7AndLater;
}

@end
