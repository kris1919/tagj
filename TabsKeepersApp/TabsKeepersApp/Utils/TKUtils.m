//
//  TKUtils.m
//  TabsKeepersApp
//
//  Created by tsfa on 2019/4/24.
//  Copyright © 2019 Marco. All rights reserved.
//

#import "TKUtils.h"
#import "UIFont+PingFangSC.h"

@implementation TKUtils

+ (__kindof UIViewController *)viewControllerWithStory:(NSString *)story storyId:(NSString *)storyId{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:story bundle:nil];
    return [sb instantiateViewControllerWithIdentifier:storyId];
}

+ (UIView *)nibWithNibName:(NSString *)nibName{
    return [[NSBundle mainBundle] loadNibNamed:nibName owner:nil options:nil].firstObject;
}
+ (NSString *)pathForCache:(NSString *)finder{
    NSString *cachePath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask,YES).lastObject;
    NSString *nextPath = [cachePath stringByAppendingPathComponent:finder];
    if (![[NSFileManager defaultManager] fileExistsAtPath:nextPath isDirectory:nil]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:nextPath withIntermediateDirectories:NO attributes:nil error:nil];
    }
    return nextPath;
}
/** 解决旋转90度问题 */
+ (UIImage *)fixOrientation:(UIImage *)aImage
{
    // No-op if the orientation is already correct
    if (aImage.imageOrientation == UIImageOrientationUp)
        return aImage;
    
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, aImage.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, aImage.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        default:
            break;
    }
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        default:
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, aImage.size.width, aImage.size.height,
                                             CGImageGetBitsPerComponent(aImage.CGImage), 0,
                                             CGImageGetColorSpace(aImage.CGImage),
                                             CGImageGetBitmapInfo(aImage.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (aImage.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.height,aImage.size.width), aImage.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.width,aImage.size.height), aImage.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}

+ (CGFloat)heightForString:(NSString *)string Width:(CGFloat)width fontSize:(int)fontSize lineSpace:(int)lineSpace{
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.lineSpacing = lineSpace;
    style.lineBreakMode = NSLineBreakByCharWrapping;
    CGRect bounds = [string boundingRectWithSize:CGSizeMake(width, 0) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingTruncatesLastVisibleLine attributes:@{NSFontAttributeName:[UIFont pingFangFontOfSize:fontSize],NSParagraphStyleAttributeName:style} context:nil];
    return bounds.size.height;
}
@end
