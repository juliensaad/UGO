//
//  UInscructionsViewController.h
//  U:GO
//
//  Created by Julien Saad on 2014-05-28.
//  Copyright (c) 2014 Third Bridge. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UInscructionsViewController : GAITrackedViewController<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *returnmapClick;
- (IBAction)returnClick:(id)sender;

@end
