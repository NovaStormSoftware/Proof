//
//  PreferenceController.h
//  Proof
//
//  Created by Justin Mrkva on 10/27/09.
//  Copyright 2009 2009 NovaStorm Software. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface PreferenceController : NSObject {
	NSUserDefaults *ud;
}

@property(readwrite, assign) NSString *workingDirectory;
@property(readwrite, assign) NSString *savingDirectory;

@end
