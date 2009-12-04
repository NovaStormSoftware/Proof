//
//  ProofAppDelegate.m
//  Proof
//
//  Created by Justin Mrkva on 10/25/09.
//  Copyright 2009 2009 NovaStorm Software. All rights reserved.
//

#import "ProofAppDelegate.h"

@implementation ProofAppDelegate

@synthesize window;
@synthesize canGoBack;
@synthesize canGoForward;

- (id)init {
	[super init];
	filenames = [[NSMutableArray alloc] init];
	currentFile = 0;
	return self;
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
	[self reloadFiles:nil];
}


#pragma mark Controls

- (IBAction)chooseFolder:(id)sender {
	NSOpenPanel *panel = [NSOpenPanel openPanel];
	[panel setCanChooseFiles:NO];
	[panel setCanChooseDirectories:YES];
	[panel setAllowsMultipleSelection:NO];
	[panel setMessage:@"Select a folder that contains your files to proof."];
	[panel beginSheetForDirectory:nil file:nil modalForWindow:window modalDelegate:self didEndSelector:@selector(chooseFolderDidEnd:returnCode:contextInfo:) contextInfo:nil];
}

- (void)chooseFolderDidEnd:(NSOpenPanel *)panel returnCode:(int)returnCode  contextInfo:(void  *)contextInfo {
	NSLog(@"%@", [panel filename]);
	if (returnCode == NSOKButton) {
		[prefs setWorkingDirectory:[panel filename]];
		[self reloadFiles:nil];
	}
}

- (IBAction)reloadFiles:(id)sender {
	NSFileManager *manager = [NSFileManager defaultManager];
	NSError *error;
	if ([[prefs workingDirectory] length] > 0) {
		filenames = [[manager contentsOfDirectoryAtPath:[prefs workingDirectory] error:&error] mutableCopy];
	}
	for (int x = 0; x < [filenames count]; x++) {
		if ([[filenames objectAtIndex:x] isEqualToString:@".DS_Store"]) {
			[filenames removeObjectAtIndex:x];
			break;
		}
	}
	//if (filenames != nil && [filenames count] > 0) {
		currentFile = 0;
		[self loadDocument];
	//}
}

- (IBAction)viewPrevious:(id)sender {
	currentFile--;
	[self loadDocument];
}

- (IBAction)viewNext:(id)sender {
	currentFile++;
	[self loadDocument];
}

- (IBAction)accept:(id)sender {
	NSOpenPanel *panel = [NSOpenPanel openPanel];
	[panel setCanChooseFiles:NO];
	[panel setCanChooseDirectories:YES];
	[panel setAllowsMultipleSelection:NO];
	[panel setMessage:@"Choose a folder to save your proofed files to."];
	[panel beginSheetForDirectory:nil file:nil modalForWindow:window modalDelegate:self didEndSelector:@selector(acceptFolderDidEnd:returnCode:contextInfo:) contextInfo:nil];
}

