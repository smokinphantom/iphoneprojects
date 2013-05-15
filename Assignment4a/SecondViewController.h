//
//  SecondViewController.h
//  Assignment4a
//
//  Created by Mahmood Contractor on 10/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SecondViewController : UIViewController {
    UIWebView *webView;
    UITextField *webAddressBox;
}

@property (nonatomic, retain) IBOutlet UIWebView *webView;
@property (nonatomic, retain) IBOutlet UITextField *webAddressBox;
- (IBAction)webAddressBoxClick:(id)sender;

@end
