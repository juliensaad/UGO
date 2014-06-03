//
//  UHomePageViewController.h
//  U:GO
//
//  Created by Julien Saad on 11/21/2013.
//  Copyright (c) 2013 Third Bridge. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UPersonaView.h"

@interface UHomePageViewController : UKingViewController
@property (weak, nonatomic) IBOutlet UILabel *selectGuideLabel;
- (IBAction)sidebarClick:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *persona1;
@property (weak, nonatomic) IBOutlet UILabel *persona2;
@property (weak, nonatomic) IBOutlet UILabel *persona3;
@property (weak, nonatomic) IBOutlet UILabel *persona4;

@property (weak, nonatomic) IBOutlet UGOLabel *v1;
@property (weak, nonatomic) IBOutlet UGOLabel *v2;
@property (weak, nonatomic) IBOutlet UGOLabel *v3;
@property (weak, nonatomic) IBOutlet UGOLabel *v4;
@property (weak, nonatomic) IBOutlet UILabel *selectLabel;


@property (weak, nonatomic) IBOutlet UPersonaView *im1;
@property (weak, nonatomic) IBOutlet UPersonaView *im2;
@property (weak, nonatomic) IBOutlet UPersonaView *im3;
@property (weak, nonatomic) IBOutlet UPersonaView *im4;

@property (weak, nonatomic) IBOutlet UIView *content;
@property (weak, nonatomic) IBOutlet UIView *topBar;




@end
