//
//  NSSWelcomeViewController.m
//  Proof
//
//  Created by Justin Mrkva on 10/27/09.
//  Copyright 2009 2009 NovaStorm Software. All rights reserved.
//

#import "NSSWelcomeViewController.h"


@implementation NSSWelcomeViewController

- (void)awakeFromNib {
	NSString *fileStr = [[NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"WelcomeDocument" ofType:@"txt"] encoding:NSUTF8StringEncoding error:NULL] retain];
	NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:fileStr];
	[[textView textStorage] setAttributedString:string];
}

- (IBAction)openWebsite:(id)sender {
	[[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:@"http://novastormsoftware.com"]];
}

- (IBAction)openDonate:(id)sender {
	[[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:@"http://novastormsoftware.com/purchase.html"]];
}

@end
