//
//  NSSWebViewController.h
//  Proof
//
//  Created by Justin Mrkva on 11/2/09.
//  Copyright 2009 2009 NovaStorm Software. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "NSSProofViewController.h"
#import <WebKit/WebKit.h>


@interface NSSWebViewController : NSSProofViewController {
	IBOutlet WebView *webView;
	//IBOutlet NSTextField *textField;
	NSString *file;
	NSString *lastUTI;
}

- (IBAction)refresh:(id)sender;

@end
