//
//  SCSelectionBorder.h
//  SCToolkit
//
//  Created by Vincent Wang on 12/8/11.
//  Copyright (c) 2011 Vincent S. Wang. All rights reserved.
//

#import <Foundation/Foundation.h>

extern const CGFloat SCSelectionBorderHandleWidth;
extern const CGFloat SCSelectionBorderHandleHalfWidth;

typedef enum {
    kSCSelectionBorderHandleNone        = 0, 
    kSCSelectionBorderUpperLeftHandle   = 1,
    kSCSelectionBorderUpperMiddleHandle = 2,
    kSCSelectionBorderUpperRightHandle  = 3,
    kSCSelectionBorderMiddleLeftHandle  = 4,
    kSCSelectionBorderMiddleRightHandle = 5,
    kSCSelectionBorderLowerLeftHandle   = 6,
    kSCSelectionBorderLowerMiddleHandle = 7,
    kSCSelectionBorderLowerRightHandle  = 8,
} SCSelectionBorderHandle;

enum
{
    kSCSelectionXResizeable     = 1U << 0,
    kSCSelectionYResizeable     = 1U << 1,
    kSCSelectionWidthResizeable = 1U << 2,
    kSCSelectionHeightResizeable= 1U << 3,
};

@interface SCSelectionBorder : NSObject
{
 @private
    
    //unsigned int _resizingMask;
    NSColor *_borderColor;
    NSColor *_fillColor;
    BOOL _drawingFill;
    CGFloat _borderWidth;
    NSRect _selectedRect;
    NSPoint _lastMouseLocation;
    
    BOOL _drawingHandles;
    BOOL _drawingGrids;
    unsigned int _gridLineNumber;

}

@property(retain) NSColor *borderColor;
@property(retain) NSColor *fillColor;
@property(assign, getter = isDrawingFill) BOOL drawingFill;
@property(nonatomic) NSRect selectedRect;
@property(nonatomic) NSPoint lastMouseLocation;
@property(nonatomic) CGFloat borderWidth;
@property(assign) unsigned int gridLineNumber;
@property(assign, getter = isDrawingGrids) BOOL drawingGrids;


- (void)setColors:(NSColor *)aColor;

// Drawing
- (void)drawContentInView:(NSView *)aView;
- (void)drawHandlesInView:(NSView *)aView;
- (void)drawHandleInView:(NSView *)aView atPoint:(NSPoint)aPoint;
- (void)drawGridsInRect:(NSRect)aRect lineNumber:(unsigned int)num;

// Event Handling

/** Mostly a simple question of if frame contains point, but also return yes if the point is in one of our selection handles
 @param 
 @returns 
 @exception 
 */

- (BOOL)mouse:(NSPoint)mousePoint
    isInFrame:(NSRect)frameRect
       inView:(NSView *)view
       handle:(SCSelectionBorderHandle *)outHandle;

- (NSInteger)handleAtPoint:(NSPoint)point frameRect:(NSRect)bounds;
- (NSPoint)locationOfHandle:(SCSelectionBorderHandle)handle frameRect:(NSRect)bounds;

/** // Update the selection and/or move graphics or resize graphics.
 @param theEvent a NSEvent
 @returns 
 @exception 
 */
- (void)selectAndTrackMouseWithEvent:(NSEvent *)theEvent atPoint:(NSPoint)mouseLocation inView:(NSView *)view;

@end
