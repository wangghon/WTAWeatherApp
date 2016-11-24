//
//  UIScreenUtil.h
//  WTAWeatherApp
//


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIScreenUtil : NSObject

/**
 * Get current device's screen scale.
 */
+ (CGFloat)screenScale;

/**
 * Get current application's frame size.
 */
+ (CGSize)applicationFrameSize;

/**
 * Get current device's screen size.
 */
+ (CGSize)screenSize;

/**
 * Judge if current device's screen is 3.5 inch.
 */
+ (BOOL)is35InchScreen;

/**
 * Judge if current device's screen is 4 inch.
 */
+ (BOOL)is4InchScreen;

/**
 * Judge if current device's screen is 4.7 inch.
 */
+ (BOOL)is47InchScreen;

/**
 * Judge if current device's screen is 5.5 inch.
 */
+ (BOOL)is55InchScreen;

/**
 * Judge if current device's screen is 4 inch or bigger.
 */
+ (BOOL)is4InchOrBiggerScreen;

/**
 * Judge if current device's screen is 4.7 inch or bigger.
 */
+ (BOOL)is47InchOrBiggerScreen;

@end

__BEGIN_DECLS

#pragma mark - Native Resource Dimension
typedef NS_ENUM(NSInteger, ResourceDimension) {
    ResourceDimensionUnsupport,
    ResourceDimension55Inch,
    ResourceDimension47Inch,
    ResourceDimension4Inch,
    ResourceDimension35Inch
};

extern ResourceDimension DuNativeResourceDimension(void);

extern CGFloat DuNativeResource1PixelSize(void);

extern CGSize DuNativeResourceCGSizeFromCGSize(CGSize size, ResourceDimension dimension, BOOL autoScale);

NS_INLINE CGSize DuNativeResourceCGSize(CGSize size)
{
    return DuNativeResourceCGSizeFromCGSize(size, ResourceDimension47Inch, YES);
}

NS_INLINE CGPoint DuNativeResourceCGPoint(CGPoint point)
{
    CGSize size = DuNativeResourceCGSizeFromCGSize(CGSizeMake(point.x, point.y), ResourceDimension47Inch, YES);
    return CGPointMake(size.width, size.height);
}

NS_INLINE CGFloat DuNativeResourceWidth(CGFloat width)
{
    return DuNativeResourceCGSizeFromCGSize(CGSizeMake(width, 0), ResourceDimension47Inch, YES).width;
}

NS_INLINE CGFloat DuNativeResourceHeight(CGFloat height)
{
    return DuNativeResourceCGSizeFromCGSize(CGSizeMake(0, height), ResourceDimension47Inch, YES).height;
}

CGFloat DuScaleParam(void) __deprecated_msg("use DuNativeXXX instead");

__END_DECLS
