//
//  NSBezierPath+SCAdditions.h
//  SCToolkit
//
//  Created by Vincent Wang on 12/7/11.
//  Copyright (c) 2011 Vincent S. Wang. All rights reserved.
//

#import <AppKit/AppKit.h>

@interface NSBezierPath (SCAdditions)

+ (void)sc_drawGridsInRect:(NSRect)aRect verticalLineNumber:(unsigned int)num1 horizontalLineNumber:(unsigned int)num2;
+ (void)sc_drawGridsInRect:(NSRect)aRect lineNumber:(unsigned int)num;                      
@end
