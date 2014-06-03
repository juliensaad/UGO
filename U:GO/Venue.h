//
//  Venue.h
//  U:GO
//
//  Created by Julien Saad on 1/21/2014.
//  Copyright (c) 2014 Third Bridge. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Venue : NSObject

@property NSString* name;
@property NSString* descriptionFr;
@property NSString* descriptionEn;
@property NSString* fbUrl;
@property NSString* location;
@property NSString* venueId;

@property NSString* phoneNumber;
@property NSString* bestTime;
@property int icono;
@property int price;


@property UIColor* color;

@property int type;

@property NSMutableArray* imgUrls;
@property NSMutableArray* images;

@property NSString* dBID;


@end
