//
//  WSingleton.h
//  iWine
//
//  Created by Julien Saad on 2013-10-18.
//  Copyright (c) 2013 Third Bridge. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@interface WSingleton : NSObject{
	NSUserDefaults *defaults;
}
+ (id)sharedManager;
@property (nonatomic, retain) NSUserDefaults *defaults;

@property (nonatomic, strong) NSMutableArray *webContent;
@property int currentVenue;
@property BOOL isLoggedIn;

@property (nonatomic, strong) NSMutableArray* favourites;

@end
