//
//  NSSWebViewController.m
//  Proof
//
//  Created by Justin Mrkva on 11/2/09.
//  Copyright 2009 2009 NovaStorm Software. All rights reserved.
//

#import "NSSWebViewController.h"

@implementation NSSWebViewController

- (void)loadFileAtLocation:(NSString *)filename {
	file = filename;
	[self refresh:nil];
}

- (NSArray *)viewableTypes {
	return [NSArray arrayWithObjects:(NSString *)kUTTypeWebArchive, (NSString *)kUTTypeHTML, nil];
}

- (IBAction)refresh:(id)sender {
	//[webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:file]]];
	if (UTTypeConformsTo(lastUTI, kUTTypeWebArchive)) {
		[[webView mainFrame] loadArchive:[[WebArchive alloc] initWithData:[NSData dataWithContentsOfFile:file]]];
	} else {
		[[webView mainFrame] loadData:[NSData dataWithContentsOfFile:file] MIMEType:nil textEncodingName:nil baseURL:nil];
		 NSLog(@"Attempted to load %@ into web view.", file);
	}
}
		
- (BOOL)canDisplayType:(NSString *)fileUTI {
	lastUTI = fileUTI;
	return [super canDisplayType:fileUTI];
}

@end
