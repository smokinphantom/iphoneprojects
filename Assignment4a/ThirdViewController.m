//
//  ThirdViewController.m
//  Assignment4a
//
//  Created by Mahmood Contractor on 10/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ThirdViewController.h"

@implementation ThirdViewController



@synthesize progressViewForFirstSegment;
@synthesize segmentedControl;
@synthesize switchButtonIndicator;
@synthesize activityIndicator;
@synthesize textViewForSecondSegment;
@synthesize internalTextView;
@synthesize alertViewForThirdSegment;



- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    
    //hide the 3 views when the main view is first loaded.
    progressViewForFirstSegment.hidden = YES;
    
    [super viewDidLoad];
    
    
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setSegmentedControl:nil];
      
    [self setProgressViewForFirstSegment:nil];
    [self setSwitchButtonIndicator:nil];
    [self setActivityIndicator:nil];
    [self setTextViewForSecondSegment:nil];
    [self setInternalTextView:nil];
    [self setAlertViewForThirdSegment:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
    [segmentedControl release];
    [progressViewForFirstSegment release];
    [switchButtonIndicator release];
    [activityIndicator release];
    [textViewForSecondSegment release];
    [internalTextView release];
    [alertViewForThirdSegment release];
           [super dealloc];
}

//any case is selected when one segment button is pressed according to its index value.
- (IBAction)ActionOnSegmentSwitch:(id)sender {
    switch ([sender selectedSegmentIndex]) {
        case 0:
            //hide text view when the progressview is loaded.
            progressViewForFirstSegment.hidden = NO;
            textViewForSecondSegment.hidden = YES;
            [internalTextView resignFirstResponder];
            break;
            
        case 1:
            //hide the alert view and show the progress and text view.
            progressViewForFirstSegment.hidden = NO;
            textViewForSecondSegment.hidden = NO;
            alertViewForThirdSegment.hidden = YES;
            break;
            
        case 2:
            //dont hide any views.
            progressViewForFirstSegment.hidden = NO;
            textViewForSecondSegment.hidden = NO;
            alertViewForThirdSegment.hidden = NO;
            [internalTextView resignFirstResponder];
            break;
            
        default:
            break;
    }
}

//reference--http://www.iphonedevsdk.com/forum/iphone-sdk-development/8707-adding-actions-alert-view.html executes when the alertbutton is pressed.

- (IBAction)AlertButton:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"do you like the iphone" message:@"" delegate:self cancelButtonTitle:@"yes" otherButtonTitles:@"NO", nil];
    [alert show];
    [alert release];
}

//controls the action when the switchindicator is switched on and off.
- (IBAction)SwitchIndicatorChange:(id)sender {
    if (switchButtonIndicator.on) {
        [activityIndicator stopAnimating];
    }
    else
   {
        [activityIndicator startAnimating];
    }
}

@end
