//
//  SCSelectionBorder.m
//  SCToolkit
//
//  Created by Vincent Wang on 12/8/11.
//  Copyright (c) 2011 Vincent S. Wang. All rights reserved.
//

#import "SCSelectionBorder.h"

// The handles that graphics draw on themselves are 10 point by 10 point rectangles.
const CGFloat SCSelectionBorderHandleWidth = 10.0f;
const CGFloat SCSelectionBorderHandleHalfWidth = 10.0f / 2.0f;

enum {
    kSCSelectionBorderTrackingNone      = 0,
    kSCSelectionBorderTrackingSelecting = 1,
    kSCSelectionBorderTrackingResizing  = 2,
    kSCSelectionBorderTrackingMoving    = 3,
};

@interface SCSelectionBorder (SCSelectionBorderPrivate)
- (NSBezierPath *)bezierPathForDrawing;
- (BOOL)isDrawingHandles;
- (void)setDrawingHandles:(BOOL)yesOrNo;

@end

@interface SCSelectionBorder ()

- (BOOL)isPoint:(NSPoint)point withinHandle:(SCSelectionBorderHandle)handle frameRect:(NSRect)bounds;
- (BOOL)isPoint:(NSPoint)point withinHandleAtPoint:(NSPoint)handlePoint;
- (void)translateByX:(CGFloat)deltaX y:(CGFloat)deltaY;
- (void)moveSelectionBorderWithEvent:(NSEvent *)theEvent atPoint:(NSPoint)where inView:(NSView *)view;
- (NSInteger)resizeByMovingHandle:(SCSelectionBorderHandle)handle atPoint:(NSPoint)where inView:(NSView *)view;
@end

@implementation SCSelectionBorder

@synthesize borderColor = _borderColor;
@synthesize fillColor = _fillColor;
@synthesize drawingFill = _drawingFill;
@synthesize selectedRect = _selectedRect;
@synthesize lastMouseLocation = _lastMouseLocation;
@synthesize borderWidth = _borderWidth;
@synthesize gridLineNumber = _gridLineNumber;
@synthesize drawingGrids = _drawingGrids;
@synthesize drawingOffView = _drawingOffView;

- (id)init
{
    self = [super init];
    if (self) {
        self.selectedRect = NSZeroRect;
        [self setColors:[NSColor blueColor]];
        self.gridLineNumber = 2;
        self.drawingGrids = YES;
        self.drawingFill = YES;
        [self setDrawingHandles:YES];
        self.drawingOffView = NO;
    }
    
    return self;
}

- (void)dealloc
{
    [_borderColor release], _borderColor = nil;
    [_fillColor release], _fillColor = nil;
    [super dealloc];
}

- (void)setColors:(NSColor *)aColor
{
    self.borderColor = aColor;
    self.fillColor = [self.borderColor colorWithAlphaComponent:0.2]; // Make it have an elegant transparent effect
}

- (void)drawContentInView:(NSView *)aView
{
    NSBezierPath *path = [self bezierPathForDrawing];
    if (path) {
        
        if (self.isDrawingFill) {
            [self.fillColor set];
            [path fill];
        }
        
        [self.borderColor set];
        [path stroke];

        //Stop drawing grids before I solve the coord issue.
//        if (self.isDrawingGrids) {
////            //[NSBezierPath sc_drawGridsInRect:rect lineNumber:self.gridLineNumber];
//            [self drawGridsInRect:self.selectedRect lineNumber:2];
//        }
        
        if ([self isDrawingHandles]) {
            [self drawHandlesInView:aView];
        }
    }
}

