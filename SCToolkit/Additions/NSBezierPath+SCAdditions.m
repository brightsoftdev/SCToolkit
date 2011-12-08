//
//  NSBezierPath+SCAdditions.m
//  SCToolkit
//
//  Created by Vincent Wang on 12/7/11.
//  Copyright (c) 2011 Vincent S. Wang. All rights reserved.
//

#import "NSBezierPath+SCAdditions.h"

@implementation NSBezierPath (SCAdditions)

+ (void)sc_drawGridsInRect:(NSRect)aRect verticalLineNumber:(unsigned int)num1 horizontalLineNumber:(unsigned int)num2
{
    float w = aRect.size.width;
    float h = aRect.size.height;
    
    for (int i = 0; i <= 10; i++) {
        float x = w / 10 * i;
        float y = h / 10 * i;
        [NSBezierPath strokeLineFromPoint:NSMakePoint(0, y) 
                                  toPoint:NSMakePoint(w - 1, y)];
        [NSBezierPath strokeLineFromPoint:NSMakePoint(x, 0) 
                                  toPoint:NSMakePoint(x, h - 1)];
    }
}


+ (void)sc_drawGridsInRect:(NSRect)aRect lineNumber:(unsigned int)num
{
    float w = aRect.size.width;
    float h = aRect.size.height;
    
    for (unsigned int i = 1; i <= num; i++) {
        float x = w / num * i;
        float y = h / num * i;
        [NSBezierPath strokeLineFromPoint:NSMakePoint(0, y) 
                                  toPoint:NSMakePoint(w - 1, y)];
        [NSBezierPath strokeLineFromPoint:NSMakePoint(x, 0) 
                                  toPoint:NSMakePoint(x, h - 1)];
    }
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
