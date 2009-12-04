//
//  PDFViewController.m
//  Proof
//
//  Created by Justin Mrkva on 10/27/09.
//  Copyright 2009 2009 NovaStorm Software. All rights reserved.
//

#import "NSSPDFViewController.h"


@implementation NSSPDFViewController

- (void)awakeFromNib {
	//[PDFThumbView se
}

- (void)loadFileAtLocation:(NSString *)filename {
	NSLog(@"NSSPDFViewController loaded file: %@", filename);
	//[PDFMainView loadFileAtLocation:filename];
	[PDFThumbView setPDFView:nil];
	[PDFMainView setDocument:[[PDFDocument alloc] initWithData:[NSData dataWithContentsOfFile:filename]]];
	[PDFThumbView setPDFView:PDFMainView];
	[PDFMainView setAutoScales:YES];
	NSLog(@"PDFView %@ has document: %@", PDFMainView, [PDFMainView document]);
}

- (NSArray *)viewableTypes {
	return [NSArray arrayWithObjects:(NSString *)kUTTypePDF, nil];
}

- (void)splitViewDidResizeSubviews:(NSNotification *)aNotification {
	//NSLog(@"Did Resize");
	int width = [PDFThumbView bounds].size.width - 20;
	if (width > 20) {
		[PDFThumbView setThumbnailSize:NSMakeSize(width, width)];
	}
}

@end
