//
//  NSImage+SCAdditions.h
//  SCToolkit
//
//  Created by Vincent Wang on 11/29/11.
//  Copyright (c) 2011 Vincent S. Wang. All rights reserved.
//

#import <AppKit/AppKit.h>

@interface NSImage (SCAdditions)

// converting a CGImageRef to NSImage
+ (NSImage *)sc_imageFromCGImageRef:(CGImageRef)imageRef;

+ (CGImageRef)sc_cgImageRefFromPath:(NSString *)path;

// converting a NSImage to CGImageRef
- (CGImageRef)sc_cgImageRef;


- (NSImage *)sc_resizeImage:(NSSize)newSize;

- (CGFloat)pixelWidth;
- (CGFloat)pixelHeight;
- (NSSize)pixelSize;

@end
