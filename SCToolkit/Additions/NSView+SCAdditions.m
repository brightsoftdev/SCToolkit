//
//  NSView+SCAdditions.m
//  SCToolkit
//
//  Created by Vincent Wang on 11/29/11.
//  Copyright (c) 2011 Vincent S. Wang. All rights reserved.
//

#import "NSView+SCAdditions.h"

@implementation NSView (SCAdditions)

- (void)sc_setAlignmentCenterInView:(NSView *)aView;
{
    NSRect aRect = aView.bounds;
    [self setFrameOrigin:NSMakePoint((NSWidth(aRect) - NSWidth(self.frame)) / 2, (NSHeight(aRect) - NSHeight(self.frame)) / 2)];
    [self setAutoresizingMask:NSViewMinXMargin | NSViewMaxXMargin | NSViewMinYMargin | NSViewMaxYMargin];
}

- (void)sc_setAlignmentCenterInRect:(NSRect)aRect
{
    [self setFrameOrigin:NSMakePoint((NSWidth(aRect) - NSWidth(self.frame)) / 2, (NSHeight(aRect) - NSHeight(self.frame)) / 2)];
    [self setAutoresizingMask:NSViewMinXMargin | NSViewMaxXMargin | NSViewMinYMargin | NSViewMaxYMargin];
}

@end
