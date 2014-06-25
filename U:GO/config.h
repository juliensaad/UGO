//
//  config.h
//  U:GO
//
//  Created by Julien Saad on 11/15/2013.
//  Copyright (c) 2013 Third Bridge. All rights reserved.
//

#ifndef U_GO_config_h
#define U_GO_config_h

#define TBAR_COLOR [UIColor colorWithRed:22.0/255.0 green:29.0/255.0 blue:32.0/255.0 alpha:1.0]
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define UGOWHITE 0xeaedf1
#define UGOGRAY 0x293236
#define UGOTURQUOISE 0x2cb299
#define UGOLIGHTGRAY 0xeaedf1

#define UGO_TYPE1 0xf1ae53
#define UGO_TYPE2 0xee555b
#define UGO_TYPE3 0x9664a7
#define UGO_TYPE4 0x2cb299
#define UGO_TYPE5 0x8babd7

#define ISLOGGEDIN [[[[WSingleton sharedManager] defaults]objectForKey:@"isloggedin"] isEqualToString:@"YES"]

#define ISFRENCH ![[[NSLocale preferredLanguages] objectAtIndex:0] isEqualToString:@"en"]

#define ISIPHONE5  ([[UIScreen mainScreen] bounds].size.height == 568)?TRUE:FALSE
#define ISIPAD (([[UIScreen mainScreen] bounds].size.height == 1024)?TRUE:FALSE)

#define STORYBOARDNAME ( (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) ? @"MainStoryboard_iPad" : @"MainStoryboard_iPhone" )
#define yScreenWidth [UIScreen mainScreen].bounds.size.width
#define yScreenHeight [UIScreen mainScreen].bounds.size.height

#define FONT @"OpenSans"
#define FONT_BOLD @"OpenSans-SemiBold"

#define FONT_EXTRA_SMALL [UIFont fontWithName:FONT size:15]
#define FONT_SMALL [UIFont fontWithName:FONT size:14]
#define FONT_MEDIUM [UIFont fontWithName:FONT size:18]
#define FONT_LARGE [UIFont fontWithName:FONT size:22]

#define FONT_BOLD_EXTRA_SMALL [UIFont fontWithName:FONT_BOLD size:14]
#define FONT_BOLD_SMALL [UIFont fontWithName:FONT_BOLD size:16]
#define FONT_BOLD_MEDIUM [UIFont fontWithName:FONT_BOLD size:20]
#define FONT_BOLD_LARGE [UIFont fontWithName:FONT_BOLD size:24]

#define NAV_STATUS_HEIGHT 64


// LANGUAGE

#define lVISIT (ISFRENCH?@"Visiter":@"Visit Page")
#define lSELECTGUIDE (ISFRENCH?@"Choisissez votre guide":@"Select Your Guide")

#define lPICKS (ISFRENCH?@"CHOIX DE LA SEMAINE":@"THIS WEEK'S PICKS")
#define lSAIL (ISFRENCH?@"VOGUEZ LA VILLE":@"SAIL ALONG THE CITY")
#define lFAVS (ISFRENCH?@"MES FAVORIS":@"MY FAVOURITES")
#define lABOUT (ISFRENCH?@"    À PROPOS DE UGO":@"    ABOUT UGO")
#define lUNLOCKALL (ISFRENCH?@"Pour pouvoir faire plus:":@"To unlock all features, please")

#define WS_URL @"http://thirdbridge.net/ugo/"

#endif
