//
//  TestStringFromTimeInterval.m
//  SCToolkit
//
//  Created by Vincent Wang on 11/29/11.
//  Copyright (c) 2011 Vincent S. Wang. All rights reserved.
//

#import "TestStringFromTimeInterval.h"
#import "NSString+SCAdditions.h"

@implementation TestStringFromTimeInterval

//// All code under test must be linked into the Unit Test bundle
//- (void)testMath
//{
//    STAssertTrue((1 + 1) == 2, @"Compiler isn't feeling well today :-(");
//}

- (void)testStringFromTimeIntervalWithNegativeValue
{
    NSString *string;
    NSTimeInterval interval;
    interval = -1;
    string = [NSString sc_stringFromTimeInterval:interval];
    STAssertNotNil(string, @"string cannot be negative value", string);
    NSLog(@"seconds....%@", string);
    

    
//    interval = 0.09;
//    string = [NSString sc_stringFromTimeInterval:interval];
//    STAssertNotNil(string, @"string cannot be nil", string);
//    
//    interval = -1;
//    string = [NSString sc_stringFromTimeInterval:interval];
//    STAssertNotNil(string, @"string cannot be nil", string);
}

- (void)testStringFromTimeIntervalFromSubSecond
{
    NSString *string;
    NSTimeInterval interval;
    interval = 0.1;
    string = [NSString sc_stringFromTimeInterval:interval];
    STAssertTrue([string isEqualToString:@"00:00"], @"when a sub second value is passed, string should be zero", string);
    NSLog(@"string...%@", string);
}
@end