- (void)drawHandlesInView:(NSView *)aView
{
    // Draw handles at the corners and on the sides.
    NSRect b = self.selectedRect;
    [self drawHandleInView:aView atPoint:NSMakePoint(NSMinX(b), NSMinY(b))];
    [self drawHandleInView:aView atPoint:NSMakePoint(NSMidX(b), NSMinY(b))];
    [self drawHandleInView:aView atPoint:NSMakePoint(NSMaxX(b), NSMinY(b))];
    [self drawHandleInView:aView atPoint:NSMakePoint(NSMinX(b), NSMidY(b))];
    [self drawHandleInView:aView atPoint:NSMakePoint(NSMaxX(b), NSMidY(b))];
    [self drawHandleInView:aView atPoint:NSMakePoint(NSMinX(b), NSMaxY(b))];
    [self drawHandleInView:aView atPoint:NSMakePoint(NSMidX(b), NSMaxY(b))];
    [self drawHandleInView:aView atPoint:NSMakePoint(NSMaxX(b), NSMaxY(b))];
}

- (void)drawHandleInView:(NSView *)aView atPoint:(NSPoint)aPoint 
{
    
    // Figure out a rectangle that's centered on the point but lined up with device pixels.
    NSRect handleBounds;
    handleBounds.origin.x = aPoint.x - SCSelectionBorderHandleHalfWidth;
    handleBounds.origin.y = aPoint.y - SCSelectionBorderHandleHalfWidth;
    handleBounds.size.width = SCSelectionBorderHandleWidth;
    handleBounds.size.height = SCSelectionBorderHandleWidth;
    handleBounds = [aView centerScanRect:handleBounds];
    
    // Draw the shadow of the handle.
    NSRect handleShadowBounds = NSOffsetRect(handleBounds, 1.0f, 1.0f);
    [[NSColor controlDarkShadowColor] set];
    NSRectFill(handleShadowBounds);
    
    // Draw the handle itself.
    [[NSColor knobColor] set];
    NSRectFill(handleBounds);
    
}

- (void)drawGridsInRect:(NSRect)aRect lineNumber:(unsigned int)num
{
    [[NSColor gridColor] set];
    
    float w = aRect.size.width;
    float h = aRect.size.height;
    float deltaX = NSMinX(aRect);
    float deltaY = NSMinY(aRect);
    
    for (unsigned int i = 1; i <= num; i++) {
        float x = w / (num + 1) * i; // why plus 1 with num? 
        float y = h / (num + 1) * i; // example: when you see two vertical lines drawed on the view, literally, the view is divided into 3 pieces.
        [NSBezierPath strokeLineFromPoint:NSMakePoint(deltaX, y) 
                                  toPoint:NSMakePoint(w - 1, y)];
        [NSBezierPath strokeLineFromPoint:NSMakePoint(x, deltaY) 
                                  toPoint:NSMakePoint(x, h - 1)];
    }
}

//- (void)mouseDown:(NSEvent *)theEvent
//{
    // TODO
    // 1. Determine the mouse location is inside selected rect or not
    // NO: do nothing
    // YES: do selecting and go to #2
    //BOOL result = - (BOOL)mouse:(NSPoint)mousePoint isInFrame:(NSRect)frameRect inView:(NSView *)view handle:(SCSelectionBorderHandle *)outHandle
    
    // 2. Check mouse location is on handle
    // NO: do moving
    // YES: do resizing
//    if (result) {
//        if (handle != none)
//            //resizing
//        else
//            //moving
//    }
//}

/*  Mostly a simple question of if frame contains point, but also return yes if the point is in one of our selection handles
 */

// frameRect the the rect of current selection border in the view
- (BOOL)mouse:(NSPoint)mousePoint isInFrame:(NSRect)frameRect inView:(NSView *)view handle:(SCSelectionBorderHandle *)outHandle
{
    BOOL result;
    result = [view mouse:mousePoint inRect:self.selectedRect];
//    result = NSPointInRect(mousePoint, frameRect);
//    result = NSPointInRect(mousePoint, self.selectedRect);
    
    // Search through the handles
    SCSelectionBorderHandle handle = (SCSelectionBorderHandle)[self handleAtPoint:mousePoint frameRect:frameRect];
    
    if (outHandle) *outHandle = handle;
    
    return result;
}

