//
//  NSTimer+Pausing.h
//  SCToolkit
//
//  Created by Vincent Wang on 11/28/11.
//  Copyright (c) 2011 Vincent S. Wang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer (SCPausing)

/**
 Add pause capability to NSTimer
 @param 
 @returns 
 @exception 
 */

- (void)sc_pause;

/**
 As there is pausing available, resuming is a must
 @param 
 @returns 
 @exception 
 */

- (void)sc_resume;

@end
