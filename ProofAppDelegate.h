//
//  ProofAppDelegate.h
//  Proof
//
//  Created by Justin Mrkva on 10/25/09.
//  Copyright 2009 2009 NovaStorm Software. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "NSSProofViewController.h"
#import "NSSPDFViewController.h"
#import "NSSTextViewController.h"
#import "NSSWelcomeViewController.h"
#import "NSSErrorViewController.h"
#import "PreferenceController.h"
#import "NSSIncompatibleViewController.h"
#import "NSSLargeFileWarningViewController.h"
#import "NSSWebViewController.h"

@interface ProofAppDelegate : NSObject {
    NSWindow *window;
	IBOutlet NSView *contentArea;
	
	IBOutlet NSTextField *documentLabel;
	
	IBOutlet PreferenceController *prefs;
	
	IBOutlet NSSPDFViewController *PDFController;
	IBOutlet NSSTextViewController *TextController;
	IBOutlet NSSWelcomeViewController *WelcomeController;
	IBOutlet NSSErrorViewController *ErrorController;
	IBOutlet NSSIncompatibleViewController *IncompatibleController;
	IBOutlet NSSLargeFileWarningViewController *LargeFileController;
	IBOutlet NSSWebViewController *WebController;
	
	NSSProofViewController *currentViewController;
	
	NSMutableArray *filenames;
	int currentFile;
	NSString *saveDirectory;
	
	IBOutlet NSPanel *destructiveWarningPanel;
	IBOutlet NSTextView	*destructiveWarningList;
	
	BOOL canGoForward;
	BOOL canGoBack;
}

- (IBAction)chooseFolder:(id)sender; //DONE
- (IBAction)reloadFiles:(id)sender; //DONE
- (IBAction)viewPrevious:(id)sender; //DONE
- (IBAction)viewNext:(id)sender; //DONE
- (IBAction)accept:(id)sender; 

- (IBAction)cancelMovingFiles:(id)sender;
- (IBAction)moveFilesDestructively:(id)sender;

@property (assign) IBOutlet NSWindow *window; //DONE
@property (readwrite, assign) BOOL canGoBack; //DONE
@property (readwrite, assign) BOOL canGoForward; //DONE

@end
