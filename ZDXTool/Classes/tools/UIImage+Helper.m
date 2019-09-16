//
//  UIImage+Helper.m
//  ZLToolsDemo
//
//  Created by irisZL on 2017/9/19.
//  Copyright © 2017年 irisZL. All rights reserved.
//

#import "UIImage+Helper.h"
#import <Accelerate/Accelerate.h>

@implementation UIImage (Helper)

/*
 将当前图片压到指定体积
 size : 以bit为单位，比如，想要压缩到120KB 则size=120*1024
 */
- (UIImage *)pressImageWithMaxSize:(CGFloat)size
{
    CGFloat compression = 1.0f;
    NSData *imageData = UIImageJPEGRepresentation(self, compression);
    
    if ([imageData length] > size) {
        compression = size / ([imageData length]);
        NSData *compressionImageData = UIImageJPEGRepresentation(self, compression);
        CGFloat minCompression = 0.001f;
        
        while ([compressionImageData length] > size && compression >= minCompression)
        {
            if (compression <= 0.01) {
                compression -= 0.001;
            }
            else if (compression <= 0.1)
            {
                compression -= 0.02;
            }
            else
            {
                compression -= 0.2;
            }
            compressionImageData = UIImageJPEGRepresentation(self, compression);
        }
        
        imageData = compressionImageData;
    }
    return [UIImage imageWithData:imageData];
}

/*
 将当前图片压到指定体积
 originImage : 需要压体积的图片
 size : 以bit为单位，比如，想要压缩到120KB 则size=120*1024
 */
+ (UIImage *)pressImage:(UIImage *)originImage MaxSize:(CGFloat)size
{
    return [originImage pressImageWithMaxSize:size];
}

/**
 将当前图片缩放到指定大小
 targetWidth -> 目标宽度，高度等比缩放
 备注：等比缩放
 */
- (UIImage *)compressToTargetWidth:(CGFloat)targetWidth
{
    CGSize imageSize = self.size;
    
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    
    CGFloat targetHeight = (targetWidth / width)*height;
    
    UIGraphicsBeginImageContext(CGSizeMake(targetWidth, targetHeight));
    
    [self drawInRect:CGRectMake(0, 0, targetWidth, targetHeight)];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}


/**
 将图片缩放到指定大小
 targetWidth -> 目标宽度，高度等比缩放
 备注：等比缩放
 */
+ (UIImage *)compressImage:(UIImage *)image toTargetWidth:(CGFloat)targetWidth
{
    return [image compressToTargetWidth:targetWidth];
}

/**
 将当前图片缩放到指定大小
 targetHeight -> 目标高度
 */
