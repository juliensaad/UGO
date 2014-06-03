//
//  USuggestionViewController.h
//  U:GO
//
//  Created by Julien Saad on 11/21/2013.
//  Copyright (c) 2013 Third Bridge. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface USuggestionViewController : UKingViewController
- (IBAction)weeksPickClick:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *weeksPickView;
@property (weak, nonatomic) IBOutlet UIView *personView;
@property (weak, nonatomic) IBOutlet UIImageView *smallArrow;


@property BOOL isWeeksPickUp;
@end