#pragma mark -
#pragma mark Handle 

- (NSInteger)handleAtPoint:(NSPoint)point frameRect:(NSRect)bounds
{
    // Check handles at the corners and on the sides.
    NSInteger result = kSCSelectionBorderHandleNone;
    if ([self isPoint:point withinHandle:kSCSelectionBorderUpperLeftHandle frameRect:bounds])
    {
        result = kSCSelectionBorderUpperLeftHandle;
    }
    else if ([self isPoint:point withinHandle:kSCSelectionBorderUpperMiddleHandle frameRect:bounds])
    {
        result = kSCSelectionBorderUpperMiddleHandle;
    }
    else if ([self isPoint:point withinHandle:kSCSelectionBorderUpperRightHandle frameRect:bounds])
    {
        result = kSCSelectionBorderUpperRightHandle;
    }
    else if ([self isPoint:point withinHandle:kSCSelectionBorderMiddleLeftHandle frameRect:bounds])
    {
        result = kSCSelectionBorderMiddleLeftHandle;
    }
    else if ([self isPoint:point withinHandle:kSCSelectionBorderMiddleRightHandle frameRect:bounds])
    {
        result = kSCSelectionBorderMiddleRightHandle;
    }
    else if ([self isPoint:point withinHandle:kSCSelectionBorderLowerLeftHandle frameRect:bounds])
    {
        result = kSCSelectionBorderLowerLeftHandle;
    }
    else if ([self isPoint:point withinHandle:kSCSelectionBorderLowerMiddleHandle frameRect:bounds])
    {
        result = kSCSelectionBorderLowerMiddleHandle;
    }
    else if ([self isPoint:point withinHandle:kSCSelectionBorderLowerRightHandle frameRect:bounds])
    {
        result = kSCSelectionBorderLowerRightHandle;
    }
    
    return result;
}

- (BOOL)isPoint:(NSPoint)point withinHandle:(SCSelectionBorderHandle)handle frameRect:(NSRect)bounds;
{
    NSPoint handlePoint = [self locationOfHandle:handle frameRect:bounds];
    BOOL result = [self isPoint:point withinHandleAtPoint:handlePoint];
    return result;
}

- (NSPoint)locationOfHandle:(SCSelectionBorderHandle)handle frameRect:(NSRect)bounds
{
    NSPoint result = NSZeroPoint;
    
    switch (handle)
    {
        case kSCSelectionBorderUpperLeftHandle:
            result = NSMakePoint(NSMinX(bounds), NSMinY(bounds));
            break;
            
        case kSCSelectionBorderUpperMiddleHandle:
            result = NSMakePoint(NSMidX(bounds), NSMinY(bounds));
            break;
            
        case kSCSelectionBorderUpperRightHandle:
            result = NSMakePoint(NSMaxX(bounds), NSMinY(bounds));
            break;
            
        case kSCSelectionBorderMiddleLeftHandle:
            result = NSMakePoint(NSMinX(bounds), NSMidY(bounds));
            break;
            
        case kSCSelectionBorderMiddleRightHandle:
            result = NSMakePoint(NSMaxX(bounds), NSMidY(bounds));
            break;
            
        case kSCSelectionBorderLowerLeftHandle:
            result = NSMakePoint(NSMinX(bounds), NSMaxY(bounds));
            break;
            
        case kSCSelectionBorderLowerMiddleHandle:
            result = NSMakePoint(NSMidX(bounds), NSMaxY(bounds));
            break;
            
        case kSCSelectionBorderLowerRightHandle:
            result = NSMakePoint(NSMaxX(bounds), NSMaxY(bounds));
            break;
        default:
            NSLog(@"Unknown handle");
            break;
    }
    
    return result;
}

