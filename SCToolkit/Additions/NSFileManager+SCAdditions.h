//
//  NSFileManager+SCAdditions.h
//  SCToolkit
//
//  Created by Vincent Wang on 11/28/11.
//  Copyright (c) 2011 Vincent S. Wang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSFileManager (SCAdditions)

/**
 Thread Safe NSFileManager
 @param 
 @returns NSFileManager instance
 @exception 
 @copyright borrowed form iMedia framework
 */
+ (NSFileManager *)sc_threadSafeManager;

/**
 Check if a given path is hidden. The given path can be either a file or a folder
 @param 
 @returns 
 @exception 
 */
- (BOOL)sc_isPathHidden:(NSString *)path;

/**
 Create a directory with the given path. If the upper levels of the path are not exist, this method will create them for you.
 @param 
 @returns 
 @exception 
 */
- (BOOL)sc_createDirectoryRecursively:(NSString *)path error:(NSError **)error;

@end
