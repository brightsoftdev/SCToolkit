//
//  NSData+SCAdditions.h
//  SCToolkit
//
//  Created by Vincent Wang on 11/29/11.
//  Copyright (c) 2011 Vincent S. Wang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (SCAdditions)

- (NSData *)sc_MD5;
- (NSData *)sc_SHA1;

@end
