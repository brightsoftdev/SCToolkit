//
//  NSObject+SCBlocksKit.m
//  SCToolkit
//
//  Created by Vincent Wang on 11/28/11.
//  Copyright (c) 2011 Vincent S. Wang. All rights reserved.
//

#import "NSObject+SCBlocksKit.h"

@implementation NSObject (SCBlocksKit)

//http://forrst.com/posts/Delayed_Blocks_in_Objective_C-0Fn
//http://stackoverflow.com/questions/4139219/how-do-you-trigger-a-block-after-a-delay-like-performselectorwithobjectafterd
- (void)sc_performBlock:(void (^)(void))block afterDelay:(NSTimeInterval)delay
{
//    int64_t delta = (int64_t)(1.0e9 * delay);
    int64_t delta = (int64_t)(NSEC_PER_SEC * delay);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, delta), dispatch_get_main_queue(), block);
}

@end
