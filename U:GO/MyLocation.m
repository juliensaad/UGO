//
//  MyLocation.m
//  U:GO
//
//  Created by Julien Saad on 2/9/2014.
//  Copyright (c) 2014 Third Bridge. All rights reserved.
//

#import "MyLocation.h"
#import <AddressBook/AddressBook.h>
#import "UAppDelegate.h"
#import "UVenueViewController.h"
#import "CalloutView.h"
@interface MyLocation ()
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *address;
@property (nonatomic, assign) CLLocationCoordinate2D theCoordinate;
@end

@implementation MyLocation

- (id)initWithName:(NSString*)name address:(NSString*)address coordinate:(CLLocationCoordinate2D)coordinate {
    if ((self = [super init])) {
        if ([name isKindOfClass:[NSString class]]) {
            self.name = name;
        } else {
            self.name = @"Unknown charge";
        }
        self.address = address;
        _location = address;
        self.theCoordinate = coordinate;
    }
    return self;
}


- (NSString *)title {
    return _name;
}

- (NSString *)subtitle {
    return _address;
}

- (CLLocationCoordinate2D)coordinate {
    return _theCoordinate;
}

- (MKMapItem*)mapItem {
    NSDictionary *addressDict = @{(NSString*)kABPersonAddressStreetKey : _address};
    
    MKPlacemark *placemark = [[MKPlacemark alloc]
                              initWithCoordinate:self.coordinate
                              addressDictionary:addressDict];
    
    MKMapItem *mapItem = [[MKMapItem alloc] initWithPlacemark:placemark];
    mapItem.name = self.title;
    
    return mapItem;
}


- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    UIView * hitView = [super hitTest:point withEvent:event];
    if (hitView)
        return hitView;
	
    for (UIView * subview in self.subviews)
    {
        
        if ([subview isKindOfClass:[NSClassFromString(@"CalloutView") class]]) {
            for(UIView *subTextView in subview.subviews){
                if([subTextView isKindOfClass:[UIButton class]]){
                    CGRect touchableArea = CGRectMake(40, subview.frame.origin.y, 20, 100);
                    if (CGRectContainsPoint(touchableArea, point)){
                        [_sender performSelectorOnMainThread:_sel withObject:_sender waitUntilDone:YES];
                        
						//UIStoryboard * st = [UIStoryboard storyboardWithName:STORYBOARDNAME bundle:nil];
						//UVenueViewController *viewController = [st instantiateViewControllerWithIdentifier:@"StudioPage"];
						//[self.navigationController pushViewController:viewController animated:YES];
						//[viewController set:[(CalloutView*)subview studioId]];
						//[[(UAppDelegate*)[[UIApplication sharedApplication] delegate] navigationController] pushViewController:viewController animated:YES];
						return subTextView;
                    }
                }
            }
        }
    }
    return nil;
}


@end
