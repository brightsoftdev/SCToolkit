//
//  NSBezierPath+SCAdditions.m
//  SCToolkit
//
//  Created by Vincent Wang on 12/7/11.
//  Copyright (c) 2011 Vincent S. Wang. All rights reserved.
//

#import "NSBezierPath+SCAdditions.h"

@implementation NSBezierPath (SCAdditions)

+ (void)sc_drawGridsInRect:(NSRect)aRect lineNumber:(unsigned int)num gridColor:(NSColor *)aColor;
{
    [aColor set];
    
    float w = aRect.size.width;
    float h = aRect.size.height;
    
    for (unsigned int i = 1; i <= num; i++) {
        float x = w / (num + 1) * i; // why plus 1 with num? 
        float y = h / (num + 1) * i; // example: when you see two vertical lines drawed on the view, literally, the view is divided into 3 pieces.
        [NSBezierPath strokeLineFromPoint:NSMakePoint(0, y) 
                                  toPoint:NSMakePoint(w - 1, y)];
        [NSBezierPath strokeLineFromPoint:NSMakePoint(x, 0) 
                                  toPoint:NSMakePoint(x, h - 1)];
    }
}


+ (void)sc_drawGridsInRect:(NSRect)aRect lineNumber:(unsigned int)num
{
    [[NSColor gridColor] set];
    
    float w = aRect.size.width;
    float h = aRect.size.height;
    
    for (unsigned int i = 1; i <= num; i++) {
        float x = w / (num + 1) * i; // why plus 1 with num? 
        float y = h / (num + 1) * i; // example: when you see two vertical lines drawed on the view, literally, the view is divided into 3 pieces.
        [NSBezierPath strokeLineFromPoint:NSMakePoint(0, y) 
                                  toPoint:NSMakePoint(w - 1, y)];
        [NSBezierPath strokeLineFromPoint:NSMakePoint(x, 0) 
                                  toPoint:NSMakePoint(x, h - 1)];
    }
}

// causing crash....
- (void)sc_drawGridsWithPatternsInRect:(NSRect)aRect lineNumber:(unsigned int)num
{
    // Set the line dash pattern.
    CGFloat lineDash[6];
    
    lineDash[0] = 40.0;
    lineDash[1] = 12.0;
    lineDash[2] = 8.0;
    lineDash[3] = 12.0;
    lineDash[4] = 8.0;
    lineDash[5] = 12.0;
    [self setLineDash:lineDash count:6 phase:0.0];
    
    [[NSColor gridColor] set];
    float w = aRect.size.width;
    float h = aRect.size.height;
    
    for (unsigned int i = 1; i <= num; i++) {
        float x = w / (num + 1) * i; // why plus 1 with num? 
        float y = h / (num + 1) * i; // example: when you see two vertical lines drawed on the view, literally, the view is divided into 3 pieces.
        [self moveToPoint:NSMakePoint(0, y)];  
        [self lineToPoint:NSMakePoint(w - 1, y)];
        [self moveToPoint:NSMakePoint(x, 0)];  
        [self lineToPoint:NSMakePoint(x, h - 1)];
    }
    
    [self stroke];
}

// Returns a regular polygon, inscribed in the unit circle with the given number of sides.
+ (NSBezierPath *)sc_polygonWithSides:(unsigned int)sides
{
    if (sides > 0) { // Sanity check.  Must have at least one side.. 
        float theta = M_PI * 2;  //This makes a full circle in radians.  See Math.h for the defintion of M_PI
        float sliceAngle = theta / sides;
        int index = sides;
        NSBezierPath *path = [self bezierPath];
        
        [path moveToPoint:NSMakePoint(1.0, 0)];  // start at a point on the circle..
        
        while (--index) {  // count down
            theta -= sliceAngle;
            [path lineToPoint:NSMakePoint(cos(theta), sin(theta))];
        }
        [path closePath];  // This gets you a proper linejoin for the last segment.
        return path;
    }
    
    return nil;
}

+ (NSBezierPath *)sc_meshedPolygonWithSides:(unsigned int)sides
{
    if (sides > 0) { // Sanity check.  Must have at least one side..
        int index = sides;
        float theta = M_PI * 2;  //This makes a full circle in radians.  See Math.h for the defintion of M_PI
        float sliceAngle = theta / sides;
        
        NSPoint *perimeterPoints;
        NSBezierPath *path = [self bezierPath];
        
        perimeterPoints = alloca(sides * sizeof(NSPoint));  
        
        while (index--) {
            theta -= sliceAngle;
            perimeterPoints[index] = NSMakePoint(cos(theta), sin(theta));
        }
        
        index = sides;
        while (index--) {
            int subIndex = index;
            while (subIndex--) {
                [path moveToPoint:perimeterPoints[index]];
                [path lineToPoint:perimeterPoints[subIndex]];
            }
        }
        return path;
    }
    
    return nil;
}

// translates the origin of aView's coordinate system to the given point, strokes the reciever, and restores the origin
- (void)sc_strokeAtPoint:(NSPoint)where inView:(NSView *)aView
{
    NSPoint stashOrigin = [aView bounds].origin;
    [aView translateOriginToPoint:where];
    [self stroke];
    [aView setBoundsOrigin:stashOrigin];
}

- (void)sc_fillAtPoint:(NSPoint)where inView:(NSView *)aView
{
    NSPoint stashOrigin = [aView bounds].origin;
    [aView translateOriginToPoint:where];
    [self fill];
    [aView setBoundsOrigin:stashOrigin];
}

@end