- (UIImage *)compressToTargetHeight:(CGFloat)targetHeight
{
    CGSize imageSize = self.size;
    
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    
    CGFloat targetWidth = (targetHeight / height) * width;
    
    UIGraphicsBeginImageContext(CGSizeMake(targetWidth, targetHeight));
    
    [self drawInRect:CGRectMake(0, 0, targetWidth, targetHeight)];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

/**
 将当前图片缩放到指定大小
 targetHeight -> 目标高度
 */
+ (UIImage *)compressImage:(UIImage *)image toTargetHeight:(CGFloat)targetHeight
{
    return [image compressToTargetHeight:targetHeight];
}

/**
 将当前图片缩放到指定大小
 size -> 指定的大小
 备注：该方法由使用者控制大小，故不能保证是等比缩放
 */
- (UIImage *)compressToTargetSize:(CGSize)targetSize
{
    UIGraphicsBeginImageContext(targetSize);
    [self drawInRect:CGRectMake(0, 0, targetSize.width, targetSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

/**
 将图片缩放到指定大小
 size -> 指定的大小
 备注：该方法由使用者控制大小，故不能保证是等比缩放
 */
+ (UIImage *)comporessImage:(UIImage *)image toTargetSize:(CGSize )targetSize
{
    return [image compressToTargetSize:targetSize];
}

/**
 将当前图片裁剪指定区域
 rect -> 指定区域
 */
- (UIImage *)cutImageToTargetRect:(CGRect)rect
{
    CGImageRef imageRef = [self CGImage];
    
//    裁剪
    CGImageRef newImageRef = CGImageCreateWithImageInRect(imageRef, rect);
    
    UIImage *newImage = [UIImage imageWithCGImage:newImageRef];
    
    return newImage;
    
}

/**
 将图片裁剪到指定区域
 size -> 指定的区域
 */
+ (UIImage *)cutImage:(UIImage *)image toTargetRect:(CGRect)rect
{
    return [image cutImageToTargetRect:rect];
}

/**
 屏幕截图
 */
+ (UIImage *)screensShots
{
    UIWindow *screenWindow = [[UIApplication sharedApplication] keyWindow];
    UIGraphicsBeginImageContext(screenWindow.frame.size);
    [screenWindow.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *viewImage =UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return viewImage;
}

/**
 根据颜色生成纯色图片
 */
+ (UIImage *)getColorImageWithColor:(UIColor *)color
{
    return [self createImageWithColor:color andSize:CGSizeMake(0.1f, 0.1f)];
}

/**
 根据颜色和大小生成一张纯色图片
 */
+(UIImage *)createImageWithColor:(UIColor *)color andSize:(CGSize)size
{
    CGRect rect=CGRectMake(0.0f, 0.0f,size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

/**
 对当前图片进行图片模糊
 number： 模糊参数 （0.1 ~ 1.0）之间，表示模糊的程度
 */
- (UIImage *)blurWithBlurNumber:(CGFloat)number
{
    if (number < 0.0f || number > 1.0f) {
        
        number = 0.5;
    }
    
    int boxSize = (int)(number * 40);
    boxSize = boxSize - (boxSize % 2) + 1;
    CGImageRef img = self.CGImage;
    vImage_Buffer inBuffer, outBuffer;
    vImage_Error error;
    void *pixelBuffer;
    
    // 从CGImage中获取数据
    CGDataProviderRef inProvider = CGImageGetDataProvider(img);
    CFDataRef inBitmapData = CGDataProviderCopyData(inProvider);
    
    // 设置从CGImage获取对象的属性
    inBuffer.width = CGImageGetWidth(img);
    inBuffer.height = CGImageGetHeight(img);
    inBuffer.rowBytes = CGImageGetBytesPerRow(img);
    inBuffer.data = (void *)CFDataGetBytePtr(inBitmapData);
    pixelBuffer = malloc(CGImageGetBytesPerRow(img)*CGImageGetHeight(img));
    
    if (pixelBuffer == NULL) {
        NSLog(@"no pixelbuffer");
    }
    
    outBuffer.data = pixelBuffer;
    outBuffer.width = CGImageGetWidth(img);
    outBuffer.height = CGImageGetHeight(img);
    outBuffer.rowBytes = CGImageGetBytesPerRow(img);
    
    error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
    
    if (error) {
        NSLog(@"error from convolution %ld", error);
    }
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef ctx = CGBitmapContextCreate(outBuffer.data, outBuffer.width, outBuffer.height, 8, outBuffer.rowBytes, colorSpace, kCGImageAlphaNoneSkipLast);
    CGImageRef imageRef = CGBitmapContextCreateImage(ctx);
    UIImage *returnImage = [UIImage imageWithCGImage:imageRef];
    
    
    // clean up CGContextReleade(ctx)
    CGColorSpaceRelease(colorSpace);
    free(pixelBuffer);
    CFRelease(inBitmapData);
    CGColorSpaceRelease(colorSpace);
    CGImageRelease(imageRef);
    
    return returnImage;
}

/**
 对图片进行图片模糊
 number： 模糊参数 （0.1 ~ 1.0）之间，表示模糊的程度
 */
+ (UIImage *)blurImage:(UIImage *)image withBlurNumber:(CGFloat)number
{
    return [image blurWithBlurNumber:number];
}

/**
 获取当前图片某一个像素点的颜色
 point: 像素点的位置
 */
- (UIColor *)getPlexColorWithPoint:(CGPoint)point
{
    CGRect imageRect = CGRectMake(0, 0, self.size.width, self.size.height);
    
    if (!CGRectContainsPoint(imageRect, point)) {
        return nil;
    }
    
    NSInteger pointX = trunc(point.x);
    NSInteger pointY = trunc(point.y);
    
    CGImageRef cgImage = self.CGImage;
    
    NSUInteger height = self.size.height;
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    int bytesPerpixel = 4;
    int bytesPerRow = bytesPerpixel * 1;
    
    NSUInteger bitsPerComponent = 8;
    
    unsigned char piexlData[4] = {0,0,0,0};
    
    CGContextRef context = CGBitmapContextCreate(piexlData, 1, 1, bitsPerComponent, bytesPerRow, colorSpace, kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    CGColorSpaceRelease(colorSpace);
    CGContextSetBlendMode(context, kCGBlendModeCopy);
    
    
    CGContextTranslateCTM(context, -pointX, pointY - (CGFloat)height);
    
    CGContextDrawImage(context, imageRect, cgImage);
    CGContextRelease(context);
    
    CGFloat red = (CGFloat)piexlData[0] / 255.0;
    CGFloat green = (CGFloat)piexlData[1] / 255.0;
    CGFloat blue = (CGFloat)piexlData[2] / 255.0;
    CGFloat alpha = (CGFloat)piexlData[3] / 255.0;
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}


/**
 获取当前图片某一个像素点的颜色
 point: 像素点的位置
 */
+ (UIColor *)getPlexColorWithImage:(UIImage *)image point:(CGPoint)point
{
    return [image getPlexColorWithPoint:point];
}

/**
 将当前图片保存到图片库
 */
- (void)saveImage;
{
    UIImageWriteToSavedPhotosAlbum(self, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError*)error contextInfo:(void*)contextInfo
{
    if (error == nil) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"图片保存成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"保存失败" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
    }
}


/**
 将图片保存到图片库
 */
+ (void)saveImageWithImage:(UIImage *)image
{
    [image saveImage];
}

@end
