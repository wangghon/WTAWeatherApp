//
//  UIResUtil.h
//  WTAWeatherApp
//


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

__BEGIN_DECLS

/**
 * Convert HEX RGBA value to UIColor, for example:
 * UIColorFromRGBA(0xffee00ff), ff->red, ee->green, 00->blue, ff->alpha.
 */
NS_INLINE UIColor *UIColorFromRGBA(uint32_t rgba)
{
    return [UIColor colorWithRed:((float)((rgba & 0xFF000000) >> 24)) / 255.0
                           green:((float)((rgba & 0xFF0000) >> 16)) / 255.0
                            blue:((float)((rgba & 0xFF00) >> 8)) / 255.0
                           alpha:((float)(rgba & 0xFF)) / 255.0];
}

/**
 * Convert HEX RGB value to UIColor. for example:
 * UIColorFromRGB_A(0xffee00, 1.f), ff->red, ee->green, 00->blue, 1.f->alpha.
 */
NS_INLINE UIColor *UIColorFromRGB_A(uint32_t rgb, CGFloat a)
{
    return [UIColor colorWithRed:((float)((rgb & 0xFF0000) >> 16)) / 255.0
                           green:((float)((rgb & 0xFF00) >> 8)) / 255.0
                            blue:((float)(rgb & 0xFF)) / 255.0
                           alpha:a];
}

/**
 * Convert HEX RGB value to UIColor, the alpha value would be 1.0f.
 */
NS_INLINE UIColor *UIColorFromRGB(uint32_t rgb)
{
    return UIColorFromRGB_A(rgb, 1.f);
}

/**
 * Convert HEX RGB string to UIColor, the alpha value would be 1.0f.
 */
NS_INLINE UIColor *UIColorFromRGBHexString(NSString *hexString)
{
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    uint32_t hex = 0;
    [scanner scanHexInt:&hex];

    return UIColorFromRGB(hex);
}

/**
 * Convert uint8_t R,G,B,A value to UIColor. for example:
 * UIColorFromR_G_B(0, 255, 0, 1.f), 0->red, 255->green, 0->blue, 1.f->alpha.
 */
NS_INLINE UIColor *UIColorFromR_G_B_A(uint8_t r, uint8_t g, uint8_t b, CGFloat a)
{
    return [UIColor colorWithRed:b / 255.f green:g / 255.f blue:b / 255.f alpha:a];
}

/**
 * Convert uint8_t R,G,B value to UIColor, the alpha value would be 1.0f. for example:
 * UIColorFromR_G_B(0, 255, 0), 0->red, 255->green, 0->blue, 1.f->alpha.
 */
NS_INLINE UIColor *UIColorFromR_G_B(uint8_t r, uint8_t g, uint8_t b)
{
    return UIColorFromR_G_B_A(r, g, b, 1.f);
}

__END_DECLS
