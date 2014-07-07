//
//  USailFinalViewController.m
//  U:GO
//
//  Created by Julien Saad on 2014-05-28.
//  Copyright (c) 2014 Third Bridge. All rights reserved.
//

#import "USailFinalViewController.h"

@interface USailFinalViewController ()

@property NSMutableArray* sailAddresses;
@end

@implementation USailFinalViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.screenName = @"Map Screen - iOS";
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _mapView.delegate = self;
    _mapView.showsUserLocation = YES;
    

    
    
    
    // Do any additional setup after loading the view.
    
    // Set region to montreal

    MKCoordinateRegion region =
    MKCoordinateRegionMakeWithDistance (
                                        CLLocationCoordinate2DMake(45.500146, -73.568321), 3000, 3000);
    [_mapView setRegion:region animated:NO];
   
   [self.mapView setRegion:[self.mapView regionThatFits:region] animated:YES];
   

    // Add an annotation
    // NSMutableArray* coordinates = [[NSMutableArray alloc] init];
    
    NSMutableArray* _sailTitles = [[NSMutableArray alloc] init];
    _sailAddresses = [[NSMutableArray alloc] init];
    
    [_sailAddresses addObjectsFromArray:[NSArray arrayWithObjects:@"1432 Mackay St, Montreal, QC H3G 2H7", @"1300 Rue Sherbrooke Ouest, Montréal, QC H3G 1G2", @"1193 Place Phillips, Montréal, QC H3B 3C9", @"333 Rue de la Commune Ouest, Montréal, QC H2Y 2E2", @"Quais Du Vieux-Port, Montreal, QC H3C 2W3", @"92 Rue de la Gauchetière Ouest, Montréal, QC H2Z 1C1", nil]];

    
    if(!ISFRENCH){
    [_sailTitles addObject:@"Café Myriade"];
    [_sailTitles addObject:@"Shopping"];
    [_sailTitles addObject:@"Place Phillips"];
    [_sailTitles addObject:@"Old Port of Montreal"];
    [_sailTitles addObject:@"Terrasse"];
    [_sailTitles addObject:@"Dessert"];
        
    }else{
        [_sailTitles addObjectsFromArray:[NSArray arrayWithObjects:@"Café Myriade",@"Shopping",@"Place Phillips",@"Vieux-Port de Montréal",@"Terrasse",@"Dessert", nil]];
    }
    
    for(int i = 0;i<_sailTitles.count;i++){
        CLLocationCoordinate2D coord;
        switch (i) {
            case 0:
                coord = CLLocationCoordinate2DMake(45.496300, -73.578070);
                break;
            case 1:
                coord = CLLocationCoordinate2DMake(45.496127, -73.576804);
                break;
            case 2:
                coord = CLLocationCoordinate2DMake(45.503664, -73.567819);
                break;
            case 3:
                coord = CLLocationCoordinate2DMake(45.502340, -73.553875);
                break;
            case 4:
                coord = CLLocationCoordinate2DMake(45.504070, -73.554648);
                break;
            case 5:
                coord = CLLocationCoordinate2DMake(45.507787, -73.560508);
                break;
                
            default:
                break;
        }
        
        
        MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
        point.coordinate = coord;
        point.title = _sailTitles[i];
        
        point.subtitle = [_sailAddresses objectAtIndex:i];

        [self.mapView addAnnotation:point];
    }
    
   
}

#pragma mark -
#pragma mark MKMapView delegate
- (MKAnnotationView *)mapView:(MKMapView *)mapview viewForAnnotation:(id <MKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MKUserLocation class]])
        return nil;
    static NSString* AnnotationIdentifier = @"AnnotationIdentifier";
    MKAnnotationView *annotationView = [mapview dequeueReusableAnnotationViewWithIdentifier:AnnotationIdentifier];
    if(annotationView)
        return annotationView;
    else
    {
        NSLog(@"ELSE");
        MKAnnotationView *annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation
                                                                         reuseIdentifier:AnnotationIdentifier];
        annotationView.canShowCallout = YES;
        annotationView.image = [UIImage imageNamed:@"marker"];
        
        
        UILabel* l = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, annotationView.frame.size.width, annotationView.frame.size.height-5)];
        
        NSString* pinText;
        for(int i = 0;i<_sailAddresses.count;i++){
            if([_sailAddresses[i] isEqualToString:[annotationView.annotation subtitle]])
                pinText = [NSString stringWithFormat:@"%d", i+1];
                
        }
        l.text = pinText;
        l.adjustsFontSizeToFitWidth = YES;
        l.textAlignment = NSTextAlignmentCenter;
        l.textColor = [UIColor whiteColor];
        l.backgroundColor = [UIColor clearColor];
        [annotationView addSubview:l];
        
        return annotationView;
    }
    return nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)moreClick:(id)sender {
}
@end
