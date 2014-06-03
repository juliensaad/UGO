//
//  CalloutView.h
//  U:GO
//
//  Created by Julien Saad on 3/4/2014.
//  Copyright (c) 2014 Third Bridge. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CalloutView : UIView
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *location;
@property (weak, nonatomic) IBOutlet UIButton *button;

@property (nonatomic) SEL topselector;
- (IBAction)buttonClick:(id)sender;

@end
