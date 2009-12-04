//
//  PreferenceController.m
//  Proof
//
//  Created by Justin Mrkva on 10/27/09.
//  Copyright 2009 2009 NovaStorm Software. All rights reserved.
//

#import "PreferenceController.h"
#define NSSWorkingDirectory @"defaultFolder"
#define NSSSavingDirectory @"savingFolder"

@implementation PreferenceController

- (id)init {
	[super init];
	ud = [NSUserDefaults standardUserDefaults];
	[self registerDefaults];
	return self;
}

#pragma mark Mutators

- (void)setWorkingDirectory:(NSString *)string {
	[ud setObject:string forKey:NSSWorkingDirectory];
	[ud synchronize];
}
- (NSString *)workingDirectory {
	return [ud objectForKey:NSSWorkingDirectory];
}

- (void)setSavingDirectory:(NSString *)string {
	[ud setObject:string forKey:NSSSavingDirectory];
	[ud synchronize];
}
- (NSString *)savingDirectory {
	return [ud objectForKey:NSSSavingDirectory];
}

#pragma mark Utility Actions

- (void)registerDefaults {
	NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
	[dict setObject:@"" forKey:NSSWorkingDirectory];
	[dict setObject:@"~/" forKey:NSSSavingDirectory];
	[ud registerDefaults:dict];
}
@end
