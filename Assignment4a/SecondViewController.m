//
//  SecondViewController.m
//  Assignment4a
//
//  Created by Mahmood Contractor on 10/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SecondViewController.h"

@implementation SecondViewController
@synthesize webView;
@synthesize webAddressBox;


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
/*- (void)viewDidLoad
{
    
    [super viewDidLoad];
}*/


//execute this method when enter is pressed after writing the web address.
- (IBAction)webAddressBoxClick:(id)sender {
    
    //get value from textbox and load it into the variable.
    NSString *urlAddress = webAddressBox.text;
    NSURL *url = [NSURL URLWithString:urlAddress];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    [webView loadRequest:requestObj];
    [webView setScalesPageToFit:YES];
    [self.view addSubview:webView];
    
}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload
{
    [self setWebView:nil];
    [self setWebAddressBox:nil];
    [super viewDidUnload];

    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)dealloc {
    [webView release];
    [webAddressBox release];
    [super dealloc];
}
@end
