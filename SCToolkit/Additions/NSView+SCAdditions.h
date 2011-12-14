//
//  NSView+SCAdditions.h
//  SCToolkit
//
//  Created by Vincent Wang on 11/29/11.
//  Copyright (c) 2011 Vincent S. Wang. All rights reserved.
//

#import <AppKit/AppKit.h>


@interface NSView (SCAdditions)

- (void)sc_setCenterAlignmentInView:(NSView *)aView;
- (void)sc_setCenterAlignmentInRect:(NSRect)rect;

// Geometry Extensions
// From TransformedImages Apple online sample
// Also can be found in Polygons sample code by Apple
- (void)sc_centerOriginInBounds;
- (void)sc_centerOriginInFrame;
- (void)sc_centerOriginInRect:(NSRect)aRect;

/**
 @param 
 @returns The result of this, is that "return rect" ends up centered in the view.
 @exception 
 */
- (NSRect)sc_centerRect:(NSRect)aRect onPoint:(NSPoint)aPoint;


/** Convert the mouse-down location into the view coordinates
 @param theEvent NSEvent object passed from mouseDown: mouseUp:
 @returns NSPoint
 @exception 
 */
- (NSPoint)sc_lastMouseDownLocation:(NSEvent *)theEvent;


/** Get the center of a NSView in the form of NSPoint
 @param 
 @returns NSPoint
 @exception 
 */
- (NSPoint)sc_centerPoint;

- (CGFloat)sc_distanceBetweenPoints:(NSPoint)a anotherPoint:(NSPoint)b;


// layout

@end
