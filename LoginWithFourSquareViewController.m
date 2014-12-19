//
//  LoginWithFourSquareViewController.m
//  LoginWithFourSquare
//
//  Created by Ammad on 24/11/14.
//  Copyright (c) 2014 Ammad. All rights reserved.
//

#import "LoginWithFourSquareViewController.h"

@interface LoginWithFourSquareViewController ()

@end

@implementation LoginWithFourSquareViewController
@synthesize webview;

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSString *url = [NSString stringWithFormat:@"https://foursquare.com/oauth2/authenticate?client_id=TWIDNS0HIF3BCPKXVGWINBU2I1RGMYA2GW0WSEP5Y15QPPSB&response_type=code&redirect_uri=http://stylegerms.com"];
    
    [webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];

}

#pragma mark UIWebViewDelegate

- (BOOL)webView:(UIWebView*)webView shouldStartLoadWithRequest:(NSURLRequest*)request navigationType:(UIWebViewNavigationType)navigationType {
    //    [indicator startAnimating];
    if ([[[request URL] host] isEqualToString:@"stylegerms.com"]) {
        
        // Extract oauth_verifier from URL query
        NSString* verifier = nil;
        NSArray* urlParams = [[[request URL] query] componentsSeparatedByString:@"&"];
        for (NSString* param in urlParams) {
            NSArray* keyValue = [param componentsSeparatedByString:@"="];
            NSString* key = [keyValue objectAtIndex:0];
            if ([key isEqualToString:@"code"]) {
                verifier = [keyValue objectAtIndex:1];
                break;
            }
        }
        
        if (verifier) {
            NSString *data = [NSString stringWithFormat:@"client_id=TWIDNS0HIF3BCPKXVGWINBU2I1RGMYA2GW0WSEP5Y15QPPSB&client_secret=KLXIPFU2CVGOHZFIOL2CJAKWGDE4ZTCIG2TVMYBPDU5MJNJO&grant_type=authorization_code&redirect_uri=http://stylegerms.com&code=%@", verifier];
            
            
            NSString *url = [NSString stringWithFormat:@"https://foursquare.com/oauth2/access_token"];
            
            NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
            [request setHTTPMethod:@"POST"];
            [request setHTTPBody:[data dataUsingEncoding:NSUTF8StringEncoding]];
            NSURLConnection *theConnection=[[NSURLConnection alloc] initWithRequest:request delegate:self];
            receivedData = [[NSMutableData alloc] init];
        } else {
            // ERROR!
        }
        
        [webView removeFromSuperview];
        
        return NO;
    }
    return YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data

{
    [receivedData appendData:data];
}
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                    message:[NSString stringWithFormat:@"%@", error]
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
    
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSString *response = [[NSString alloc] initWithData:receivedData encoding:NSUTF8StringEncoding];
    SBJsonParser *jResponse = [[SBJsonParser alloc]init];
    NSDictionary *tokenData = [jResponse objectWithString:response];
    //  WebServiceSocket *dconnection = [[WebServiceSocket alloc] init];
    //   dconnection.delegate = self;
    
    NSString *pdata = [NSString stringWithFormat:@"type=3&token=%@&secret=123&login=%@", [tokenData objectForKey:@"access_token"], self.isLogin];
    //  NSString *pdata = [NSString stringWithFormat:@"type=3&token=%@&secret=123&login=%@",[tokenData accessToken.secret,self.isLogin];
    //  [dconnection fetch:1 withPostdata:pdata withGetData:@"" isSilent:NO];
    [self.navigationController popToRootViewControllerAnimated:YES];
    UIAlertView *alertView = [[UIAlertView alloc]
                              initWithTitle:@"Four Square Access TOken"
                              message:pdata
                              delegate:nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
    [alertView show];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
