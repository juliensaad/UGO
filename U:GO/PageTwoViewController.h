//
//  PageTwoViewController.h
//  U:GO
//
//  Created by Julien Saad on 2014-06-03.
//  Copyright (c) 2014 Third Bridge. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PageTwoViewController : UIViewController

@property NSUInteger pageIndex;
@property (weak, nonatomic) IBOutlet UILabel *welbomeLabel;
@property (weak, nonatomic) IBOutlet UILabel *t1Label;
@property (weak, nonatomic) IBOutlet UILabel *t2Label;
@property (weak, nonatomic) IBOutlet UIButton *goButton;

@end
