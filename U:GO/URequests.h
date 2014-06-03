//
//  URequests.h
//  U:GO
//
//  Created by Julien Saad on 1/5/2014.
//  Copyright (c) 2014 Third Bridge. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface URequests : NSObject

+(void)getEventsWithSuccessFunction:(SEL)selector andSender:(id)sender;
+(void)getImageWithURL:(NSString*)url andImageView:(UIImageView*)im;

+(void)getImageWithURL:(NSString*)url andPersona:(Persona*)p;

+(void)createUserWithUsername:(NSString*)name
                        andId:(int)userid
                     andFName:(NSString*)fname
                     andLName:(NSString*)lname
                    andGender:(NSString*)gender
                    andLocale:(NSString*)locale;

+(void)addFavourite:(NSString*)venueId;

+(void)createUser:(NSDictionary*)params;

+(void)getFavourites:(SEL)selector :(id)sender;

+(void)deleteFavourite:(NSString*)venueId;
@end
