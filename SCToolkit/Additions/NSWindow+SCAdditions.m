//
//  NSWindow+SCAdditions.m
//  SCToolkit
//
//  Created by Vincent Wang on 11/29/11.
//  Copyright (c) 2011 Vincent S. Wang. All rights reserved.
//

#import "NSWindow+SCAdditions.h"

@implementation NSWindow (SCAdditions)

- (void)sc_resizeToSize:(NSSize)newSize animate:(BOOL)yesOrNo
{
	NSRect windowFrame;
	windowFrame.origin.x = [self frame].origin.x;
    
	if ([self isSheet])
	{
		float oldWidth = [self frame].size.width;
		float newWidth = newSize.width;
        
		float difference = oldWidth - newWidth;
        
		windowFrame.origin.x += difference / 2;
	}
    
	windowFrame.origin.y = [self frame].origin.y + [self frame].size.height - newSize.height;
	windowFrame.size.width = newSize.width;
	windowFrame.size.height = newSize.height;
    
	if (!NSIsEmptyRect(windowFrame))
		[self setFrame:windowFrame display:YES animate:yesOrNo];
}


@end
