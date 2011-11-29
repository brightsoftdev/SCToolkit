//
//  NSView+SCAdditions.h
//  SCToolkit
//
//  Created by Vincent Wang on 11/29/11.
//  Copyright (c) 2011 Vincent S. Wang. All rights reserved.
//

#import <AppKit/AppKit.h>

@interface NSView (SCAdditions)

- (void)sc_setAlignmentCenterInView:(NSView *)aView;
- (void)sc_setAlignmentCenterInRect:(NSRect)rect;

@end
