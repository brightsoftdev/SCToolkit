//
//  NSFileManager+SCAdditions.h
//  SCToolkit
//
//  Created by Vincent Wang on 11/28/11.
//  Copyright (c) 2011 Vincent S. Wang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSFileManager (SCAdditions)

/** Thread Safe NSFileManager
 This code is form iMedia framework
 @param 
 @returns NSFileManager instance
 @exception 
 */
+ (NSFileManager *)sc_threadSafeManager;

/** Check if a given path is hidden. The given path can be either a file or a folder
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
- (BOOL)sc_createDirectoryPath:(NSString *)path attributes:(NSDictionary *)attributes;

/** Return (creating if necessary) a path to the shared temporary directory. 
 @param dirName Pass @"" to get the default temp dir path. If you pass in a subfolder name, that will be created and appended.
 @returns Return (creating if necessary) a path to the shared temporary directory. 
 @exception 
 */
- (NSString *)sc_sharedTemporaryFolder:(NSString *)dirName;

@end
