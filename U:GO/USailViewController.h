//
//  USailViewController.h
//  U:GO
//
//  Created by Julien Saad on 1/5/2014.
//  Copyright (c) 2014 Third Bridge. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
@interface USailViewController : UKingViewController<MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@end
