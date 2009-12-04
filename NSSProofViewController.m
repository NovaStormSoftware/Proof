//
//  ProofViewControllerSuperclass.m
//  Proof
//
//  Created by Justin Mrkva on 10/27/09.
//  Copyright 2009 2009 NovaStorm Software. All rights reserved.
//

#import "NSSProofViewController.h"

@implementation NSSProofViewController

@synthesize outletView;

- (void)displayInView:(NSView *)view {
	NSArray *subs = [view subviews];
	for (NSView *v in subs) {
		[v removeFromSuperview];
	}
	[outletView setFrame:[view bounds]];
	[view addSubview:outletView];
}

- (NSArray *)viewableTypes {
	return [NSArray arrayWithObjects: nil];
}

- (BOOL)canDisplayType:(NSString *)fileUTI {
	for (NSString *str in [self viewableTypes]) {
		if (UTTypeConformsTo(fileUTI, str)) {
			return YES;
		}
		NSLog(@"%@ does NOT conform to %@", fileUTI, str);
	}
	return NO;
}

@end
