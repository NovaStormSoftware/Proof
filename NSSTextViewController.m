//
//  TextViewController.m
//  Proof
//
//  Created by Justin Mrkva on 10/27/09.
//  Copyright 2009 2009 NovaStorm Software. All rights reserved.
//

#import "NSSTextViewController.h"


@implementation NSSTextViewController

- (void)loadFileAtLocation:(NSString *)filename {
	//NSString *fileStr = [[NSString stringWithContentsOfFile:[ encoding:NSUTF8StringEncoding error:NULL] retain];
	//NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:fileStr];
	//[[textView textStorage] setAttributedString:string];
	[[textView textStorage] setAttributedString:[[NSAttributedString alloc] initWithString:@""]];
	[textView readRTFDFromFile:filename];
}

- (NSArray *)viewableTypes {
	return [NSArray arrayWithObjects:(NSString *)kUTTypeText, @"com.microsoft.word.doc", nil];
}

@end
