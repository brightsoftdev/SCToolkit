//
//  NSView+SCAdditions.m
//  SCToolkit
//
//  Created by Vincent Wang on 11/29/11.
//  Copyright (c) 2011 Vincent S. Wang. All rights reserved.
//

#import "NSView+SCAdditions.h"

//Static function are used to avoid the access of the function from the other module.
//By default normal functions can access by any module from the file; to avoid we can use static key word to the function.
//Also if you have more than one; same functions name across file and if they were in static we will not get any errors.
// So...if you are sure this will be a global function, just make it global instead of making it static....
//http://drdobbs.com/184401540
//http://stackoverflow.com/questions/3514413/objective-c-inline-function-symbol-not-found
//http://www.mulle-kybernetik.com/artikel/Optimization/opti-3.html
static inline float sc_distanceBetweenTwoPoints(NSPoint a, NSPoint b);

@implementation NSView (SCAdditions)

- (void)sc_setAlignmentCenterInView:(NSView *)aView;
{
    NSRect aRect = aView.bounds;
    [self setFrameOrigin:NSMakePoint((NSWidth(aRect) - NSWidth(self.frame)) / 2, (NSHeight(aRect) - NSHeight(self.frame)) / 2)];
    [self setAutoresizingMask:NSViewMinXMargin | NSViewMaxXMargin | NSViewMinYMargin | NSViewMaxYMargin];
}

- (void)sc_setAlignmentCenterInRect:(NSRect)aRect
{
    [self setFrameOrigin:NSMakePoint((NSWidth(aRect) - NSWidth(self.frame)) / 2, (NSHeight(aRect) - NSHeight(self.frame)) / 2)];
    [self setAutoresizingMask:NSViewMinXMargin | NSViewMaxXMargin | NSViewMinYMargin | NSViewMaxYMargin];
}

- (void)sc_centerOriginInBounds
{
    [self sc_centerOriginInRect:self.bounds];
}

- (void)sc_centerOriginInFrame
{
    [self sc_centerOriginInRect:[self convertRect:self.frame fromView:self.superview]];
}

- (void)sc_centerOriginInRect:(NSRect)aRect
{
    [self translateOriginToPoint:NSMakePoint(NSMidX(aRect), NSMidY(aRect))];
}

- (NSRect)sc_centerRect:(NSRect)aRect onPoint:(NSPoint)aPoint
{
    CGFloat height = NSHeight(aRect);
    CGFloat width = NSWidth(aRect);
    
    return NSMakeRect(aPoint.x - (width / 2.0), aPoint.y - (height / 2.0), width, height);
}

- (NSPoint)sc_lastMouseDownLocation:(NSEvent *)theEvent
{
    return [self convertPoint:[theEvent locationInWindow] fromView:nil];
}

- (NSPoint)sc_distanceBetweenPoints:(NSPoint):a anotherPoint(NSPoint):b
{
    return sc_distanceBetweenTwoPoints(a, b);
}

@end

static inline float sc_distanceBetweenTwoPoints(NSPoint a, NSPoint b)
{
    float x = a.x - b.x;
    float y = a.y - b.y;
    return sqrtf(x * x + y * y);
}
