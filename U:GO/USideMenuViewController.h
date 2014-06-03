//
//  USideMenuViewController.h
//  U:GO
//
//  Created by Julien Saad on 11/21/2013.
//  Copyright (c) 2013 Third Bridge. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface USideMenuViewController : UIViewController<FBLoginViewDelegate>
- (IBAction)closeButtonPressed:(id)sender;
- (IBAction)sailClick:(id)sender;
- (IBAction)weekClick:(id)sender;
- (IBAction)favClick:(id)sender;
- (IBAction)aboutClick:(id)sender;
@property (weak, nonatomic) IBOutlet FBLoginView *loginView;
@property (weak, nonatomic) IBOutlet UILabel *unlockLabel;
@property (weak, nonatomic) IBOutlet UIView *sideView;
@property (weak, nonatomic) IBOutlet UIButton *l1;
@property (weak, nonatomic) IBOutlet UIButton *l2;
@property (weak, nonatomic) IBOutlet UIButton *l3;
@property (weak, nonatomic) IBOutlet UIButton *l4;

@property (weak, nonatomic) IBOutlet UIView *fbView;
@end
