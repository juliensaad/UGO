//
//  UVenueView.h
//  U:GO
//
//  Created by Julien Saad on 1/21/2014.
//  Copyright (c) 2014 Third Bridge. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface UVenueView : UIView
- (IBAction)weeksPickClick:(id)sender;


@property UIView*circle;
@property (weak, nonatomic) IBOutlet UIView *weeksPickView;
@property (weak, nonatomic) IBOutlet UIView *personView;
@property (weak, nonatomic) IBOutlet UIImageView *smallArrow;
@property (weak, nonatomic) IBOutlet UIImageView *personaFace;

@property (weak, nonatomic) IBOutlet UIButton *priceButton;
@property (weak, nonatomic) IBOutlet UIButton *fbButton;

@property (weak, nonatomic) IBOutlet UIImageView *backgroundType;

@property (weak, nonatomic) IBOutlet UIImageView *priceBox;

@property (weak, nonatomic) IBOutlet UIView *topBarView;
@property (weak, nonatomic) IBOutlet UIView *middleBarView;
@property (weak, nonatomic) IBOutlet UIView *bottomContentView;
@property (weak, nonatomic) IBOutlet UIButton *facebookButton;

- (IBAction)infoClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionview;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (weak, nonatomic) IBOutlet UILabel *venueName;

- (IBAction)menuClick:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *favButton;
@property (weak, nonatomic) IBOutlet UIButton *callButton;

@property BOOL isWeeksPickUp;
@property (weak, nonatomic) IBOutlet UIButton *wpButton;


@property (weak, nonatomic) IBOutlet UGOLabel *personaName;
@property (weak, nonatomic) IBOutlet UGOLabel *personaDesc;
@property (weak, nonatomic) IBOutlet UITextView *venueDesc;

@property (weak, nonatomic) IBOutlet UIImageView *iconography;

@property (weak, nonatomic) Persona *persona;
- (IBAction)getDirectionsClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *bestTime;

@end
