//
//  UVenueView.m
//  U:GO
//
//  Created by Julien Saad on 1/21/2014.
//  Copyright (c) 2014 Third Bridge. All rights reserved.
//

#import "UVenueView.h"

@implementation UVenueView

CGRect arrowFrame;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
-(void)awakeFromNib{
    
    _circle = [[UIView alloc] initWithFrame:CGRectMake(181, 187, 36, 36)];
    [self.personView addSubview:_circle];
    
    _circle.layer.cornerRadius = 18;
    _circle.clipsToBounds = YES;
    _circle.backgroundColor = UIColorFromRGB(0xeaedf1);
    
    [self.personView bringSubviewToFront:_iconography];
    
    _backgroundType.clipsToBounds = YES;
 
    

	self.isWeeksPickUp = NO;
	arrowFrame = _smallArrow.frame;
    
    [_wpButton setTitle:[lPICKS uppercaseString] forState:UIControlStateNormal];
	
	_personaFace.layer.cornerRadius = _personaFace.frame.size.height/2;
	_personaFace.clipsToBounds = YES;
    _timeLabel.adjustsFontSizeToFitWidth = YES;
    
    
    
    _iconography.layer.cornerRadius = _iconography.frame.size.height/2;
    UISwipeGestureRecognizer* swipe;
    swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(weeksPickClick:)];
    swipe.direction = UISwipeGestureRecognizerDirectionUp;
    [self addGestureRecognizer:swipe];
    
    UISwipeGestureRecognizer* swipeDown;
    swipeDown = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(weeksPickClick:)];
    swipeDown.direction = UISwipeGestureRecognizerDirectionDown;
    [self addGestureRecognizer:swipeDown];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/




#define PERSONPOSY 372
#define PERSON4POSY 412
- (IBAction)weeksPickClick:(id)sender {
	
    if(ISIPHONE5){
        if(!self.isWeeksPickUp){
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationBeginsFromCurrentState:YES];
            [UIView setAnimationDuration:0.7];
            
            [self.weeksPickView setFrame:CGRectMake(0, self.weeksPickView.frame.origin.y-PERSONPOSY, yScreenWidth, yScreenHeight)];
            [self.personView setFrame:CGRectMake(0, -PERSONPOSY, yScreenWidth, yScreenHeight)];
            
            
            CGRect newFrame = arrowFrame;
            newFrame.origin.y +=30;
            //_smallArrow.frame = newFrame;
            _smallArrow.transform = CGAffineTransformMakeRotation(M_PI);
            
            
            [UIView commitAnimations];
            
            self.isWeeksPickUp = YES;
            
            
        }else{
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationBeginsFromCurrentState:YES];
            [UIView setAnimationDuration:0.7];
            [self.weeksPickView setFrame:CGRectMake(0, PERSONPOSY, yScreenWidth, yScreenHeight)];
            [self.personView setFrame:CGRectMake(0, 0, yScreenWidth, yScreenHeight)];
            //_smallArrow.frame = arrowFrame;
            _smallArrow.transform = CGAffineTransformMakeRotation(0);
            self.isWeeksPickUp = NO;
            [UIView commitAnimations];
	}
    }else{
        if(!self.isWeeksPickUp){
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationBeginsFromCurrentState:YES];
            [UIView setAnimationDuration:0.7];
            
            [self.weeksPickView setFrame:CGRectMake(0, self.weeksPickView.frame.origin.y-PERSON4POSY, yScreenWidth, yScreenHeight)];
            [self.personView setFrame:CGRectMake(0, -372, yScreenWidth, yScreenHeight)];
            
            
            CGRect newFrame = arrowFrame;
            newFrame.origin.y +=30;
            //_smallArrow.frame = newFrame;
            _smallArrow.transform = CGAffineTransformMakeRotation(M_PI);
            
            
            [UIView commitAnimations];
            
            self.isWeeksPickUp = YES;
            
            
        }else{
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationBeginsFromCurrentState:YES];
            [UIView setAnimationDuration:0.7];

            [self.weeksPickView setFrame:CGRectMake(0, PERSON4POSY+(ISIPHONE5?0:-40), yScreenWidth, yScreenHeight)];
            [self.personView setFrame:CGRectMake(0, 0, yScreenWidth, yScreenHeight)];
            //_smallArrow.frame = arrowFrame;
            _smallArrow.transform = CGAffineTransformMakeRotation(0);
            self.isWeeksPickUp = NO;
            [UIView commitAnimations];
            
            
        }
    }
}

-(void)viewWillDisappear:(BOOL)animated{
	
	self.isWeeksPickUp = NO;
	arrowFrame = _smallArrow.frame;
	
}
- (IBAction)getDirectionsClicked:(id)sender {
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    
    NSString *addressString = [[_persona venue] location];
    
    
    [geocoder
     geocodeAddressString:addressString
     completionHandler:^(NSArray *placemarks,
                         NSError *error) {
         
         if (error) {
             NSLog(@"Geocode failed with error: %@", error);
             return;
         }
         
         if (placemarks && placemarks.count > 0)
         {
             CLPlacemark *placemark = placemarks[0];
             
             CLLocation *location = placemark.location;
             CLLocationCoordinate2D coords = location.coordinate;
             
             [self showMapWithCoords: coords];
         }
     }];
}

-(void)showMapWithCoords:(CLLocationCoordinate2D)coords{

    MKPlacemark *place = [[MKPlacemark alloc]
                          initWithCoordinate:coords
                          addressDictionary:nil];
    
    MKMapItem *mapItem =
    [[MKMapItem alloc]initWithPlacemark:place];
    
    NSDictionary *options = @{
                              MKLaunchOptionsDirectionsModeKey: 
                                  MKLaunchOptionsDirectionsModeDriving
                              };
    
    [mapItem openInMapsWithLaunchOptions:options];
}
@end
