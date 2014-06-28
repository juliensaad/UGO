//
//  UPersonaView.m
//  U:GO
//
//  Created by Julien Saad on 1/31/2014.
//  Copyright (c) 2014 Third Bridge. All rights reserved.
//

#import "UPersonaView.h"

@implementation UPersonaView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)awakeFromNib{
	self.layer.borderWidth = 4.0f;
	self.layer.borderColor = UIColorFromRGB(UGOTURQUOISE).CGColor;
	self.layer.cornerRadius = self.frame.size.width/2;
	self.clipsToBounds = YES;
}

-(void)setType:(int)type{
	
	switch (type) {
		case 0:
			self.layer.borderColor = UIColorFromRGB(UGO_TYPE1).CGColor;
			break;
		case 1:
			self.layer.borderColor = UIColorFromRGB(UGO_TYPE2).CGColor;
			break;
		case 2:
			self.layer.borderColor = UIColorFromRGB(UGO_TYPE3).CGColor;
			break;
		case 3:
			self.layer.borderColor = UIColorFromRGB(UGO_TYPE4).CGColor;
			break;
        case 4:
			self.layer.borderColor = UIColorFromRGB(UGO_TYPE5).CGColor;
			break;
			
		default:
			break;
	}
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
