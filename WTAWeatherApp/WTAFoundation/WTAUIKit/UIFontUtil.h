//
//  UIResUtil.h
//  UIUtils
//


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "UIScreenUtil.h"

__BEGIN_DECLS

NS_INLINE UIFont* UIFontWithParam(NSString *fontName, CGFloat fontSize)
{
    UIFont *font = [UIFont fontWithName:fontName size:fontSize];
    return font;
}

NS_INLINE UIFont* UINativeFontWithParam(NSString *fontName, CGFloat fontSize)
{
    return UIFontWithParam(fontName, DuNativeResourceHeight(fontSize));
}

#pragma mark - Custom Font Utils
NS_INLINE UIFont* UICustomFontOfSize(CGFloat fontSize)
{
    return UIFontWithParam(@"DINMittelschrift-Alternate", fontSize);
}

#pragma mark Custom Native Font
NS_INLINE UIFont* UICustomNativeFontOfSize(CGFloat fontSize)
{
    return UICustomFontOfSize(DuNativeResourceHeight(fontSize));
}

#pragma mark - Default Font Utils
NS_INLINE UIFont* UIFontOfSize(CGFloat fontSize)
{
    return UIFontWithParam(@"HelveticaNeue", fontSize);
}

NS_INLINE UIFont* UIBoldFontOfSize(CGFloat fontSize)
{
    return UIFontWithParam(@"HelveticaNeue-Bold", fontSize);
}

#pragma mark Native Font
NS_INLINE UIFont* UINativeFontOfSize(CGFloat fontSize)
{
    return UIFontOfSize(DuNativeResourceHeight(fontSize));
}

NS_INLINE UIFont* UINativeBoldFontOfSize(CGFloat fontSize)
{
    return UIBoldFontOfSize(DuNativeResourceHeight(fontSize));
}
//2.6新加字体---用于数字展示
#pragma mark - number Font Utils
NS_INLINE UIFont* UINumberFontOfSize(CGFloat fontSize)
{
    return UIFontWithParam(@"DINPro-Regular", fontSize);
}
NS_INLINE UIFont* UINativeNumberFontOfSize(CGFloat fontSize)
{
    return UINumberFontOfSize(DuNativeResourceHeight(fontSize));
}
__END_DECLS
