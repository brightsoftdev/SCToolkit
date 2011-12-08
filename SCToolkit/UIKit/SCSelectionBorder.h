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
    kSCSelectionBorderNoHandle, 
    kSCSelectionBorderUpperLeftHandle,
    kSCSelectionBorderUpperMiddleHandle,
    kSCSelectionBorderUpperRightHandle,
    kSCSelectionBorderMiddleLeftHandle,
    kSCSelectionBorderMiddleRightHandle,
    kSCSelectionBorderLowerLeftHandle,
    kSCSelectionBorderLowerMiddleHandle,
    kSCSelectionBorderLowerRightHandle,
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
    
    unsigned int _resizingMask;
    NSColor *_borderColor;
    NSColor *_fillColor;
    BOOL _drawingFill;
    CGFloat _borderWidth;
    NSRect _selectedRect;
    NSPoint _lastMouseLocation;
    
    BOOL _drawingGrids;
    unsigned int _gridLineNumber;

}

@property(copy) NSColor *borderColor;
@property(copy) NSColor *fillColor;
@property(assign, getter = isDrawingFill) BOOL drawingFill;
@property(assign) NSRect selectedRect;
@property(assign) NSPoint lastMouseLocation;
@property(assign) CGFloat borderWidth;
@property(assign) unsigned int gridLineNumber;
@property(assign, getter = isDrawingGrids) BOOL drawingGrids;

@end
