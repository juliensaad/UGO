//
//  WSingleton.m
//  iWine
//
//  Created by Julien Saad on 2013-10-18.
//  Copyright (c) 2013 Third Bridge. All rights reserved.
//

#import "WSingleton.h"

@implementation WSingleton
@synthesize defaults;

#pragma mark Singleton Methods

+ (id)sharedManager {
    static WSingleton *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}


- (id)init {
	if (self = [super init]) {
		// Init userdefaults
		defaults = [NSUserDefaults standardUserDefaults];
		_webContent = [[NSMutableArray alloc]init];
		_currentVenue = 0;
		_isLoggedIn = YES;

	}
	return self;
}

@end
