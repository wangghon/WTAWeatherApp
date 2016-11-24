//
//  UIScreenUtil.m
//  WTAWeatherApp
//


#import "UIScreenUtil.h"
#import "UIDeviceUtil.h"

@implementation UIScreenUtil

+ (CGFloat)screenScale
{
    return [UIScreen mainScreen].scale;
}

+ (CGSize)applicationFrameSize
{
    CGRect frame = [[UIScreen mainScreen] applicationFrame];
    if ([UIDeviceUtil iOS7OrLater]) {
        frame.size.height += frame.origin.y;
    }
    return frame.size;
}

+ (CGSize)screenSize
{
    return [UIScreen mainScreen].bounds.size;
}

+ (BOOL)is35InchScreen
{
    return ([self screenSize].height == 480);// width 320
}

+ (BOOL)is4InchScreen
{
    return ([self screenSize].height == 568);// width 320
}

+ (BOOL)is47InchScreen
{
    return ([self screenSize].height == 667);// width 375
}

+ (BOOL)is55InchScreen
{
    return ([self screenSize].height == 736);// width 414
}

+ (BOOL)is4InchOrBiggerScreen
{
    return (([self screenSize].height >= 568.0f) ? YES : NO);
}

+ (BOOL)is47InchOrBiggerScreen
{
    return (([self screenSize].height >= 667.0f) ? YES : NO);
}

@end

__BEGIN_DECLS

CGFloat DuNativeResource1PixelSize(void)
{
    static CGFloat sNativeResource1PixelSize = -1;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        CGFloat scale = [UIScreenUtil screenScale];
        sNativeResource1PixelSize = 1.f / scale;
    });
    return sNativeResource1PixelSize;
}

ResourceDimension DuNativeResourceDimension(void)
{
    static NSInteger sResourceDimension = -1;
    if (sResourceDimension == -1) {
        CGFloat height = [UIScreenUtil screenSize].height;
        if (height == 736) {
            sResourceDimension = ResourceDimension55Inch;
        } else if (height == 667) {
            sResourceDimension = ResourceDimension47Inch;
        } else if (height == 568) {
            sResourceDimension = ResourceDimension4Inch;
        } else if (height == 480) {
            sResourceDimension = ResourceDimension35Inch;
        } else {
            sResourceDimension = ResourceDimensionUnsupport;
        }
    }
    return sResourceDimension;
}

CGSize DuNativeResourceCGSizeFromCGSize(CGSize size, ResourceDimension dimension, BOOL autoScale)
{
    ResourceDimension resourceDimension = DuNativeResourceDimension();
    CGFloat factor_x = 1.f, factor_y = 1.f;
    if (resourceDimension != dimension && autoScale) {
        if (resourceDimension == ResourceDimension55Inch) {
            factor_x = factor_y = 1.104f;
        } else if (resourceDimension == ResourceDimension4Inch) {
            factor_x = factor_y = 1.f / 1.171875f;
        } else if (resourceDimension == ResourceDimension35Inch) {
            factor_x = factor_y = 1.f / 1.171875f;
        }
    }
    CGFloat onePixelSize = DuNativeResource1PixelSize();
    CGFloat width = nearbyintf(size.width * factor_x / onePixelSize) * onePixelSize;
    CGFloat height = nearbyintf(size.height * factor_y / onePixelSize) * onePixelSize;
    return CGSizeMake(width, height);
}

CGFloat DuScaleParam(void)
{
    return ([UIScreen mainScreen].bounds.size.width / 320.f);
}

__END_DECLS
