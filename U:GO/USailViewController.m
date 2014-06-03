//
//  USailViewController.m
//  U:GO
//
//  Created by Julien Saad on 1/5/2014.
//  Copyright (c) 2014 Third Bridge. All rights reserved.
//

#import "USailViewController.h"
#import "MyLocation.h"
#import "WSingleton.h"
#import "CalloutView.h"

@interface USailViewController ()

@property NSMutableArray *positions;

@end

@implementation USailViewController

#ifndef DBL_MAX
#define DBL_MAX 100000
#endif
CLLocationDegrees minLatitude = DBL_MAX;
CLLocationDegrees maxLatitude = -DBL_MAX;
CLLocationDegrees minLongitude = DBL_MAX;
CLLocationDegrees maxLongitude = -DBL_MAX;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _mapView.delegate = self;
    [self getLongLat];

    
	// Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

-(void)getLongLat{
    for (Persona *p in [[WSingleton sharedManager] webContent]) {
        // Get LONG and LAT
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/geocode/json?address=%@&sensor=true", [p.venue.location stringByReplacingOccurrencesOfString:@" " withString:@"+"]]];
        
        [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:url]
                                           queue:[NSOperationQueue currentQueue]
                               completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                                   //NSLog(@"dataAsString %@", [NSString stringWithUTF8String:[data bytes]]);
                                   NSLog(@"DONE! %d", [data length]);
                                   if([data length]>200){
                                       NSError* error1;
                                       NSLog(@"dataAsString %@", [NSString stringWithUTF8String:[data bytes]]);
                                       NSMutableDictionary * innerJson = [NSJSONSerialization
                                                                          JSONObjectWithData:data options:kNilOptions error:&error1
                                                                          ];
                                       
                                       if([innerJson objectForKey:@"results"]){
                                           
                                           NSDictionary *location = [[[[innerJson objectForKey:@"results"] objectAtIndex:0] objectForKey:@"geometry" ] objectForKey:@"location"];
                                           [self plotPosition:[[location objectForKey:@"lat"] doubleValue] :[[location objectForKey:@"lng"]doubleValue] withPersona:p];
                                       }
                                   }
                                   
                               }];
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// Add new method above refreshTapped
- (void)plotPosition:(double)lat :(double)lon withPersona:(Persona*)p{
    
    NSString *place = p.venue.name;
    NSString *address = p.venue.location;
    
    CLLocationCoordinate2D coordinate;
    coordinate.latitude = lat;
    coordinate.longitude = lon;
    MyLocation *annotation = [[MyLocation alloc] initWithName:place address:address coordinate:coordinate] ;
    [_mapView addAnnotation:annotation];
    
    double annotationLat = annotation.coordinate.latitude;
    double annotationLong = annotation.coordinate.longitude;
    minLatitude = fmin(annotationLat, minLatitude);
    maxLatitude = fmax(annotationLat, maxLatitude);
    minLongitude = fmin(annotationLong, minLongitude);
    maxLongitude = fmax(annotationLong, maxLongitude);
    
    // See function below
    [self setMapRegionForMinLat:minLatitude minLong:minLongitude maxLat:maxLatitude maxLong:maxLongitude];

    
}

// pad our map by 10% around the farthest annotations
#define MAP_PADDING 1.7
#define MINIMUM_VISIBLE_LATITUDE 0.01
-(void) setMapRegionForMinLat:(double)minLatitude minLong:(double)minLongitude maxLat:(double)maxLatitude maxLong:(double)maxLongitude {
	
	MKCoordinateRegion region;
	region.center.latitude = (minLatitude + maxLatitude) / 2;
	region.center.longitude = (minLongitude + maxLongitude) / 2;
	
	region.span.latitudeDelta = (maxLatitude - minLatitude) * MAP_PADDING;
	
	region.span.latitudeDelta = (region.span.latitudeDelta < MINIMUM_VISIBLE_LATITUDE)
    ? MINIMUM_VISIBLE_LATITUDE
    : region.span.latitudeDelta;
	
	region.span.longitudeDelta = (maxLongitude - minLongitude) * MAP_PADDING;
	
	MKCoordinateRegion scaledRegion = [_mapView regionThatFits:region];
	
    [self.mapView setRegion:scaledRegion animated:NO];
}


- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MyLocation *)view {
	if(![view.annotation isKindOfClass:[MKUserLocation class]]) {
		CalloutView *calloutView = (CalloutView *)[[[NSBundle mainBundle] loadNibNamed:@"callOutView" owner:self options:nil] objectAtIndex:0];
		CGRect calloutViewFrame = calloutView.frame;
		calloutViewFrame.origin = CGPointMake(-calloutViewFrame.size.width/2, -calloutViewFrame.size.height+12);
		calloutView.frame = calloutViewFrame;
        [calloutView.name setText:[[view annotation] title]];
        [calloutView.location setText:[(MyLocation*)[view annotation] location]];
        [view addSubview:calloutView];
        
        [view setSel:@selector(viewEvent:)];
        [view setSender:self];
        
        NSArray* _data = [[WSingleton sharedManager]webContent];
        for(Persona* p in _data){
            if([p.venue.name isEqualToString:calloutView.name.text])
                [[WSingleton sharedManager] setCurrentVenue:[p.venue.venueId intValue]];
            }
        }
        [_mapView setCenterCoordinate:view.annotation.coordinate animated:YES];
	}




-(void)viewEvent:(id)sender{
	[self performSegueWithIdentifier:@"venue" sender:self];
}

-(void)mapView:(MKMapView *)mapView didDeselectAnnotationView:(MKAnnotationView *)view {
	for (UIView *subview in view.subviews ){
		[subview removeFromSuperview];
	}
}


- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    static NSString *identifier = @"MyLocation";
    if ([annotation isKindOfClass:[MyLocation class]]) {
        
        MyLocation *annotationView = (MyLocation *) [_mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
        if (annotationView == nil) {
            annotationView = [[MyLocation alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
            annotationView.enabled = YES;
            annotationView.image = [UIImage imageNamed:@"marker"];
            
            for(UIView* v in _mapView.subviews){
                
                [v setBackgroundColor:UIColorFromRGB(UGOTURQUOISE)];
            }
        
            
        } else {
            annotationView.annotation = annotation;
        }
        
        return annotationView;
    }
    
    return nil;
}

@end