- (BOOL)isPoint:(NSPoint)point withinHandleAtPoint:(NSPoint)handlePoint;
{
    // Check a handle-sized rectangle that's centered on the handle point.
    NSRect handleBounds;
    handleBounds.origin.x = handlePoint.x - SCSelectionBorderHandleHalfWidth;
    handleBounds.origin.y = handlePoint.y - SCSelectionBorderHandleHalfWidth;
    handleBounds.size.width = SCSelectionBorderHandleWidth;
    handleBounds.size.height = SCSelectionBorderHandleWidth;
    return NSPointInRect(point, handleBounds);
}

#pragma mark - 
#pragma mark STK ways

//- (BOOL)st_mouse:(NSPoint)mousePoint isInFrame:(NSRect)frameRect inView:(NSView *)view handle:(SCSelectionBorderHandle *)outHandle
//{
//    BOOL result = NO;
//    // Do a quick check to weed out graphics that aren't even in the neighborhood.
//	if (NSPointInRect(mousePoint, self.selectedRect)) result = YES;
//    
//    // Search through the handles
//    SCSelectionBorderHandle handle = (SCSelectionBorderHandle)[self handleAtPoint:mousePoint frameRect:self.selectedRect];
//    if (outHandle) *outHandle = handle;
//
//    return result;
//}
//
//
//- (SCSelectionBorderHandle)st_handleUnderPoint:(NSPoint)point {
//    
//    // Check handles at the corners and on the sides.
//    NSInteger handle = kSCSelectionBorderHandleNone;
//    NSRect bounds = self.selectedRect;
//    if ([self isHandleAtPoint:NSMakePoint(NSMinX(bounds), NSMinY(bounds)) underPoint:point]) {
//        handle = kSCSelectionBorderUpperLeftHandle;
//    } else if ([self isHandleAtPoint:NSMakePoint(NSMidX(bounds), NSMinY(bounds)) underPoint:point]) {
//        handle = SKTGraphicUpperMiddleHandle;
//    } else if ([self isHandleAtPoint:NSMakePoint(NSMaxX(bounds), NSMinY(bounds)) underPoint:point]) {
//        handle = SKTGraphicUpperRightHandle;
//    } else if ([self isHandleAtPoint:NSMakePoint(NSMinX(bounds), NSMidY(bounds)) underPoint:point]) {
//        handle = SKTGraphicMiddleLeftHandle;
//    } else if ([self isHandleAtPoint:NSMakePoint(NSMaxX(bounds), NSMidY(bounds)) underPoint:point]) {
//        handle = SKTGraphicMiddleRightHandle;
//    } else if ([self isHandleAtPoint:NSMakePoint(NSMinX(bounds), NSMaxY(bounds)) underPoint:point]) {
//        handle = SKTGraphicLowerLeftHandle;
//    } else if ([self isHandleAtPoint:NSMakePoint(NSMidX(bounds), NSMaxY(bounds)) underPoint:point]) {
//        handle = SKTGraphicLowerMiddleHandle;
//    } else if ([self isHandleAtPoint:NSMakePoint(NSMaxX(bounds), NSMaxY(bounds)) underPoint:point]) {
//        handle = SKTGraphicLowerRightHandle;
//    }
//    return handle;
//    
//}
//
//
//- (BOOL)isHandleAtPoint:(NSPoint)handlePoint underPoint:(NSPoint)point {
//    
//    // Check a handle-sized rectangle that's centered on the handle point.
//    NSRect handleBounds;
//    handleBounds.origin.x = handlePoint.x - SKTGraphicHandleHalfWidth;
//    handleBounds.origin.y = handlePoint.y - SKTGraphicHandleHalfWidth;
//    handleBounds.size.width = SKTGraphicHandleWidth;
//    handleBounds.size.height = SKTGraphicHandleWidth;
//    return NSPointInRect(point, handleBounds);
//    
//}

#pragma mark - 
#pragma mark Tracking