- (void)acceptFolderDidEnd:(NSOpenPanel *)panel returnCode:(int)returnCode  contextInfo:(void  *)contextInfo {
	NSLog(@"%@", [panel filename]);
	if (returnCode == NSOKButton) {
		[prefs setSavingDirectory:[panel filename]];
		NSFileManager *fm = [NSFileManager defaultManager];
		BOOL hasDestructiveCapability = NO;
		[[destructiveWarningList textStorage] setAttributedString:[[NSAttributedString alloc] initWithString:@""]];
		for (NSString *file in filenames) {
			NSLog(@"Testing %@", file);
			if ([fm fileExistsAtPath:[[prefs savingDirectory] stringByAppendingPathComponent:file]]) {
				[[destructiveWarningList textStorage] appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@\n", file]]];
				hasDestructiveCapability = YES;
			}
		}
		if (hasDestructiveCapability) {
			//[destructiveWarningPanel makeKeyAndOrderFront:nil];
			[window makeKeyAndOrderFront:nil];
			//[NSApp beginSheet:destructiveWarningPanel modalForWindow:panel modalDelegate:nil didEndSelector:nil contextInfo:nil];
			[NSApp runModalForWindow:destructiveWarningPanel];
			return;
		}
		for (NSString *file in filenames) {
			if ([fm fileExistsAtPath:[[prefs workingDirectory] stringByAppendingPathComponent:file]]) {
				NSError *err;
				[fm moveItemAtPath:[[prefs workingDirectory] stringByAppendingPathComponent:file] toPath:[[prefs savingDirectory] stringByAppendingPathComponent:file] error:&err];
				//NSLog(@"Moving Error: %@", err);
			}
		}
		[self reloadFiles:nil];
	}
}

- (IBAction)cancelMovingFiles:(id)sender {
	[destructiveWarningPanel orderOut:nil];
	//[NSApp endSheet:destructiveWarningPanel];
	[NSApp stopModal];
	[window makeKeyAndOrderFront:nil];
}
				 
- (IBAction)moveFilesDestructively:(id)sender {
	[destructiveWarningPanel orderOut:nil];
	//[NSApp endSheet:destructiveWarningPanel];
	[NSApp stopModal];
	[window makeKeyAndOrderFront:nil];
	if ([[prefs workingDirectory] isEqualToString:[prefs savingDirectory]]) {
		NSRunAlertPanel(@"Warning", @"You can't move these files to the same folder.\nThe files have not been moved.", @"OK", nil, nil);
		return;
	}
	NSFileManager *fm = [NSFileManager defaultManager];
	for (NSString *file in filenames) {
		NSLog(@"Moving file at %@ to %@ with overwrite", [[prefs workingDirectory] stringByAppendingPathComponent:file], [[prefs savingDirectory] stringByAppendingPathComponent:file]);
		if ([fm fileExistsAtPath:[[prefs workingDirectory] stringByAppendingPathComponent:file]]) {
			if ([fm fileExistsAtPath:[[prefs savingDirectory] stringByAppendingPathComponent:file]]) {
				NSError *err;
				[fm removeItemAtPath:[[prefs savingDirectory] stringByAppendingPathComponent:file] error:&err];
				//NSLog(@"Deleting Error: %@", err);
			}
			NSError *err;
			[fm moveItemAtPath:[[prefs workingDirectory] stringByAppendingPathComponent:file] toPath:[[prefs savingDirectory] stringByAppendingPathComponent:file] error:&err];
			//NSLog(@"Moving Error: %@", err);
		}
	}
	[self reloadFiles:nil];
}

#pragma mark Document List

- (void)loadDocument {
	NSLog(@"Loading Document...");
	if (filenames == nil) {
		NSLog(@"Error: No Filenames Database");
		return;
	}
	if (currentFile >= [filenames count]) {
		currentFile = [filenames count] - 1;
	}
	if (currentFile < 0) {
		currentFile = -1;
		NSLog(@"Displaying Welcome...");
		[WelcomeController displayInView:contentArea];
		//[ErrorController displayInView:contentArea];
		[self setCanGoBack:NO];
		[self setCanGoForward:NO];
		[documentLabel setStringValue:@""];
	} else {
		if (currentFile == 0) {
			[self setCanGoBack:NO];
		} else {
			[self setCanGoBack:YES];
		}
		
		if (currentFile == [filenames count] - 1) {
			[self setCanGoForward:NO];
		} else {
			[self setCanGoForward:YES];
		}
		
		NSLog(@"Performing Display...");
		[self performLoadIntoViewer];
	}
}

- (void)performLoadIntoViewer {
	NSString *filePath = [[prefs workingDirectory] stringByAppendingPathComponent:[filenames objectAtIndex:currentFile]];
	NSLog(@"Viewer is Loading File %d: %@", currentFile, filePath);
	[documentLabel setStringValue:[filenames objectAtIndex:currentFile]];
	if (![self exists:filePath]) {
		[ErrorController displayInView:contentArea];
		return;
	}
	NSArray *controllers = [NSArray arrayWithObjects: PDFController, WebController, TextController, nil];
	for (NSSProofViewController *cont in controllers) {
		if ([self tryLoad:filePath withViewer:cont]) {
			return;
		}
	}
	[IncompatibleController displayInView:contentArea];
}

- (BOOL)tryLoad:(NSString *)filePath withViewer:(NSSProofViewController *)controller {
	NSString *extension = [filePath pathExtension];
	NSString *uti = [self UTIForFile:filePath withExtension:extension];
	NSLog(@"Trying to load file with UTI %@", uti);
	if ([controller canDisplayType:uti]) {
		[controller displayInView:contentArea];
		[controller loadFileAtLocation:filePath];
		return YES;
	}
	return NO;
}

- (NSString *)UTIForFile:(NSString *)fileStr withExtension:(NSString *)ext {
	FSRef ref;
	FSPathMakeRef((const UInt8 *) [fileStr fileSystemRepresentation], &ref, NULL);
	CFArrayRef *lsAttributes = [NSArray arrayWithObjects:kLSItemContentType, nil];
	NSDictionary *lsReturn;
	LSCopyItemAttributes(&ref, kLSRolesEditor, lsAttributes, &lsReturn);
	return [lsReturn objectForKey:(NSString *)kLSItemContentType];
}
				
- (BOOL)isFolder:(NSString *)str {
	NSLog(@"isFolder called: this should not happen.  Falling back anyway...");
	BOOL isDirectory;
	[[NSFileManager defaultManager] fileExistsAtPath:str isDirectory:&isDirectory];
	return isDirectory;
}

- (BOOL)exists:(NSString *)str {
	NSLog(@"exists called: this should not happen.  Falling back anyway...");
	BOOL isDirectory;
	BOOL exists = [[NSFileManager defaultManager] fileExistsAtPath:str isDirectory:&isDirectory];
	return exists;
}

@end
