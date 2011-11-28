//
//  NSString+SCAdditions.h
//  SCToolkit
//
//  Created by Vincent Wang on 11/28/11.
//  Copyright (c) 2011 Vincent S. Wang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (SCAdditions)

/**
 Generate a Unified Unique ID
 @param 
 @returns a UUID NSString object
 @exception 
 */
+ (NSString *)sc_newUUIDString;

@end
