//
//  ProofViewControllerSuperclass.h
//  Proof
//
//  Created by Justin Mrkva on 10/27/09.
//  Copyright 2009 2009 NovaStorm Software. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface NSSProofViewController : NSObject {
	IBOutlet NSView *outletView;
}

- (void)loadFileAtLocation:(NSString *)filename;
- (void)displayInView:(NSView *)view;
- (BOOL)canDisplayType:(NSString *)fileUTI;

@property(readwrite, retain) IBOutlet NSView *outletView;
@property(readonly) NSArray *viewableTypes;

@end