- (void)selectAndTrackMouseWithEvent:(NSEvent *)theEvent atPoint:(NSPoint)mouseLocation inView:(NSView *)view
{
//    while ([theEvent type] != NSLeftMouseUp) {
//        theEvent = [[view window] nextEventMatchingMask:(NSLeftMouseDraggedMask | NSLeftMouseUpMask)];
//    }
    
    SCSelectionBorderHandle handle;
    BOOL result = [self mouse:mouseLocation isInFrame:self.selectedRect inView:view handle:&handle];
    if (result && handle == kSCSelectionBorderHandleNone) {
        // select + moving
        [self moveSelectionBorderWithEvent:theEvent atPoint:mouseLocation inView:view];
    }
    else if (result && handle != kSCSelectionBorderHandleNone) {
        // select + resizing
        [self resizeByMovingHandle:handle atPoint:mouseLocation inView:view];
    }
    else {
        // do nothing
    }
}

- (void)moveSelectionBorderWithEvent:(NSEvent *)theEvent atPoint:(NSPoint)where inView:(NSView *)view
{
    BOOL isMoving = NO;
//    NSRect selBounds = self.selectedRect;
//    NSPoint selOriginOffset = NSMakePoint(where.x - selBounds.origin.x, where.y - selBounds.origin.y);
    
    while ([theEvent type] != NSLeftMouseUp) {
        theEvent = [[view window] nextEventMatchingMask:(NSLeftMouseDraggedMask | NSLeftMouseUpMask)];
        
        NSPoint currentPoint = [view convertPoint:[theEvent locationInWindow] fromView:nil];
        if (!isMoving && ((fabs(currentPoint.x - where.x) >= 2.0) || (fabs(currentPoint.y - where.y) >= 2.0))) {
            isMoving = YES;
            [self setDrawingHandles:NO];
        }
        
        if (!NSEqualPoints(where, currentPoint)) {
            [self translateByX:(currentPoint.x - where.x) y:(currentPoint.y - where.y)];
            where = currentPoint;
        }
        
        if (isMoving) {
            [self setDrawingHandles:YES];
        }
    }
}

- (void)translateByX:(CGFloat)deltaX y:(CGFloat)deltaY
{
    NSRect rect = self.selectedRect;
    [self setSelectedRect:NSOffsetRect(rect, deltaX, deltaY)];
}

