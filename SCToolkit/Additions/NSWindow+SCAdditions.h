//
//  NSWindow+SCAdditions.h
//  SCToolkit
//
//  Created by Vincent Wang on 11/29/11.
//  Copyright (c) 2011 Vincent S. Wang. All rights reserved.
//

#import <AppKit/AppKit.h>

@interface NSWindow (SCAdditions)

- (void)sc_resizeToSize:(NSSize)newSize animate:(BOOL)yesOrNo;

@end
