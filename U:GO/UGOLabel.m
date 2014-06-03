//
//  UGOLabel.m
//  U:GO
//
//  Created by Julien Saad on 3/17/2014.
//  Copyright (c) 2014 Third Bridge. All rights reserved.
//

#import "UGOLabel.h"

@implementation UGOLabel

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
-(void)awakeFromNib{
        
    [super awakeFromNib];
    [self setAdjustsFontSizeToFitWidth:YES];
    //  [self setFont:[UIFont fontWithName:FONT_BOLD size:self.font.pointSize]];
}

@end
