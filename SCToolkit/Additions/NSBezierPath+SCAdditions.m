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
    
    for (unsigned int i = 0; i <= num; i++) {
        float x = w / 10 * i;
        float y = h / 10 * i;
        [NSBezierPath strokeLineFromPoint:NSMakePoint(0, y) 
                                  toPoint:NSMakePoint(w - 1, y)];
        [NSBezierPath strokeLineFromPoint:NSMakePoint(x, 0) 
                                  toPoint:NSMakePoint(x, h - 1)];
    }
}
@end
