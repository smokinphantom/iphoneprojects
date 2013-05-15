//
//  RatingViewController.m
//  Assignment5
//
//  Created by Mahmood Contractor on 11/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "RatingViewController.h"
#import "Assignment5AppDelegate.h"
#import "DetailViewController.h"
#import "SBJson.h"


@implementation RatingViewController
@synthesize textForRating;
@synthesize numberToStringForRating;


- (void)viewWillAppear:(BOOL)animated { 
    
    textForRating.text=@"";
       [super viewWillAppear:animated];
}



- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [ratingToBePosted appendData:data];
    SBJsonStreamParserStatus status = [parser parse:data];
    if (status == SBJsonStreamParserError) {
        NSLog(@"Parser error: %@", parser.error);
        //Handle error
    } else if (status == SBJsonStreamParserWaitingForData) {
        NSLog(@"Parser waiting for more data.");
        //Normal state
    }
}






- (void)connectionDidFinishLoading:(NSURLConnection *)connection {

}



- (IBAction)backgroundTap:(id)sender //method implemented to release the keyboard after background is tapped anywhere by the user.
{
    [textForRating resignFirstResponder];
    
}




- (IBAction)postRating {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"your rating has been posted successfully" message:@"" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil];
    
    
    
    NSMutableURLRequest *request3 = [[NSMutableURLRequest alloc] init];
    NSLog(@"http://bismarck.sdsu.edu/rateme/rating/%@/%@", numberToStringForRating,[textForRating text]);
    [request3 setURL: [NSURL URLWithString: [NSString stringWithFormat:@"http://bismarck.sdsu.edu/rateme/rating/%@/%@", numberToStringForRating,[textForRating text]]]];
    [request3 setHTTPMethod:@"POST"];
    [request3 setValue:@"text/plain" forHTTPHeaderField:@"Content-Type"];
    [request3 setHTTPBody:[[textForRating text] dataUsingEncoding:NSASCIIStringEncoding]];
    
    NSURLConnection *conn=[[NSURLConnection alloc] 
                           initWithRequest:request3 delegate:self];
    [request3 autorelease];
    [conn autorelease];
    
    [alert show];
    [alert release];
    [self viewWillAppear:YES];
    [textForRating resignFirstResponder];    
    
    
}

- (void)dealloc {
    [textForRating release];
    [numberToStringForRating release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setTextForRating:nil];
    self.numberToStringForRating=nil;
    [super viewDidUnload];
}

@end
