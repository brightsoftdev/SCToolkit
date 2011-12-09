//
//  NSBezierPath+SCAdditions.h
//  SCToolkit
//
//  Created by Vincent Wang on 12/7/11.
//  Copyright (c) 2011 Vincent S. Wang. All rights reserved.
//

#import <AppKit/AppKit.h>

@interface NSBezierPath (SCAdditions)

+ (void)sc_drawGridsInRect:(NSRect)aRect lineNumber:(unsigned int)num gridColor:(NSColor *)aColor;
+ (void)sc_drawGridsInRect:(NSRect)aRect lineNumber:(unsigned int)num;      
- (void)sc_drawGridsWithPatternsInRect:(NSRect)aRect lineNumber:(unsigned int)num;
// From Polygons sample code by Apple
+ (NSBezierPath *)sc_polygonWithSides:(unsigned int)sides;
+ (NSBezierPath *)sc_meshedPolygonWithSides:(unsigned int)sides;
- (void)sc_strokeAtPoint:(NSPoint)where inView:(NSView *)aView;
- (void)sc_fillAtPoint:(NSPoint)where inView:(NSView *)aView;

@end
