//
//  NSData+SCAdditions.m
//  SCToolkit
//
//  Created by Vincent Wang on 11/29/11.
//  Copyright (c) 2011 Vincent S. Wang. All rights reserved.
//

#import "NSData+SCAdditions.h"
// link libcrypto.lib
#import <openssl/bio.h>
#import <openssl/evp.h>
#import <openssl/md5.h>
#import <openssl/sha.h>

@implementation NSData (SCAdditions)

- (NSData *)sc_MD5 
{
	int length = 16;
	unsigned char digest[length];
	MD5([self bytes], [self length], digest);
	return [NSData dataWithBytes:&digest length:length];
}

- (NSData *)sc_SHA1 
{
	int length = 20;
	unsigned char digest[length];
	SHA1([self bytes], [self length], digest);
	return [NSData dataWithBytes:&digest length:length];
}

@end
