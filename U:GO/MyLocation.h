//
//  MyLocation.h
//  U:GO
//
//  Created by Julien Saad on 2/9/2014.
//  Copyright (c) 2014 Third Bridge. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
@interface MyLocation : MKAnnotationView<MKAnnotation>

- (id)initWithName:(NSString*)name address:(NSString*)address coordinate:(CLLocationCoordinate2D)coordinate;
- (MKMapItem*)mapItem;

@property NSString* location;

@property SEL sel;
@property id sender;

@end
