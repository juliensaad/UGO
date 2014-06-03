//
//  USplashViewController.h
//  U:GO
//
//  Created by Julien Saad on 1/27/2014.
//  Copyright (c) 2014 Third Bridge. All rights reserved.
//

#import "UKingViewController.h"
#import "UButton.h"
#import "UPageContentViewController.h"

@interface USplashViewController : UKingViewController<UIPageViewControllerDataSource, UIPageViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *gLetter;
@property (weak, nonatomic) IBOutlet UIImageView *oLetter;
@property (weak, nonatomic) IBOutlet UIImageView *uLetter;
@property (weak, nonatomic) IBOutlet UIImageView *shadow;
@property (weak, nonatomic) IBOutlet UIImageView *splashText;
@property (weak, nonatomic) IBOutlet UButton *b1;
@property (weak, nonatomic) IBOutlet UButton *b2;
@property (weak, nonatomic) IBOutlet UButton *b3;

@property (weak, nonatomic) IBOutlet UIView *btnView;


@property (weak, nonatomic) IBOutlet UIView *sliderView;



- (IBAction)startWalkthrough:(id)sender;
@property (strong, nonatomic) UIPageViewController *pageViewController;
@property (strong, nonatomic) NSArray *pageTitles;
@property (strong, nonatomic) NSArray *pageImages;


@end
