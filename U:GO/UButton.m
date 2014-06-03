//
//  UButton.m
//  U:GO
//
//  Created by Julien Saad on 1/27/2014.
//  Copyright (c) 2014 Third Bridge. All rights reserved.
//

#import "UButton.h"

@implementation UButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
	self.titleLabel.font = FONT_SMALL;
}


@end
