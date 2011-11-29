//
//  NSObject+SCBlocksKit.h
//  SCToolkit
//
//  Created by Vincent Wang on 11/28/11.
//  Copyright (c) 2011 Vincent S. Wang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (SCBlocksKit)

- (void)sc_performBlock:(void (^)(void))block afterDelay:(NSTimeInterval)delay;

@end
