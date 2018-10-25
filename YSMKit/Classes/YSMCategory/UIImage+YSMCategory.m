//
//  UIImage+Category.m
//  YSMOCTools
//
//  Created by duanzengguang on 2017/12/5.
//  Copyright © 2017年 忆思梦吧. All rights reserved.
//

#import "UIImage+YSMCategory.h"

@implementation UIImage (YSMCategory)

+ (UIImage *)ysm_imageNamed:(NSString *)name inBundle:(NSBundle *)bundle{
    if ([UIImage respondsToSelector:@selector(imageNamed:inBundle:compatibleWithTraitCollection:)]) {
        return [UIImage imageNamed:name inBundle:bundle compatibleWithTraitCollection:nil];
    } else {
        return [UIImage imageWithContentsOfFile:[bundle pathForResource:name ofType:@"png"]];
    }
}

#pragma mark -- 返回一个指定大小、颜色的纯色图片
+ (UIImage *)imageWithColor:(UIColor *)color andRect:(CGRect)rect{
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

#pragma mark -- 将视图变为图片
+ (UIImage *)imageWithUIView:(UIView*) view{
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(view.bounds.size);
    CGContextRef currnetContext = UIGraphicsGetCurrentContext();
    //[view.layer drawInContext:currnetContext];
    [view.layer renderInContext:currnetContext];
    // 从当前context中创建一个改变大小后的图片
    UIImage* image = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    return image;
}

- (NSUInteger)memorysize{
    return CGImageGetWidth(self.CGImage)*CGImageGetHeight(self.CGImage);
}

- (UIColor *)colorAtPixel:(CGPoint)point{
    if (!CGRectContainsPoint(CGRectMake(0.0f, 0.0f, self.size.width, self.size.height), point)){
        return nil;
    }
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    int bytesPerPixel = 4;
    int bytesPerRow = bytesPerPixel * 1;
    NSUInteger bitsPerComponent = 8;
    unsigned char pixelData[4] = {0, 0, 0, 0};
    
    CGContextRef context = CGBitmapContextCreate(pixelData,
                                                 1,
                                                 1,
                                                 bitsPerComponent,
                                                 bytesPerRow,
                                                 colorSpace,
                                                 kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    CGColorSpaceRelease(colorSpace);
    CGContextSetBlendMode(context, kCGBlendModeCopy);
    
    CGContextTranslateCTM(context, -point.x, point.y - self.size.height);
    CGContextDrawImage(context, CGRectMake(0.0f, 0.0f, self.size.width, self.size.height), self.CGImage);
    CGContextRelease(context);
    
    CGFloat red   = (CGFloat)pixelData[0] / 255.0f;
    CGFloat green = (CGFloat)pixelData[1] / 255.0f;
    CGFloat blue  = (CGFloat)pixelData[2] / 255.0f;
    CGFloat alpha = (CGFloat)pixelData[3] / 255.0f;
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

- (UIImage *)ysm_compressBelowMaxLength:(NSUInteger)maxLength {
    CGFloat ratio = 1.0;
    CGFloat quality = 1.0;
    UIImage *result = self;
    
    NSData *data = UIImageJPEGRepresentation(self, quality);
    while (data.length > maxLength) {
        if (ratio > quality) {
            ratio -= 0.1;
            result = [self ysm_scaleToScale:ratio];
            data = UIImageJPEGRepresentation(result, quality);
        }else{
            quality -= 0.1;
            data = UIImageJPEGRepresentation(result, quality);
        }
    }
    return [UIImage imageWithData:data];
}

- (UIImage *)ysm_scaleToScale:(float)scale {
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(self.size.width * scale, self.size.height * scale), NO, [UIScreen mainScreen].scale);
    [self drawInRect:CGRectMake(0, 0, self.size.width * scale, self.size.height * scale)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}

- (UIImage *)ysm_scaleImageWithData:(NSData *)data withSize:(CGSize)size scale:(CGFloat)scale orientation:(UIImageOrientation)orientation{
    CGFloat maxPixels = MAX(size.width, size.height);
    CGImageSourceRef sourceRef = CGImageSourceCreateWithData((__bridge CFDataRef)data, nil);
    NSDictionary *options = @{(__bridge id)kCGImageSourceCreateThumbnailFromImageAlways:(__bridge id)kCFBooleanTrue,
                              (__bridge id)kCGImageSourceThumbnailMaxPixelSize:[NSNumber numberWithFloat:maxPixels]
                              };
    CGImageRef imageRef = CGImageSourceCreateThumbnailAtIndex(sourceRef, 0, (__bridge CFDictionaryRef)options);
    UIImage *result = [UIImage imageWithCGImage:imageRef scale:scale orientation:orientation];
    CGImageRelease(imageRef);
    CFRelease(sourceRef);
    return result;
}


@end

@implementation UIImage (YSMRender)

- (UIImage *)ysm_templateImage{
    if ([self respondsToSelector:@selector(imageWithRenderingMode:)]){   //iOS 7.0+
        return [self imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    }else{
        return self;
    }
}

- (UIImage *)ysm_originalImage{
    if ([self respondsToSelector:@selector(imageWithRenderingMode:)]){   //iOS 7.0+
        return [self imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }else{
        return self;
    }
}

#pragma mark -- 使用blend改变图片颜色
- (UIImage *)imageWithTintColor:(UIColor *)tintColor{
    return [self imageWithTintColor:tintColor blendMode:kCGBlendModeDestinationIn];
}
- (UIImage *)imageWithGradientTintColor:(UIColor *)tintColor{
    return [self imageWithTintColor:tintColor blendMode:kCGBlendModeOverlay];
}
- (UIImage *)imageWithTintColor:(UIColor *)tintColor blendMode:(CGBlendMode)blendMode{
    //We want to keep alpha, set opaque to NO; Use 0.0f for scale to use the scale factor of the device’s main screen.
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0f);
    [tintColor setFill];
    CGRect bounds = CGRectMake(0, 0, self.size.width, self.size.height);
    UIRectFill(bounds);
    //Draw the tinted image in context
    [self drawInRect:bounds blendMode:blendMode alpha:1.0f];
    if (blendMode != kCGBlendModeDestinationIn) {
        [self drawInRect:bounds blendMode:kCGBlendModeDestinationIn alpha:1.0f];
    }
    UIImage *tintedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return tintedImage;
}

- (UIImage *)ysm_resizableImage{
    return [self ysm_resizableImageWithCapInsets:UIEdgeInsetsMake(self.size.height *.5f-1, self.size.width*.5f-1, self.size.height*.5f, self.size.width*.5f)];
}

- (UIImage *)ysm_resizableImageWithCapInsets:(UIEdgeInsets)capInsets{
    return [self resizableImageWithCapInsets:capInsets];
}

@end

@implementation UIImage (YSMCorner)

- (UIImage *)ysm_circleImage{
    return [self ysm_circleImageWithFillColor:[UIColor whiteColor]];
}

- (UIImage *)ysm_circleImageWithFillColor:(UIColor *)fillColor{
    return [self ysm_imageWithSize:self.size corners:UIRectCornerAllCorners cornerRadius:self.size.width fillColor:fillColor];
}

- (UIImage *)ysm_imageCorners:(UIRectCorner)corners cornerRadius:(CGFloat)cornerRadius{
    return [self ysm_imageWithSize:self.size corners:corners cornerRadius:cornerRadius];
}

- (UIImage *)ysm_imageWithSize:(CGSize)size corners:(UIRectCorner)corners cornerRadius:(CGFloat)cornerRadius{
    return [self ysm_imageWithSize:size corners:corners cornerRadius:cornerRadius fillColor:[UIColor whiteColor]];
}

- (UIImage *)ysm_imageWithCorners:(UIRectCorner)corners cornerRadius:(CGFloat)cornerRadius fillColor:(UIColor *)fillColor{
    return [self ysm_imageWithSize:self.size corners:corners cornerRadius:cornerRadius fillColor:fillColor];
}

- (UIImage *)ysm_imageWithSize:(CGSize)size corners:(UIRectCorner)corners cornerRadius:(CGFloat)cornerRadius fillColor:(UIColor *)fillColor{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContextWithOptions(size, YES, [UIScreen mainScreen].scale);
    // 添加颜色填充
    [fillColor setFill];
    UIRectFill(rect);
    UIBezierPath * path = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:corners cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
    [path addClip];
    // 将图片画上去
    [self drawInRect:rect];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    // 关闭上下文
    UIGraphicsEndImageContext();
    return image;
}


@end