- (NSInteger)resizeByMovingHandle:(SCSelectionBorderHandle)handle atPoint:(NSPoint)where inView:(NSView *)view
{
    NSInteger newHandle = (NSInteger)handle;
    NSRect rect = self.selectedRect;
    NSRect bounds = view.bounds;
    
    // Is the user changing the width of the graphic?
    if (handle == kSCSelectionBorderUpperLeftHandle || handle == kSCSelectionBorderMiddleLeftHandle || handle == kSCSelectionBorderLowerLeftHandle) {
        
        // Don't go off the bounds of view
        if (where.x < 0) where.x = 0;

        
        // Change the left edge of the graphic.
        rect.size.width = NSMaxX(rect) - where.x;
        rect.origin.x = where.x;
        
    }
    else if (handle == kSCSelectionBorderUpperRightHandle || handle == kSCSelectionBorderMiddleRightHandle || handle == kSCSelectionBorderLowerRightHandle) {
        
        // Don't go off the bounds of view
        if (where.x > NSMaxX(bounds)) where.x = NSMaxX(bounds);
        
        // Change the right edge of the graphic.
        rect.size.width = where.x - rect.origin.x;
    }
    
    // Did the user actually flip the selection border over?
    if (rect.size.width < 0.0f) {
        // The handle is now playing a different role relative to the graphic.
        static NSInteger flippings[9];
        static BOOL flippingsInitialized = NO;
        if (!flippingsInitialized) {
            flippings[kSCSelectionBorderUpperLeftHandle] = kSCSelectionBorderUpperRightHandle;
            flippings[kSCSelectionBorderUpperMiddleHandle] = kSCSelectionBorderUpperMiddleHandle;
            flippings[kSCSelectionBorderUpperRightHandle] = kSCSelectionBorderUpperLeftHandle;
            flippings[kSCSelectionBorderMiddleLeftHandle] = kSCSelectionBorderMiddleRightHandle;
            flippings[kSCSelectionBorderMiddleRightHandle] = kSCSelectionBorderMiddleLeftHandle;
            flippings[kSCSelectionBorderLowerLeftHandle] = kSCSelectionBorderLowerRightHandle;
            flippings[kSCSelectionBorderLowerMiddleHandle] = kSCSelectionBorderLowerMiddleHandle;
            flippings[kSCSelectionBorderLowerRightHandle] = kSCSelectionBorderLowerLeftHandle;
            flippingsInitialized = YES;
        }
        
        newHandle = flippings[handle];
        
        // Make the selection border's width positive again.
        rect.size.width = 0.0f - rect.size.width;
        rect.origin.x -= rect.size.width;
        
        // Tell interested subclass/object code what just happened.
        //[self flipHorizontally];
    }
    
    // Is the user changing the height of the graphic?
    if (handle == kSCSelectionBorderUpperLeftHandle || handle == kSCSelectionBorderUpperMiddleHandle || handle == kSCSelectionBorderUpperRightHandle) {
        
        // Don't go off the view bounds
        if (where.y < 0) where.y = 0;
        
        // Change the top edge of the graphic.
        rect.size.height = NSMaxY(rect) - where.y;
        rect.origin.y = where.y;
        
    }
    else if (handle == kSCSelectionBorderLowerLeftHandle || handle == kSCSelectionBorderLowerMiddleHandle || handle == kSCSelectionBorderLowerRightHandle) {
        
        // Don't go off the host view's bounds
        if (where.y > NSMaxY(bounds)) where.y = NSMaxY(bounds);
        
        // Change the bottom edge of the graphic.
        rect.size.height = where.y - rect.origin.y;
    }
    
    
    // Did the user actually flip the selection border upside down?
    if (rect.size.height < 0.0f) {
        
        // The handle is now playing a different role relative to the graphic.
        static NSInteger flippings[9];
        static BOOL flippingsInitialized = NO;
        if (!flippingsInitialized) {
            flippings[kSCSelectionBorderUpperLeftHandle] = kSCSelectionBorderLowerLeftHandle;
            flippings[kSCSelectionBorderUpperMiddleHandle] = kSCSelectionBorderLowerMiddleHandle;
            flippings[kSCSelectionBorderUpperRightHandle] = kSCSelectionBorderLowerRightHandle;
            flippings[kSCSelectionBorderMiddleLeftHandle] = kSCSelectionBorderMiddleLeftHandle;
            flippings[kSCSelectionBorderMiddleRightHandle] = kSCSelectionBorderMiddleRightHandle;
            flippings[kSCSelectionBorderLowerLeftHandle] = kSCSelectionBorderUpperLeftHandle;
            flippings[kSCSelectionBorderLowerMiddleHandle] = kSCSelectionBorderUpperMiddleHandle;
            flippings[kSCSelectionBorderLowerRightHandle] = kSCSelectionBorderUpperRightHandle;
            flippingsInitialized = YES;
        }
        
        newHandle = flippings[handle];
        
        // Make the graphic's height positive again.
        rect.size.height = 0.0f - rect.size.height;
        rect.origin.y -= rect.size.height;
        
        // Tell interested subclass/object code what just happened.
        //[self flipVertically];
    }
    
    // Done
    self.selectedRect = rect;
    
    return newHandle;
}

@end

@implementation SCSelectionBorder (SCSelectionBorderPrivate)

- (NSBezierPath *)bezierPathForDrawing 
{
    NSBezierPath *path = [NSBezierPath bezierPathWithRect:self.selectedRect];
    [path setLineWidth:self.borderWidth];
    return path;
    
}

- (BOOL)isDrawingHandles
{
    return _drawingHandles;
}

- (void)setDrawingHandles:(BOOL)yesOrNo
{
    _drawingHandles = yesOrNo;
}

@end
