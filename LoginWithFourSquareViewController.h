//
//  LoginWithFourSquareViewController.h
//  LoginWithFourSquare
//
//  Created by Ammad on 24/11/14.
//  Copyright (c) 2014 Ammad. All rights reserved.
// www.codegerms.com

#import <UIKit/UIKit.h>
#import "OAuthConsumer.h"
#import "AppDelegate.h"
#import "SBJsonParser.h"

@interface LoginWithFourSquareViewController : UIViewController<UIWebViewDelegate>
{
    IBOutlet UIWebView *webview;
    OAConsumer* consumer;
    OAToken* requestToken;
    OAToken* accessToken;
    NSMutableData *receivedData;
}

@property (nonatomic, retain) IBOutlet UIWebView *webview;
//@property (nonatomic, retain) IBOutlet TapazineLoadingIndicator *indicator;
@property (nonatomic, retain) NSString *isLogin;
@property (assign, nonatomic) Boolean isReader;
@end
