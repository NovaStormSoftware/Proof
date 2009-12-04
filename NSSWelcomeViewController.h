//
//  NSSWelcomeViewController.h
//  Proof
//
//  Created by Justin Mrkva on 10/27/09.
//  Copyright 2009 2009 NovaStorm Software. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "NSSProofViewController.h"


@interface NSSWelcomeViewController : NSSProofViewController {
	IBOutlet NSTextView *textView;
}
- (IBAction)openWebsite:(id)sender;
- (IBAction)openDonate:(id)sender;
@end
