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


- (id)init
{
    self = [super init];
    if (self) {
        self.gridLineNumber = 2;
        self.drawingGrids = YES;
        self.drawingFill = YES;
    }
    
    return self;
}


@end

@implementation SCSelectionBorder (SCSelectionBorderPrivate)

- (NSBezierPath *)bezierPathForDrawing 
{
    NSBezierPath *path = [NSBezierPath bezierPathWithRect:self.selectedRect];
    [path setLineWidth:self.borderWidth];
    return path;
    
}

@end
