//
//  NSImage+SCAdditions.m
//  SCToolkit
//
//  Created by Vincent Wang on 11/29/11.
//  Copyright (c) 2011 Vincent S. Wang. All rights reserved.
//

#import "NSImage+SCAdditions.h"

@implementation NSImage (SCAdditions)

// converting a CGImageRef to NSImage
+ (NSImage *)sc_imageFromCGImageRef:(CGImageRef)imageRef
{
    NSImage *image = [[NSImage alloc] initWithCGImage:imageRef size:NSZeroSize];
    return [image autorelease];
}

+ (CGImageRef)sc_cgImageRefFromPath:(NSString *)path
{
	NSData *data = [[NSData alloc] initWithContentsOfFile:path];
	if (data) {
		CGImageSourceRef imageSource = CGImageSourceCreateWithData ((CFDataRef)data, NULL);
		CGImageRef imageRef = CGImageSourceCreateImageAtIndex(imageSource, 0, NULL);
		CFRelease(imageSource);
		[data release];
        [NSMakeCollectable(imageRef) autorelease];
		return imageRef;
	}
    
	return NULL;
}

// converting a NSImage to CGImageRef
- (CGImageRef)sc_cgImageRef
{
    NSData * imageData = [self TIFFRepresentation];
    CGImageRef imageRef = NULL;
    
	if(imageData) {
        CGImageSourceRef imageSource = CGImageSourceCreateWithData((CFDataRef)imageData, NULL);
		imageRef = CGImageSourceCreateImageAtIndex(imageSource, 0, NULL);
		CFRelease(imageSource);
    }
    
    [NSMakeCollectable(imageRef) autorelease];
	return imageRef;
}

- (CGFloat)pixelWidth
{
   return [[self bestRepresentationForRect:[self alignmentRect] context:nil hints:nil] pixelsWide];
}

- (CGFloat)pixelHeight
{
    return [[self bestRepresentationForRect:[self alignmentRect] context:nil hints:nil] pixelsHigh];
}

- (NSSize)pixelSize 
{
    
    /**
     * Get the size of the original image in its raw bitmap format.
     * The bestRepresentationForDevice: nil tells the NSImage to just
     * give us the raw image instead of it's wacky DPI-translated version.
     */
    
    NSSize size = NSZeroSize;
    size.width = [[self bestRepresentationForRect:[self alignmentRect] context:nil hints:nil] pixelsWide];
    size.height = [[self bestRepresentationForRect:[self alignmentRect] context:nil hints:nil] pixelsHigh];
    return size;
}




@end
