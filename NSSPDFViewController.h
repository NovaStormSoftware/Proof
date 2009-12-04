//
//  PDFViewController.h
//  Proof
//
//  Created by Justin Mrkva on 10/27/09.
//  Copyright 2009 NovaStorm Software. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "NSSProofViewController.h"
#import <Quartz/Quartz.h>


@interface NSSPDFViewController : NSSProofViewController {
	IBOutlet PDFView *PDFMainView;
	IBOutlet PDFThumbnailView *PDFThumbView;
}

@end
