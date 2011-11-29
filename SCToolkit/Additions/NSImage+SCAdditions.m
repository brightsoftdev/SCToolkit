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

- (NSImage *)sc_resizeImage:(NSSize)newSize
{
    return nil;
}

// Rotate an image 90 degrees clockwise or counterclockwise
// Code from http://swik.net/User:marc/Chipmunk+Ninja+Technical+Articles/Rotating+an+NSImage+object+in+Cocoa/zgha

- (NSImage *)sc_rotateImage90DegreesClockwise:(BOOL)clockwise
{
    NSSize existingSize;
    
    /**
     * Get the size of the original image in its raw bitmap format.
     * The bestRepresentationForDevice: nil tells the NSImage to just
     * give us the raw image instead of it's wacky DPI-translated version.
     */
    existingSize.width = [[self bestRepresentationForRect:[self alignmentRect] context:nil hints:nil] pixelsWide];
    existingSize.height = [[self bestRepresentationForRect:[self alignmentRect] context:nil hints:nil] pixelsHigh];
    
    NSSize newSize = NSMakeSize(existingSize.height, existingSize.width);
    NSImage *rotatedImage = [[[NSImage alloc] initWithSize:newSize] autorelease];
    
    [rotatedImage lockFocus];
    
    /**
     * Apply the following transformations:
     *
     * - bring the rotation point to the centre of the image instead of
     *   the default lower, left corner (0,0).
     * - rotate it by 90 degrees, either clock or counter clockwise.
     * - re-translate the rotated image back down to the lower left corner
     *   so that it appears in the right place.
     */
    NSAffineTransform *rotateTF = [NSAffineTransform transform];
    NSPoint centerPoint = NSMakePoint(newSize.width / 2, newSize.height / 2);
    
    [rotateTF translateXBy: centerPoint.x yBy: centerPoint.y];
    [rotateTF rotateByDegrees: (clockwise) ? - 90 : 90];
    [rotateTF translateXBy: -centerPoint.y yBy: -centerPoint.x];
    [rotateTF concat];
    
    /**
     * We have to get the image representation to do its drawing directly,
     * because otherwise the stupid NSImage DPI thingie bites us in the butt
     * again.
     */
    NSRect r1 = NSMakeRect(0, 0, newSize.height, newSize.width);
    //[[self bestRepresentationForDevice:nil] drawInRect:r1];
    [[self bestRepresentationForRect:[self alignmentRect] context:nil hints:nil] drawInRect:r1];
    
    [rotatedImage unlockFocus];
    
    return rotatedImage;
}

- (CGFloat)sc_pixelWidth
{
   return [[self bestRepresentationForRect:[self alignmentRect] context:nil hints:nil] pixelsWide];
}

- (CGFloat)sc_pixelHeight
{
    return [[self bestRepresentationForRect:[self alignmentRect] context:nil hints:nil] pixelsHigh];
}

- (NSSize)sc_pixelSize 
{
    
    /**
     * Get the size of the original image in its raw bitmap format.
     * The bestRepresentationForDevice: nil tells the NSImage to just
     * give us the raw image instead of it's wacky DPI-translated version.
     */
    
    NSSize size = NSZeroSize;
    NSImageRep *rep = [self bestRepresentationForRect:[self alignmentRect] context:nil hints:nil];
    size.width = [rep pixelsWide];
    size.height = [rep pixelsHigh];
    return size;
}


@end
