//
//  TestTimerPauseAndResume.m
//  SCToolkit
//
//  Created by Vincent Wang on 11/29/11.
//  Copyright (c) 2011 Vincent S. Wang. All rights reserved.
//

#import "TestTimerPauseAndResume.h"
#import "NSTimer+Pausing.h"
@implementation TestTimerPauseAndResume

- (void)testPauseAndResume
{
    [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(scheduledSelector:) userInfo:nil repeats:YES];
}

- (void)scheduledSelector:(NSTimer *)timer
{
    NSLog(@"Test");
    [timer sc_pause];
}

@end
